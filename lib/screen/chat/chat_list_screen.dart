// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'package:flutter/material.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:slost_only1/provider/auth_provider.dart';
import 'package:slost_only1/widget/base_app_bar.dart';
import 'package:slost_only1/widget/item_container.dart';
import 'package:slost_only1/model/member.dart' as slost_only1;

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => ChatListScreenState();
}

class ChatListScreenState extends State<ChatListScreen> {
  late GroupChannelCollection collection;

  bool hasMore = false;
  List<GroupChannel> channelList = [];

  @override
  void initState() {
    super.initState();
    AuthProvider authProvider = AuthProvider();
    slost_only1.Member me = authProvider.me!;
    collection = GroupChannelCollection(
      query: GroupChannelListQuery()
        ..userIdsIncludeFilter = [me.getSendbirdId()]
        ..order = GroupChannelListQueryOrder.latestLastMessage
        ..limit = 10,
      handler: MyGroupChannelCollectionHandler(this),
    )..loadMore();
  }

  @override
  void dispose() {
    collection.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBase(
        appBarObj: AppBar(),
        leadingBuilder: (context) => const Text("채팅",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
      ),
      body: Column(
        children: [
          Expanded(
              child: collection.channelList.isNotEmpty ? _list() : Container()),
          hasMore ? _moreButton() : Container(),
        ],
      ),
    );
  }

  Widget _list() {
    return ListView.builder(
      itemCount: channelList.length,
      itemBuilder: (BuildContext context, int index) {
        if (index >= channelList.length) return Container();

        final groupChannel = channelList[index];
        final userIds = groupChannel.members.map((e) => e.userId).toList();
        userIds.sort((a, b) => a.compareTo(b));
        final senderId = groupChannel.lastMessage?.sender?.userId ?? '';
        final profileUrl = groupChannel.lastMessage?.sender?.profileUrl ?? '';

        String? lastMessage;
        if (groupChannel.lastMessage != null) {
          if (groupChannel.lastMessage is FileMessage) {
            lastMessage = (groupChannel.lastMessage! as FileMessage).name ?? '';
          } else {
            lastMessage = groupChannel.lastMessage!.message;
          }
        }

        return GestureDetector(
          onDoubleTap: () {
            // Get.toNamed('/group_channel/update/${groupChannel.channelUrl}')
            //     ?.then((groupChannel) {
            //   if (groupChannel != null) {
            //     for (int index = 0; index < channelList.length; index++) {
            //       if (channelList[index].channelUrl ==
            //           groupChannel.channelUrl) {
            //         setState(() => channelList[index] = groupChannel);
            //         break;
            //       }
            //     }
            //   }
            // });
          },
          onLongPress: () async {
            await groupChannel.deleteChannel();
          },
          child: Column(
            children: [
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        groupChannel.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          userIds.toString(),
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: (lastMessage != null)
                          ? Row(
                              children: [
                                // Widgets.imageNetwork(
                                //     profileUrl, 16.0, Icons.account_circle),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 4.0),
                                    child: Text(
                                      '$senderId: $lastMessage',
                                      style: const TextStyle(fontSize: 12.0),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 16),
                      alignment: Alignment.centerRight,
                      child: Text(
                        DateTime.fromMillisecondsSinceEpoch(
                          groupChannel.createdAt! * 1000,
                        ).toString(),
                        style: const TextStyle(fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
                onTap: () {},
              ),
              const Divider(height: 1),
            ],
          ),
        );
      },
    );
  }

  Widget _moreButton() {
    return Container(
      width: double.maxFinite,
      height: 32.0,
      color: Colors.purple[200],
      child: IconButton(
        icon: const Icon(Icons.expand_more, size: 16.0),
        color: Colors.white,
        onPressed: () async {
          if (collection.hasMore && !collection.isLoading) {
            await collection.loadMore();
          }
        },
      ),
    );
  }

  void _refresh() {
    if (mounted) {
      setState(() {
        channelList = collection.channelList;
        hasMore = collection.hasMore;
      });
    }
  }
}

class MyGroupChannelCollectionHandler extends GroupChannelCollectionHandler {
  final ChatListScreenState state;

  MyGroupChannelCollectionHandler(this.state);

  @override
  void onChannelsAdded(
      GroupChannelContext context, List<GroupChannel> channels) {
    state._refresh();
  }

  @override
  void onChannelsUpdated(
      GroupChannelContext context, List<GroupChannel> channels) {
    state._refresh();
  }

  @override
  void onChannelsDeleted(
      GroupChannelContext context, List<String> deletedChannelUrls) {
    state._refresh();
  }
}

class ChatRoomItem extends StatelessWidget {
  const ChatRoomItem({super.key, required this.groupChannel});

  final GroupChannel groupChannel;

  String chatRoomImageUrl() {
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return ItemContainer(
        child: Row(
      children: [],
    ));
  }
}
