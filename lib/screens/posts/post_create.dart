import 'package:flutter/material.dart';
import 'package:studhub/services/firestore.dart';
import 'package:flutter_tags_x/flutter_tags_x.dart';

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

  String tags = '';
  List arrayOfTags = [];

  final TextEditingController _tagsController = TextEditingController();
  final TextEditingController _text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextFormField(
              controller: _text,
              maxLines: 5,
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
            arrayOfTags.isEmpty
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        Tags(
                          itemCount: arrayOfTags.length,
                          itemBuilder: (int index) {
                            return Tooltip(
                              message: arrayOfTags[index],
                              child: ItemTags(
                                textActiveColor: Colors.white,
                                activeColor: Colors.blueGrey,
                                color: Colors.blueGrey,
                                textColor: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                index: index,
                                title: arrayOfTags[index],
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
            Container(
              padding: const EdgeInsets.all(4),
              child: Expanded(
                child: TextField(
                  controller: _tagsController,
                  decoration: const InputDecoration(labelText: "Add a tag..."),
                  onChanged: (value) {
                    setState(() {
                      tags = value;
                    });
                  },
                  onSubmitted: (value) {
                    arrayOfTags.add(value);
                    setState(() {
                      _tagsController.clear();
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    FirestoreService().createPost(_text.text, arrayOfTags);
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => false);
                  }
                },
                child: const Text('Post'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
