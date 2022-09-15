import 'package:flutter/material.dart';
import 'package:flutter_tags_x/flutter_tags_x.dart';
import 'package:provider/provider.dart';
import 'package:studhub/services/models.dart';
import 'package:studhub/shared/screen_arguments.dart';

import '../../services/firestore.dart';

class SkillPicksWidget extends StatefulWidget {
  final String text;
  const SkillPicksWidget({Key? key, this.text = ""}) : super(key: key);

  @override
  State<SkillPicksWidget> createState() => _SkillPicksWidgetState();
}

class _SkillPicksWidgetState extends State<SkillPicksWidget> {
  String tags = '';

  List arrayOfTags = [];

  final TextEditingController _tagsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final passedData =
        ModalRoute.of(context)!.settings.arguments as PostArguments;
    final user = Provider.of<UserDetails>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamedAndRemoveUntil('/', (route) => false),
                  icon: const Icon(Icons.cancel_outlined),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: arrayOfTags.isNotEmpty
                      ? () {
                          FirestoreService()
                              .createPost(passedData.title, arrayOfTags, user);
                          Navigator.of(context)
                              .pushNamedAndRemoveUntil('/', (route) => false);
                        }
                      : null,
                  child: const Text("Post"),
                )
              ],
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
          ],
        ),
      ),
    );
  }
}
