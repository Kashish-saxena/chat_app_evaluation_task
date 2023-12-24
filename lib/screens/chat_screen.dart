import 'package:chat_app/models/chat_manages.dart';
import 'package:chat_app/models/chat_messages.dart';
import 'package:chat_app/utils/color_constants.dart';
import 'package:chat_app/utils/string_constants.dart';
import 'package:chat_app/utils/text_styles.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String currentUser;
  const ChatScreen({Key? key, required this.currentUser}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();

  ChatManager streams = ChatManager();

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
            child: StreamBuilder<List<ChatMessage>>(
              stream: ChatManager.getMessagesStream(),
              initialData: ChatManager.getAllMessages(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<ChatMessage> messages = snapshot.data ?? [];
                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final ChatMessage message = messages[index];
                      final bool isMessageFromSender =
                          message.sender == "sender";
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: isMessageFromSender
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: isMessageFromSender
                                    ? ColorConstants.blue3887BE
                                    : ColorConstants.blue52D3D8,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                message.text,
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
                } else {
                  return Container();
                }
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
                    onPressed: () {
                      String newMessage = messageController.text.trim();
                      if (newMessage.isNotEmpty) {
                        ChatManager.addMessage(widget.currentUser, newMessage);
                        messageController.clear();
                      }
                    },
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
