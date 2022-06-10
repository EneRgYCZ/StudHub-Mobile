// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studhub/services/firestore.dart';

import '../services/models.dart';

class ChatBodyWidget extends StatelessWidget {
  const ChatBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userExtraData = Provider.of<UserInfo>(context);
    return FutureBuilder<List<UserInfo>>(
      future: FirestoreService().getUserData(userExtraData.userContacts),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: snapshot.data.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              final user = snapshot.data[index];
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
                    backgroundImage: NetworkImage(user.userPhoto),
                  ),
                  title: Text(user.userName),
                  subtitle: const Text("Lsere ba muie idioata"),
                ),
              );
            },
          );
        }
      },
    );
  }
}
