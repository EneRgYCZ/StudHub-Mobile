import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../services/auth.dart';
import '../../services/models.dart';

Widget buildSideMenu(UserDetails user, BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(50),
    child: Column(
      children: [
        Center(
          child: Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(90),
              image: DecorationImage(
                image: NetworkImage(
                  user.userPhoto,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Text(
          user.userName,
          style: const TextStyle(
            fontSize: 25,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, '/profile');
          },
          leading: const Icon(FontAwesomeIcons.user,
              size: 20.0, color: Colors.black),
          title: const Text("Account"),
          textColor: Colors.black,
          dense: true,
        ),
        ListTile(
          onTap: () {},
          leading: const Icon(Icons.favorite, size: 20.0, color: Colors.black),
          title: const Text("Favorite"),
          textColor: Colors.black,
          dense: true,
        ),
        ListTile(
          onTap: () {},
          leading: const Icon(Icons.comment, size: 20.0, color: Colors.black),
          title: const Text("Blog"),
          textColor: Colors.black,
          dense: true,
        ),
        const Divider(
          color: Colors.black,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: ElevatedButton(
            child: const Text('Logout'),
            onPressed: () async {
              await AuthService().signOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/', (route) => false);
            },
          ),
        ),
      ],
    ),
  );
}
