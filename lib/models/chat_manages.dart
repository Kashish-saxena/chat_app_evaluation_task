import 'dart:async';

import 'package:chat_app/models/chat_messages.dart';

class ChatManager {
  static final List<ChatMessage> _messages = [];
  static final StreamController<List<ChatMessage>> _streamController =
      StreamController<List<ChatMessage>>.broadcast();

  static void addMessage(String sender, String message) {
    _messages.add(ChatMessage(text: message, sender: sender));
    _streamController.sink.add(_messages);
  }

  static Stream<List<ChatMessage>> getMessagesStream() {
    return _streamController.stream.asBroadcastStream();
  }

  static List<ChatMessage> getAllMessages() {
    return List.from(_messages);
  }
}