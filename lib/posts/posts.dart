import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studhub/posts/post_item.dart';
import 'package:studhub/services/firestore.dart';
import 'package:studhub/services/models.dart';
import 'package:studhub/shared/bottom_nav.dart';

import '../shared/error.dart';
import '../shared/loading.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: FirestoreService().getPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return Center(
            child: ErrorMessage(message: snapshot.error.toString()),
          );
        } else if (snapshot.hasData) {
          var posts = snapshot.data!;

          return Scaffold(
            appBar: const PreferredSize(
              child: MainAppBar(),
              preferredSize: Size.fromHeight(60),
            ),
            body: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20.0),
              crossAxisCount: 1,
              crossAxisSpacing: 10.0,
              children: posts.map((posts) => PostItem(post: posts)).toList(),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.orange,
              child: const Icon(FontAwesomeIcons.plus),
              onPressed: () {
                Navigator.pushNamed(context, '/post_create');
              },
            ),
            bottomNavigationBar: const BottomNavBar(),
          );
        } else {
          return const Text('No topics found in database. Check it');
        }
      },
    );
  }
}

class MainAppBar extends StatelessWidget {
  const MainAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.black38,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            "assets/Logo.png",
            width: 120,
            height: 120,
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/chat');
            },
            icon: const Icon(
              FontAwesomeIcons.comment,
              color: Colors.orange,
              size: 25,
            ),
          ),
        ],
      ),
    );
  }
}
