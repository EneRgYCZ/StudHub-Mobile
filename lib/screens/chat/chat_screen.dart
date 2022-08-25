import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studhub/screens/chat/chat_room_box.dart';

import '../../services/firestore.dart';
import '../../services/models.dart';
import '../../shared/loading.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final userExtraData = Provider.of<UserDetails>(context);
    FirestoreService().updateNotificationCounter(userExtraData.uid, false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
      ),
      body: StreamBuilder<List<ChatRoom>>(
        stream: FirestoreService().streamChatRooms(userExtraData.uid),
        initialData: const [],
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: LoadingScreen());
          } else {
            var chatRoom = snapshot.data!;
            return ListView(
              primary: true,
              padding: const EdgeInsets.all(5.0),
              children: chatRoom
                  .map((chatRoom) => ChatRoomBox(chatRoom: chatRoom))
                  .toList(),
            );
          }
        },
      ),
    );
  }
}
