import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studhub/services/auth.dart';
import 'package:studhub/services/firestore.dart';
import 'package:studhub/services/models.dart';

class ProfileBodyWidget extends StatelessWidget {
  final String bio;
  final bool? isUser;
  final String? uid;

  const ProfileBodyWidget({
    Key? key,
    required this.bio,
    this.isUser,
    this.uid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _userExtraData = Provider.of<UserInfo>(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (isUser != true)
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton.icon(
                  onPressed: () {
                    FirestoreService().createChatRoom(_userExtraData.uid, uid!);
                    Navigator.pushNamed(context, '/chat');
                  },
                  icon: const Icon(Icons.message),
                  label: const Text("Message"),
                ),
              ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                if (isUser!)
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
          ],
        ),
      ),
    );
  }
}
