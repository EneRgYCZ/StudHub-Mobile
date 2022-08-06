import 'package:flutter/material.dart';
import 'package:studhub/services/models.dart';

import '../shared/screen_arguments.dart';

class ChatRoomBoxWidget extends StatelessWidget {
  final UserInfo user;
  final String roomId;
  const ChatRoomBoxWidget({Key? key, required this.user, required this.roomId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          backgroundImage: NetworkImage(user.userPhoto),
        ),
        title: Text(user.userName),
        subtitle: const Text(" "),
      ),
    );
  }
}
