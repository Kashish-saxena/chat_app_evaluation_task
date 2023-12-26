import 'package:chat_app/utils/chat_manager.dart';
import 'package:chat_app/utils/color_constants.dart';
import 'package:chat_app/utils/string_constants.dart';
import 'package:chat_app/utils/text_styles.dart';
import 'package:flutter/material.dart';

class InputMessageWidget extends StatelessWidget {
  const InputMessageWidget({
    super.key,
    required this.messageController,
    required this.currentUser,
  });

  final TextEditingController messageController;
  final String currentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Stack(
        children: [
          TextField(
            onEditingComplete: () {
              String newMessage = messageController.text;
              if (newMessage.isNotEmpty) {
                ChatManager.addMessage(currentUser, newMessage);
                messageController.clear();
              }
            },
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
                String newMessage = messageController.text;
                if (newMessage.isNotEmpty) {
                  ChatManager.addMessage(currentUser, newMessage);
                  messageController.clear();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
