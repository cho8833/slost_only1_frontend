// Copyright (c) 2023 Sendbird, Inc. All rights reserved.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final channelUrl = Get.parameters['channel_url']!;
  final itemScrollController = ItemScrollController();
  final textEditingController = TextEditingController();
  final FocusNode textFieldFocusNode = FocusNode();
  MessageCollection? collection;

  String title = '';
  bool hasPrevious = false;
  bool hasNext = false;
  List<BaseMessage> messageList = [];
  List<String> memberIdList = [];

  @override
  void initState() {
    super.initState();
    _initializeMessageCollection();
  }

  void _initializeMessageCollection() {
    GroupChannel.getChannel(channelUrl).then((channel) {

      MessageListParams params;
      params = MessageListParams()
        ..reverse = true
        ..previousResultSize = 0
        ..nextResultSize = 20;
      collection = MessageCollection(
        channel: channel,
        params: params,
        startingPoint: 0,
        handler: MyMessageCollectionHandler(this),
      )..initialize();

      setState(() {
        title = '${channel.name} (${messageList.length})';
        memberIdList = channel.members.map((member) => member.userId).toList();
        memberIdList.sort((a, b) => a.compareTo(b));
      });
    });
  }

  void _disposeMessageCollection() {
    collection?.dispose();
  }

  @override
  void dispose() {
    _disposeMessageCollection();
    textEditingController.dispose();
    textFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubPageAppBar(appBarObj: AppBar(), title: "채팅"),
      body: SafeArea(
        child: Column(
          children: [
            memberIdList.isNotEmpty ? _memberIdBox() : Container(),
            hasPrevious ? _previousButton() : Container(),
            Expanded(
              child: (collection != null && collection!.messageList.isNotEmpty)
                  ? _list()
                  : Container(),
            ),
            hasNext ? _nextButton() : Container(),
            _messageSender(),
          ],
        ),
      ),
    );
  }

  Widget _memberIdBox() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.maxFinite,
            child: Text(
              memberIdList.toString(),
              textAlign: TextAlign.left,
              style: const TextStyle(fontSize: 12.0, color: Colors.green),
            ),
          ),
        ),
        const Divider(height: 1),
      ],
    );
  }

  Widget _previousButton() {
    return Container(
      width: double.maxFinite,
      height: 32.0,
      color: Colors.purple[200],
      child: IconButton(
        icon: const Icon(Icons.expand_less, size: 16.0),
        color: Colors.white,
        onPressed: () async {
          if (collection != null) {
            if (collection!.params.reverse) {
              if (collection!.hasNext && !collection!.isLoading) {
                await collection!.loadNext();
              }
            } else {
              if (collection!.hasPrevious && !collection!.isLoading) {
                await collection!.loadPrevious();
              }
            }
          }

          setState(() {
            if (collection != null) {
              hasPrevious = collection!.params.reverse
                  ? collection!.hasNext
                  : collection!.hasPrevious;
              hasNext = collection!.params.reverse
                  ? collection!.hasPrevious
                  : collection!.hasNext;
            }
          });
        },
      ),
    );
  }

  Widget _list() {
    return ScrollablePositionedList.builder(
      physics: const ClampingScrollPhysics(),
      initialScrollIndex: (collection != null && collection!.params.reverse)
          ? 0
          : messageList.length - 1,
      itemScrollController: itemScrollController,
      itemCount: messageList.length,
      itemBuilder: (BuildContext context, int index) {
        if (index >= messageList.length) return Container();

        BaseMessage message = messageList[index];
        final unreadMembers = (collection != null)
            ? collection!.channel.getUnreadMembers(message)
            : [];

        return GestureDetector(
          onTap: () async {
            if (message.sendingStatus == SendingStatus.failed) {
              if (message is UserMessage) {
                await _showDialogToResendUserMessage(message);
              }
              // else if (message is FileMessage) {
              //   await GroupChannelSendFileMessagePage
              //       .showDialogToResendFileMessage(
              //     context: context,
              //     groupChannel: collection!.channel,
              //     message: message,
              //     goBackAfterSent: false,
              //   );
              // }
            }
          },
          onDoubleTap: () async {
            if (message is UserMessage) {
              final groupChannel = await GroupChannel.getChannel(channelUrl);
              Get.toNamed(
                  '/message/update/${groupChannel.channelType.toString()}/${groupChannel.channelUrl}/${message.messageId}')
                  ?.then((message) async {
                if (message != null) {
                  for (int index = 0; index < messageList.length; index++) {
                    if (messageList[index].messageId == message.messageId) {
                      setState(() => messageList[index] = message);
                      break;
                    }
                  }
                }
              });
            }
          },
          onLongPress: () async {
            if (message.sendingStatus == SendingStatus.succeeded) {
              await collection?.channel.deleteMessage(message.messageId);
            } else {
              await collection?.removeFailedMessages(messages: [message]);
            }
          },
          child: Column(
            children: [
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: (message is FileMessage)
                          ? Row(
                        children: [
                          // Widgets.imageNetwork(message.secureUrl, 16.0,
                          //     Icons.file_present),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text(
                                message.name ?? '',
                                style:
                                const TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      )
                          : Text(
                        message.message,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (message.sender != null && message.sender!.isCurrentUser)
                      Container(
                        alignment: Alignment.centerRight,
                        child: message.sendingStatus == SendingStatus.pending
                            ? const Icon(
                          Icons.pending,
                          size: 12.0,
                          color: Colors.grey,
                        )
                            : message.sendingStatus == SendingStatus.failed
                            ? const Icon(
                          Icons.refresh,
                          size: 12.0,
                          color: Colors.red,
                        )
                            : Text(
                          unreadMembers.isNotEmpty
                              ? '${unreadMembers.length}'
                              : '',
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.green,
                          ),
                        ),
                      ),
                  ],
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.account_circle, size: 16),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text(
                          message.sender?.userId ?? '',
                          style: const TextStyle(fontSize: 12.0),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 16),
                      alignment: Alignment.centerRight,
                      child: Text(
                        DateTime.fromMillisecondsSinceEpoch(message.createdAt)
                            .toString(),
                        style: const TextStyle(fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
            ],
          ),
        );
      },
    );
  }

  Widget _nextButton() {
    return Container(
      width: double.maxFinite,
      height: 32.0,
      color: Colors.purple[200],
      child: IconButton(
        icon: const Icon(Icons.expand_more, size: 16.0),
        color: Colors.white,
        onPressed: () async {
          if (collection != null) {
            if (collection!.params.reverse) {
              if (collection!.hasPrevious && !collection!.isLoading) {
                await collection!.loadPrevious();
              }
            } else {
              if (collection!.hasNext && !collection!.isLoading) {
                await collection!.loadNext();
              }
            }
          }

          setState(() {
            if (collection != null) {
              hasPrevious = collection!.params.reverse
                  ? collection!.hasNext
                  : collection!.hasPrevious;
              hasNext = collection!.params.reverse
                  ? collection!.hasPrevious
                  : collection!.hasNext;
            }
          });
        },
      ),
    );
  }

  Widget _messageSender() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(controller: textEditingController,)
          ),
          const SizedBox(width: 8.0),
          ElevatedButton(
            onPressed: () {
              textFieldFocusNode.unfocus();

              if (textEditingController.value.text.isEmpty) {
                return;
              }

              collection?.channel.sendUserMessage(
                UserMessageCreateParams(
                  message: textEditingController.value.text,
                ),
                handler: (UserMessage message, SendbirdException? e) async {
                  if (e != null) {
                    if (!SendbirdChat.getOptions().useCollectionCaching) {
                      await _showDialogToResendUserMessage(message);
                    }
                  }
                },
              );

              textEditingController.clear();
            },
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }

  Future<void> _showDialogToResendUserMessage(UserMessage message) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            content: Text('Resend: ${message.message}'),
            actions: [
              TextButton(
                onPressed: () {
                  collection?.channel.resendUserMessage(
                    message,
                    handler: (message, e) async {
                      if (e != null) {
                        await _showDialogToResendUserMessage(message);
                      }
                    },
                  );

                  Get.back();
                },
                child: const Text('Yes'),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('No'),
              ),
            ],
          );
        });
  }

  void _refresh() async {
    if (mounted) {
      setState(() {
        if (collection != null) {
          messageList = collection!.messageList;
          title = '${collection!.channel.name} (${messageList.length})';
          hasPrevious = collection!.params.reverse
              ? collection!.hasNext
              : collection!.hasPrevious;
          hasNext = collection!.params.reverse
              ? collection!.hasPrevious
              : collection!.hasNext;
          memberIdList = collection!.channel.members
              .map((member) => member.userId)
              .toList();
          memberIdList.sort((a, b) => a.compareTo(b));
        }
      });
    }
  }

  void _scrollToAddedMessages(CollectionEventSource eventSource) async {
    if (collection == null || collection!.messageList.length <= 1) return;

    final reverse = collection!.params.reverse;
    final previous =
    (eventSource == CollectionEventSource.messageCacheLoadPrevious ||
        eventSource == CollectionEventSource.messageLoadPrevious);

    final int index;
    if ((reverse && previous) || (!reverse && !previous)) {
      index = collection!.messageList.length - 1;
    } else {
      index = 0;
    }

    while (!itemScrollController.isAttached) {
      await Future.delayed(const Duration(milliseconds: 1));
    }

    itemScrollController.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.fastOutSlowIn,
    );
  }
}

