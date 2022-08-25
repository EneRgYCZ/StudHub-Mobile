import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studhub/services/auth.dart';
import 'package:studhub/services/models.dart';
import 'package:studhub/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:studhub/screens/login/login_screen.dart';
import 'package:studhub/screens/posts/posts_screen.dart';

import '../profile/profile_setup_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserDetails userDetails = Provider.of<UserDetails>(context);
    return StreamBuilder<User?>(
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("Error..."),
          );
        } else if (snapshot.hasData && userDetails.isVerified) {
          return const PostsScreen();
        } else if (snapshot.hasData && !userDetails.isVerified) {
          return const ProfileSetupScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
