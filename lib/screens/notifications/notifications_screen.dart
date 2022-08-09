import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:bulletin/bulletin.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: Column(
        children: [
          Bulletin(
            icon: const Icon(
              Icons.mic_outlined,
              size: 20,
            ),
            backgroundColor: Colors.black12,
            children: [
              BulletinItem(
                text:
                    "1. Welcome to StudHub! Take a look at your profile and see how you can impove it.",
                onTap: () {
                  Navigator.pushNamed(context, '/profile');
                },
              ),
            ],
          ),
          Bulletin(
            icon: const Icon(
              Icons.person_add,
              size: 20,
            ),
            backgroundColor: Colors.black12,
            children: [
              BulletinItem(
                text: "2. You have a friend request from @Andrei Voicu",
                onTap: () {
                  Navigator.pushNamed(context, '/profile');
                },
              ),
            ],
          ),
          Bulletin(
            icon: const Icon(
              Icons.mic_outlined,
              size: 20,
            ),
            backgroundColor: Colors.black12,
            children: [
              BulletinItem(
                text: "3. There is a new blog live, go check it out.",
                onTap: () {
                  Navigator.pushNamed(context, '/blog');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
