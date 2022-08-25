import 'package:flutter/material.dart';
import 'package:studhub/services/models.dart';

import '../../shared/screen_arguments.dart';

class ChatRoomBoxWidget extends StatelessWidget {
  final UserDetails user;
  final String roomId;
  final String lastMessage;
  const ChatRoomBoxWidget({
    Key? key,
    required this.user,
    required this.roomId,
    required this.lastMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
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
          subtitle: Text(
            lastMessage,
            overflow: TextOverflow.ellipsis,
          ),
          tileColor: Theme.of(context).highlightColor,
        ),
      ),
    );
  }
}
