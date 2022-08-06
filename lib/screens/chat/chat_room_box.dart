import 'package:flutter/material.dart';
import 'package:studhub/shared/loading.dart';
import 'package:studhub/services/firestore.dart';
import 'package:studhub/widgets/chat_room_box_widget.dart';

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
          return ChatRoomBoxWidget(user: user, roomId: roomId);
        }
      },
    );
  }
}
