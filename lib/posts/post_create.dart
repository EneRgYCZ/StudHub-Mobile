import 'package:flutter/material.dart';

class PostCreateScreen extends StatelessWidget {
  const PostCreateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post create'),
      ),
      body: const Text("Post Create"),
    );
  }
}
