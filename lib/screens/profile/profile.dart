import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studhub/services/auth.dart';
import 'package:studhub/services/models.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userExtraData = Provider.of<UserInfo>(context);
    var bio = userExtraData.bio;
    var userName = userExtraData.userName;
    var userPhoto = userExtraData.userPhoto;

    return Scaffold(
      appBar: PreferredSize(
        child: ProfileAppBar(
          userName: userName,
          userPhoto: userPhoto,
        ),
        preferredSize: const Size.fromHeight(180),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Text(
              bio,
              style: Theme.of(context).textTheme.bodyText1,
            ),
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
}

class ProfileAppBar extends StatelessWidget {
  final String userName;
  final String userPhoto;

  const ProfileAppBar(
      {Key? key, required this.userName, required this.userPhoto})
      : super(key: key);

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
                        userPhoto,
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
              userName,
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
