import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studhub/services/auth.dart';
import 'package:studhub/services/models.dart';
import 'package:studhub/services/firestore.dart';
import 'package:flutter_tags_x/flutter_tags_x.dart';

class ProfileBodyWidget extends StatelessWidget {
  final String bio;
  final bool? isUser;
  final String? uid;
  final List skills;

  const ProfileBodyWidget({
    Key? key,
    required this.bio,
    required this.skills,
    this.isUser,
    this.uid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userExtraData = Provider.of<UserDetails>(context);
    final FirebaseMessaging fbm = FirebaseMessaging.instance;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Tags(
                      itemCount: skills.length,
                      itemBuilder: (int index) {
                        return Tooltip(
                          message: skills[index],
                          child: ItemTags(
                            textActiveColor: Colors.white,
                            activeColor: Colors.blueGrey,
                            color: Colors.blueGrey,
                            textColor: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            index: index,
                            title: skills[index],
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              if (isUser != true &&
                  userExtraData.contacts.contains(uid) == false)
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      var roomId = FirestoreService()
                          .createChatRoom(userExtraData.uid, uid!);
                      FirestoreService().updateUserContacts(uid!);
                      Navigator.pushNamed(context, '/chat');
                      roomId.then(
                        (id) => fbm.subscribeToTopic(id),
                      );
                    },
                    icon: const Icon(Icons.message),
                    label: const Text("Message"),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Column(
                  children: [
                    const Text("Bio: "),
                    Text(
                      bio,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (isUser!)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
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
            ),
        ],
      ),
    );
  }
}
