// ignore_for_file: file_names
import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userData = ModalRoute.of(context)!.settings.arguments as dynamic;
    return Scaffold(
      body: Text(userData.bio),
    );
  }
}