class MyMessageCollectionHandler extends MessageCollectionHandler {
  final ChatScreenState _state;
  bool isScrolling = false;

  MyMessageCollectionHandler(this._state);

  @override
  void onMessagesAdded(MessageContext context, GroupChannel channel,
      List<BaseMessage> messages) async {
    _state._refresh();
    _state.collection?.markAsRead(context);

    if (context.collectionEventSource !=
        CollectionEventSource.messageCacheInitialize &&
        context.collectionEventSource !=
            CollectionEventSource.messageInitialize) {
      if (!isScrolling) {
        isScrolling = true;
        Future.delayed(const Duration(milliseconds: 100), () {
          _state._scrollToAddedMessages(context.collectionEventSource);
          isScrolling = false;
        });
      }
    }
  }

  @override
  void onMessagesUpdated(MessageContext context, GroupChannel channel,
      List<BaseMessage> messages) {
    _state._refresh();
  }

  @override
  void onMessagesDeleted(MessageContext context, GroupChannel channel,
      List<BaseMessage> messages) {
    _state._refresh();
  }

  @override
  void onChannelUpdated(GroupChannelContext context, GroupChannel channel) {
    _state._refresh();
  }

  @override
  void onChannelDeleted(GroupChannelContext context, String deletedChannelUrl) {
    Get.back();
  }

  @override
  void onHugeGapDetected() {
    _state._disposeMessageCollection();
    _state._initializeMessageCollection();
  }
}
