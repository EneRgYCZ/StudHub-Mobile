import 'package:flutter/material.dart';
import 'package:flutter_tags_x/flutter_tags_x.dart';
import 'package:studhub/shared/screen_arguments.dart';

class SkillPicksScreen extends StatefulWidget {
  final String text;
  const SkillPicksScreen({Key? key, this.text = ""}) : super(key: key);

  @override
  State<SkillPicksScreen> createState() => _SkillPicksWidgetState();
}

class _SkillPicksWidgetState extends State<SkillPicksScreen> {
  String tags = '';

  List arrayOfTags = [];

  final TextEditingController _tagsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final passedData =
        ModalRoute.of(context)!.settings.arguments as PostArguments;
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
                          Navigator.of(context).pushNamed(
                            '/post_text',
                            arguments:
                                PostArguments(passedData.title, arrayOfTags),
                          );
                        }
                      : null,
                  child: const Text("Next"),
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
