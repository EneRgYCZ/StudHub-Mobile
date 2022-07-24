import "package:flutter/material.dart";
import 'package:studhub/screens/chat/message_bubble_widget.dart';

import '../../services/firestore.dart';
import '../../services/models.dart';
import '../../shared/loading.dart';

class Messages extends StatelessWidget {
  final String roomId;
  const Messages({Key? key, required this.roomId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Message> data = [];
    return StreamBuilder<List<Message>>(
      stream: FirestoreService().streamMessages(roomId),
      initialData: data,
      builder: (ctx, chatSnapsot) {
        if (chatSnapsot.connectionState == ConnectionState.waiting) {
          return const Center(child: LoadingScreen());
        } else if (chatSnapsot.hasData) {
          return ListView.builder(
            reverse: true,
            itemCount: chatSnapsot.data?.length,
            itemBuilder: (ctx, index) {
              return MessageBubbleWidget(
                  message: chatSnapsot.data![index]
                      .text); //Text(chatSnapsot.data![index].text);
            },
          );
        } else {
          return const Text("An error has occured, please try again");
        }
      },
    );
  }
}
