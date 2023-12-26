import 'package:chat_app/utils/chat_manager.dart';
import 'package:chat_app/models/chat_messages.dart';
import 'package:chat_app/utils/color_constants.dart';
import 'package:chat_app/utils/string_constants.dart';
import 'package:chat_app/utils/text_styles.dart';
import 'package:chat_app/widgets/input_message_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChatScreen extends StatelessWidget {
  final String currentUser;
  ChatScreen({Key? key, required this.currentUser}) : super(key: key);

  TextEditingController messageController = TextEditingController();

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
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder(
              stream: ChatManager.streamController.stream,
              initialData: ChatManager.getAllMessages(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<ChatMessages> messages = snapshot.data ?? [];
                  return ListView.builder(

                      // reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        ChatMessages message = messages[index];
                        bool isMessageFromSender = message.sender == "sender";
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
                                  message.messages ?? "",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                }
                return Container();
              }),
        ),
        InputMessageWidget(
            messageController: messageController, currentUser: currentUser),
      ],
    );
  }
}
