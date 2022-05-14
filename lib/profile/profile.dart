import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studhub/services/auth.dart';
import 'package:studhub/services/models.dart';

var user = AuthService().user!;

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userExtraData = Provider.of<UserExtraInfo>(context);
    var bio = userExtraData.bio;

    return Scaffold(
      appBar: const PreferredSize(
        child: ProfileAppBar(),
        preferredSize: Size.fromHeight(180),
      ),
      body: ProfileBody(bio: bio),
    );
  }
}

class ProfileBody extends StatelessWidget {
  final String bio;

  const ProfileBody({Key? key, required this.bio}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Text(bio),
      ]),
    );
  }
}

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.greenAccent,
      flexibleSpace: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: Colors.black)),
              child: Center(
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      image: NetworkImage(
                        "${user.photoURL}",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${user.displayName}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}