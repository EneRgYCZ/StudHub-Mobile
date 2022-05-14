import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studhub/shared/bottom_nav.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          child: MainAppBar(), preferredSize: Size.fromHeight(60)),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            PostCard(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/post_create');
        },
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

class PostCard extends StatelessWidget {
  const PostCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(children: [
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          width: double.infinity,
          height: 280,
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 2,
              blurRadius: 15,
              offset: Offset(0, 1),
            )
          ]),
        )
      ]),
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
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "StudHub",
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              FontAwesomeIcons.bell,
              color: Colors.black,
              size: 25,
            ),
          ),
        ],
      ),
    );
  }
}
