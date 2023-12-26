import 'dart:async';

import 'package:chat_app/models/chat_messages.dart';

class ChatManager {
  static final List<ChatMessages> messages = [];
  static final StreamController<List<ChatMessages>> streamController =
      StreamController<List<ChatMessages>>.broadcast();

  static void addMessage(String sender, String message) {
    messages.add(ChatMessages(messages: message, sender: sender));
    streamController.sink.add(messages);
  }

  static List<ChatMessages> getAllMessages() {
    return List.from(messages);
  }
}
