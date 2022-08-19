import 'package:flutter/material.dart';
import 'package:flutter_tags_x/flutter_tags_x.dart';

import '../services/firestore.dart';

class PostFromWidget extends StatefulWidget {
  const PostFromWidget({Key? key}) : super(key: key);

  @override
  State<PostFromWidget> createState() => _PostFromWidgetState();
}

class _PostFromWidgetState extends State<PostFromWidget> {
  final _formKey = GlobalKey<FormState>();

  String tags = '';

  List arrayOfTags = [];

  final TextEditingController _tagsController = TextEditingController();

  final TextEditingController _text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
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
    );
  }
}
