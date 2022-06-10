// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:studhub/chat/chatWidget.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as dynamic;
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(args.userPhoto),
              ),
              Text(args.userName),
            ],
          ),
        ),
        body: ChatWidget(user: args));
  }
}
