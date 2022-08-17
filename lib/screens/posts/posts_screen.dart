import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studhub/services/models.dart';
import 'package:studhub/shared/bottom_nav.dart';
import 'package:studhub/services/firestore.dart';
import 'package:studhub/widgets/post_widget.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../shared/error.dart';
import '../../shared/loading.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();

class _PostsScreenState extends State<PostsScreen> {
  @override
  void initState() {
    super.initState();
    final FirebaseMessaging _fbm = FirebaseMessaging.instance;
    _fbm.requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    var userExtraData = Provider.of<UserInfo>(context);
    FirebaseMessaging.onMessage.listen((event) {
      FirestoreService().updateNotificationCounter(userExtraData.uid, true);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      Navigator.pushNamed(context, '/chat');
    });
    return StreamBuilder<List<Post>>(
      stream: FirestoreService().streamPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return Center(
            child: ErrorMessage(message: snapshot.error.toString()),
          );
        } else if (snapshot.hasData) {
          var posts = snapshot.data!;
          return GestureDetector(
            onTap: () {
              final _state = _sideMenuKey.currentState;
              if (_state!.isOpened) {
                _state.closeSideMenu();
              }
            },
            child: SideMenu(
              background: Colors.orange,
              key: _sideMenuKey,
              type: SideMenuType.slideNRotate,
              menu: buildSideMenu(),
              child: GestureDetector(
                onTap: () {
                  final _state = _sideMenuKey.currentState;
                  if (_state!.isOpened) {
                    _state.closeSideMenu();
                  }
                },
                child: Scaffold(
                  appBar: const PreferredSize(
                    child: MainAppBar(),
                    preferredSize: Size.fromHeight(60),
                  ),
                  body: ListView(
                    primary: true,
                    padding: const EdgeInsets.all(20.0),
                    children:
                        posts.map((posts) => PostWidget(post: posts)).toList(),
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
                ),
              ),
            ),
          );
        } else {
          return const Text('No posts found in database.');
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
    var userExtraData = Provider.of<UserInfo>(context);
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.black38,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              final _state = _sideMenuKey.currentState;
              if (_state!.isOpened) {
                _state.closeSideMenu();
              } else {
                _state.openSideMenu();
              } // open side menu
            },
          ),
          Image.asset(
            "assets/Logo_conver.png",
            width: 120,
            height: 120,
          ),
          if (userExtraData.notifications > 0)
            Badge(
              badgeContent: Text(userExtraData.notifications.toString()),
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/chat');
                },
                icon: const Icon(
                  FontAwesomeIcons.comment,
                  color: Colors.orange,
                  size: 25,
                ),
              ),
            ),
          if (userExtraData.notifications == 0)
            IconButton(
              icon: const Icon(
                FontAwesomeIcons.comment,
                color: Colors.orange,
                size: 25,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/chat');
              },
            )
        ],
      ),
    );
  }
}

Widget buildSideMenu() {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(50),
    child: Column(children: [
      ListTile(
        onTap: () {},
        leading: const Icon(Icons.home, size: 20.0, color: Colors.black),
        title: const Text("1"),
        textColor: Colors.black,
        dense: true,
      ),
      ListTile(
        onTap: () {},
        leading:
            const Icon(Icons.verified_user, size: 20.0, color: Colors.black),
        title: const Text("2"),
        textColor: Colors.black,
        dense: true,
      ),
    ]),
  );
}
