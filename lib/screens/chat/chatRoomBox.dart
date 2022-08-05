// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:studhub/services/firestore.dart';
import 'package:studhub/shared/loading.dart';
import 'package:studhub/shared/screen_arguments.dart';

import '../../services/models.dart';

class ChatRoomBox extends StatelessWidget {
  final String uid;
  final String roomId;
  const ChatRoomBox({Key? key, required this.uid, required this.roomId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserInfo>(
      future: FirestoreService().getUserData(uid),
      initialData: UserInfo(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: LoadingScreen());
        } else if (!snapshot.hasData) {
          return const Center(child: Text("You have no contacts"));
        } else {
          var user = snapshot.data;
          return SizedBox(
            height: 70,
            child: ListTile(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/message_screen',
                  arguments: ScreenArguments(roomId, user),
                );
              },
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(user.userPhoto!),
              ),
              title: Text(user.userName),
              subtitle: const Text(" "),
            ),
          );
        }
      },
    );
  }
}
