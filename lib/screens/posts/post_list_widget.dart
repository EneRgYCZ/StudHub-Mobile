import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:studhub/services/models.dart';
import 'package:studhub/widgets/post/post_widget.dart';

import '../../shared/bottom_nav.dart';
import '../../widgets/sidemenu/build_sidemenu_widget.dart';

class PostListWidget extends StatelessWidget {
  final UserDetails user;
  final List<Post> posts;
  const PostListWidget({
    Key? key,
    required this.user,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
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
        menu: buildSideMenu(user, context),
        child: GestureDetector(
          onTap: () {
            final _state = _sideMenuKey.currentState;
            if (_state!.isOpened) {
              _state.closeSideMenu();
            }
          },
          child: Scaffold(
            appBar: PreferredSize(
              // To be refactored (AppBar)
              child: AppBar(
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
                        }
                      },
                    ),
                    Image.asset(
                      "assets/Logo_conver.png",
                      width: 120,
                      height: 120,
                    ),
                    if (user.notifications > 0)
                      Badge(
                        badgeContent: Text(user.notifications.toString()),
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
                    if (user.notifications == 0)
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
              ),
              preferredSize: const Size.fromHeight(60),
            ),
            body: ListView(
              primary: true,
              padding: const EdgeInsets.all(20.0),
              children: posts.map((posts) => PostWidget(post: posts)).toList(),
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
  }
}
