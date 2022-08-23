import 'package:flutter/material.dart';
import 'package:studhub/widgets/post/post_form_widget.dart';

class PostCreateScreen extends StatelessWidget {
  const PostCreateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post create'),
      ),
      body: Container(
        margin: const EdgeInsets.all(8.0),
        // hack textfield height
        padding: const EdgeInsets.only(bottom: 40.0),
        child: const MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  PostFrom createState() {
    return PostFrom();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class PostFrom extends State<MyCustomForm> {
  String tags = '';
  List arrayOfTags = [];

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: PostFromWidget(),
    );
  }
}
