import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:studhub/services/models.dart';

import '../../services/auth.dart';

class EmailVerificaionScreen extends StatelessWidget {
  const EmailVerificaionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _user = Provider.of<UserInfo>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text("You now have to verify your account"),
          TextButton(
              onPressed: () {
                AuthService().user!.sendEmailVerification();
                AuthService().user!.reload();
              },
              child: const Text("Send verification email")),
          _user.isVerified
              ? Column(
                  children: [
                    Lottie.network(
                      "https://assets1.lottiefiles.com/packages/lf20_2mm5zqab.json",
                      repeat: false,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.done),
                      label: const Text("Done"),
                    )
                  ],
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
