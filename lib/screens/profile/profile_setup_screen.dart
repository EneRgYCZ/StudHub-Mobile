import 'package:flutter/material.dart';
import 'package:flutter_tags_x/flutter_tags_x.dart';
import 'package:studhub/services/firestore.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  String tags = '';

  final TextEditingController _tagsController = TextEditingController();

  List arrayOfTags = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "What skills do you have?",
                  style: TextStyle(fontSize: 25),
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
                      decoration:
                          const InputDecoration(labelText: "Add a tag..."),
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
                ElevatedButton.icon(
                  onPressed: () {
                    FirestoreService().updateSkills(arrayOfTags);
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => false);
                  },
                  icon: const Icon(Icons.check_circle),
                  label: const Text("Done"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
