import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studhub/shared/loading.dart';
import 'package:studhub/services/models.dart';
import 'package:studhub/services/firestore.dart';
import 'package:studhub/widgets/profile/profile_body_widget.dart';
import 'package:studhub/widgets/profile/profile_appbar_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final passedUid = ModalRoute.of(context)!.settings.arguments as dynamic;
    var userExtraData = Provider.of<UserDetails>(context);
    var bio = userExtraData.bio;
    var userName = userExtraData.userName;
    var userPhoto = userExtraData.userPhoto;

    if (passedUid == userExtraData.uid || passedUid == null) {
      return Scaffold(
        appBar: PreferredSize(
          child: ProfileAppBarWidget(
            userName: userName,
            userPhoto: userPhoto,
            isUser: true,
          ),
          preferredSize: const Size.fromHeight(300),
        ),
        body: ProfileBodyWidget(
          bio: bio,
          isUser: true,
          skills: userExtraData.skills,
        ),
      );
    } else {
      return FutureBuilder(
        future: FirestoreService().getUserData(passedUid),
        initialData: UserDetails,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          }
          final UserDetails user = snapshot.data;
          return Scaffold(
            appBar: PreferredSize(
              child: ProfileAppBarWidget(
                userName: user.userName,
                userPhoto: user.userPhoto,
                isUser: false,
              ),
              preferredSize: const Size.fromHeight(300),
            ),
            body: ProfileBodyWidget(
              bio: user.bio,
              isUser: false,
              uid: passedUid,
              skills: user.skills,
            ),
          );
        },
      );
    }
  }
}
