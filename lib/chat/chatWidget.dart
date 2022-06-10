import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../services/firestore.dart';

class ChatWidget extends StatefulWidget {
  final dynamic user;
  const ChatWidget({Key? key, this.user}) : super(key: key);

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  final List<types.Message> _messages = [];

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: types.User(id: widget.user.uid),
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: widget.user.uid,
      text: message.text,
    );

    FirestoreService().uploadMessage(textMessage.id, textMessage.text);
    _addMessage(textMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Chat(
      messages: _messages,
      onSendPressed: _handleSendPressed,
      user: types.User(id: widget.user.uid),
    );
  }
}
