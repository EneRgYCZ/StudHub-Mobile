import 'package:flutter/material.dart';
import 'package:studhub/services/auth.dart';

class ProfileBodyWidget extends StatelessWidget {
  final String bio;
  final bool? isUser;

  const ProfileBodyWidget({
    Key? key,
    required this.bio,
    this.isUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Column(
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
      ),
    );
  }
}
