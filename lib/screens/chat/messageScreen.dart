// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:studhub/screens/chat/messages.dart';
import 'package:studhub/shared/screenArguments.dart';
import 'package:studhub/screens/chat/new_message.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final passedData =
        ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(passedData.userData.userPhoto),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(passedData.userData.userName),
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            Expanded(
              child: Messages(roomId: passedData.roomId),
            ),
            NewMessage(roomId: passedData.roomId)
          ],
        ),
      ),
    );
  }
}