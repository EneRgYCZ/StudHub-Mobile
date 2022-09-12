import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studhub/services/models.dart';
import 'package:flutter_tags_x/flutter_tags_x.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import '../../services/firestore.dart';

class SkillPicksWidget extends StatefulWidget {
  String text;
  SkillPicksWidget({Key? key, this.text = ""}) : super(key: key);

  @override
  State<SkillPicksWidget> createState() => _SkillPicksWidgetState();
}

class _SkillPicksWidgetState extends State<SkillPicksWidget> {
  final _formKey = GlobalKey<FormState>();

  String tags = '';

  List arrayOfTags = [];

  final TextEditingController _tagsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserDetails user = Provider.of<UserDetails>(context);

    return Column(
      children: [
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
                FirestoreService().createPost(widget.text, arrayOfTags, user);
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (route) => false);
              }
              var snackBar = SnackBar(
                elevation: 0,
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: 'Congratulation!',
                  message: 'Your post is up...enjoy the fame 😎',
                  contentType: ContentType.success,
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            child: const Text('Post'),
          ),
        ),
      ],
    );
  }
}
