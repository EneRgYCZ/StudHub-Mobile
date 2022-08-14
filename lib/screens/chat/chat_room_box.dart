import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studhub/shared/loading.dart';
import 'package:studhub/services/firestore.dart';
import 'package:studhub/widgets/chat_room_box_widget.dart';

import '../../services/models.dart';

class ChatRoomBox extends StatelessWidget {
  final ChatRoom chatRoom;
  const ChatRoomBox({Key? key, required this.chatRoom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _otherUserUid;
    final userExtraData = Provider.of<UserInfo>(context);
    if (chatRoom.participants[0] == userExtraData.uid) {
      _otherUserUid = chatRoom.participants[1];
    } else {
      _otherUserUid = chatRoom.participants[0];
    }
    return FutureBuilder<UserInfo>(
      future: FirestoreService().getUserData(_otherUserUid),
      initialData: UserInfo(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: LoadingScreen());
        } else if (!snapshot.hasData) {
          return const Center(child: Text("You have no contacts"));
        } else {
          var user = snapshot.data;
          return ChatRoomBoxWidget(
            user: user,
            roomId: chatRoom.roomId,
            lastMessage: chatRoom.text,
          );
        }
      },
    );
  }
}
