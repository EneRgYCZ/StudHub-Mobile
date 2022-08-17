import 'package:flutter/material.dart';
import 'package:studhub/services/firestore.dart';
import 'package:studhub/services/models.dart';

import '../shared/loading.dart';

class CommentBoxWidget extends StatelessWidget {
  final String postId;
  const CommentBoxWidget({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PostComment>>(
      future: FirestoreService().getPostComments(postId),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData) {
          return const Center(child: Text("No comments..."));
        } else {
          final List<PostComment> comments = snapshot.data;
          return SizedBox(
            height: 210,
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(comments[index].userName),
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                        image: NetworkImage(
                          comments[index].userPhoto,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  subtitle: Text(comments[index].text),
                );
              },
            ),
          );
        }
      },
    );
  }
}
