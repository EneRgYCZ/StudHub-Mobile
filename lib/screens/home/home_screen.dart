import 'package:flutter/material.dart';
import 'package:studhub/services/auth.dart';
import 'package:studhub/screens/login/login_screen.dart';
import 'package:studhub/screens/posts/posts_screen.dart';
import 'package:studhub/shared/loading.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("Error..."),
          );
        } else if (snapshot.hasData) {
          return const PostsScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
