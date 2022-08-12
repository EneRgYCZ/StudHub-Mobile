import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studhub/services/firestore.dart';
import 'package:studhub/services/models.dart';
import 'package:studhub/widgets/profile_body_widget.dart';
import 'package:studhub/widgets/profile_appbar_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final passedUid = ModalRoute.of(context)!.settings.arguments as dynamic;
    var _userExtraData = Provider.of<UserInfo>(context);
    var _bio = _userExtraData.bio;
    var _userName = _userExtraData.userName;
    var _userPhoto = _userExtraData.userPhoto;

    if (passedUid == _userExtraData.uid || passedUid == null) {
      return Scaffold(
        appBar: PreferredSize(
          child: ProfileAppBarWidget(
            userName: _userName,
            userPhoto: _userPhoto,
            isUser: true,
          ),
          preferredSize: const Size.fromHeight(300),
        ),
        body: ProfileBodyWidget(
          bio: _bio,
          isUser: true,
        ),
      );
    } else {
      return FutureBuilder(
        future: FirestoreService().getUserData(passedUid),
        initialData: UserInfo,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          UserInfo _user = snapshot.data;
          return Scaffold(
            appBar: PreferredSize(
              child: ProfileAppBarWidget(
                userName: _user.userName,
                userPhoto: _user.userPhoto,
                isUser: false,
              ),
              preferredSize: const Size.fromHeight(300),
            ),
            body: ProfileBodyWidget(
              bio: _user.bio,
              isUser: false,
            ),
          );
        },
      );
    }
  }
}
