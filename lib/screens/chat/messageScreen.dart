// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:studhub/services/firestore.dart';
import 'package:studhub/services/models.dart';
import 'package:studhub/shared/loading.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userData = ModalRoute.of(context)!.settings.arguments as dynamic;
    List<Message> data = [];
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(userData.userPhoto),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(userData.userName),
            ),
          ],
        ),
      ),
      body: StreamBuilder<List<Message>>(
        stream: FirestoreService().streamMessages("zVaCiLINlqNrWLCVT3aP"),
        initialData: data,
        builder: (ctx, chatSnapsot) {
          if (chatSnapsot.connectionState == ConnectionState.waiting) {
            return const Center(child: LoadingScreen());
          } else if (chatSnapsot.hasData) {
            return ListView.builder(
              itemCount: chatSnapsot.data?.length,
              itemBuilder: (ctx, index) {
                return Text(chatSnapsot.data![index].text);
              },
            );
          } else {
            return const Text("An error has occured, please try again");
          }
        },
      ),
    );
  }
}
