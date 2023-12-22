import 'dart:async';

import 'package:chat_app/utils/color_constants.dart';
import 'package:flutter/material.dart';

class ChatMessage {
  String message;

  ChatMessage({required this.message});
}

class ChatScreen extends StatefulWidget {
  final String? currentUser;

  const ChatScreen({Key? key, this.currentUser}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();

  final List<ChatMessage> chatMessages = [];
  late StreamController<ChatMessage> chatController;

  @override
  void initState() {
    super.initState();
    chatController = StreamController<ChatMessage>();
  }

  void _sendMessage() {
    String messageText = messageController.text;
    ChatMessage message = ChatMessage(message: messageText);
    chatController.add(message);
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.blue38419D,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: ColorConstants.blue200E3A,
        title: const Text(
          'ChatScreen',
          style: TextStyle(color: ColorConstants.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: chatController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  chatMessages.add(snapshot.data ?? ChatMessage(message: ""));

                  return ListView.builder(
                    itemCount: chatMessages.length,
                    itemBuilder: (context, index) {
                      ChatMessage chatItem = chatMessages[index];
                      return Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: widget.currentUser == "sender"
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: widget.currentUser == "sender"
                                    ? ColorConstants.blue3887BE
                                    : ColorConstants.blue52D3D8,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                chatItem.message,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
                return Container();
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Stack(
              children: [
                TextField(
                  controller: messageController,
                  style: const TextStyle(color: ColorConstants.white),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: ColorConstants.blue200E3A,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Write a message...',
                      hintStyle: const TextStyle(color: ColorConstants.white)),
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: IconButton(
                    icon: const Icon(
                      Icons.send,
                      color: ColorConstants.white,
                    ),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
