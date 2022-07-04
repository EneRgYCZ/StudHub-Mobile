// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:studhub/services/firestore.dart';
import 'package:studhub/shared/loading.dart';

import '../../services/models.dart';

class ChatRoomBox extends StatelessWidget {
  final String uid;
  const ChatRoomBox({Key? key, required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserInfo>(
      future: FirestoreService().getUserData(uid),
      initialData: UserInfo(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: LoadingScreen());
        } else {
          final user = snapshot.data;
          return SizedBox(
            height: 70,
            child: ListTile(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/message_screen',
                  arguments: user,
                );
              },
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(user.userPhoto!),
              ),
              title: Text(user.userName),
              subtitle: const Text("Lsere ba muie idioata"),
            ),
          );
        }
      },
    );
  }
}
