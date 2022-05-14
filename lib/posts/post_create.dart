import 'package:flutter/material.dart';
import 'package:studhub/services/firestore.dart';

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
  final _formKey = GlobalKey<FormState>();

  TextEditingController title = TextEditingController();
  TextEditingController text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            // The validator receives the text that the user has entered.
            controller: title,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter a title for your idea',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            controller: text,
            maxLines: 10,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Share your idea',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  FirestoreService().createPost(title.text, text.text);
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/', (route) => false);
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
