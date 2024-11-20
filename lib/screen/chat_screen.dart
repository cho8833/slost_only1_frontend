import 'package:flutter/material.dart';
import 'package:sendbird_uikit/sendbird_uikit.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SBUGroupChannelListScreen(
          onCreateButtonClicked: () {
            moveToGroupChannelCreateScreen(context);
          },
          onListItemClicked: (channel) {
            moveToGroupChannelScreen(context, channel.channelUrl);
          },
        )
      ),
    );
  }
  void moveToGroupChannelCreateScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          body: SafeArea(
            child: SBUGroupChannelCreateScreen(
              onChannelCreated: (channel) {
                moveToGroupChannelScreen(context, channel.channelUrl);
              },
            ),
          ),
        ),
      ),
    );
  }

  void moveToGroupChannelScreen(BuildContext context, String channelUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          body: SafeArea(
            child: SBUGroupChannelScreen(
              channelUrl: channelUrl,
            ),
          ),
        ),
      ),
    );
  }
}
