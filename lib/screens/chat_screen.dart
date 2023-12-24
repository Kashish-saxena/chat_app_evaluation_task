import 'dart:async';

import 'package:chat_app/models/chat_messages.dart';
import 'package:chat_app/utils/color_constants.dart';
import 'package:chat_app/utils/string_constants.dart';
import 'package:chat_app/utils/text_styles.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String? currentUser;
  const ChatScreen({Key? key, this.currentUser}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();
  late StreamController<ChatMessage> chatController;
  List<ChatMessage> chatMessages = [];

  @override
  void initState() {
    super.initState();
    chatController = StreamController<ChatMessage>();
  }

  void _sendMessage() {
    String messageText = messageController.text;

    ChatMessage message = ChatMessage(message: messageText);
    
    if(messageText.isNotEmpty){
    chatController.add(message);
    messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.blue38419D,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: ColorConstants.blue200E3A,
        title: const Text(
          StringConstants.chatScreen,
          style: TextStyles.textStyleFont20Weight600,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
            stream: chatController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                chatMessages.add(snapshot.data??ChatMessage(message: ""));

                return ListView.builder(
                  itemCount: chatMessages.length,
                  itemBuilder: (context, index) {
                    ChatMessage chatItem = chatMessages[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: widget.currentUser == "sender"
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(15),
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
            margin: const EdgeInsets.all(10),
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
                      hintText: StringConstants.message,
                      hintStyle: TextStyles.textStyleFont14Weight400),
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
