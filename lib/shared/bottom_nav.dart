import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: SizedBox(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Badge(
              badgeContent: const Text('1'),
              child: IconButton(
                iconSize: 30.0,
                padding: const EdgeInsets.only(left: 28.0),
                icon: const Icon(
                  FontAwesomeIcons.magento,
                  color: Colors.orange,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/blog');
                },
              ),
            ),
            IconButton(
              iconSize: 30.0,
              padding: const EdgeInsets.only(right: 28.0),
              icon: const Icon(FontAwesomeIcons.search, color: Colors.orange),
              onPressed: () {
                Navigator.pushNamed(context, '/search', arguments: "");
              },
            ),
            Badge(
              badgeContent: const Text('3'),
              child: IconButton(
                iconSize: 30.0,
                padding: const EdgeInsets.only(left: 28.0),
                icon: const Icon(FontAwesomeIcons.bell, color: Colors.orange),
                onPressed: () {
                  Navigator.pushNamed(context, '/notifications');
                },
              ),
            ),
            IconButton(
              iconSize: 30.0,
              padding: const EdgeInsets.only(right: 28.0),
              icon: const Icon(FontAwesomeIcons.user, color: Colors.orange),
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
          ],
        ),
      ),
    );
  }
}
