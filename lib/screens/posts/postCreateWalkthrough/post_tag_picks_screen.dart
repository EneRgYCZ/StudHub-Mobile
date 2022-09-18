import 'package:flutter/material.dart';
import 'package:studhub/services/models.dart';
import 'package:studhub/services/firestore.dart';
import 'package:flutter_tags_x/flutter_tags_x.dart';
import 'package:studhub/shared/loading.dart';
import 'package:studhub/shared/screen_arguments.dart';

class PostTagPicksScreen extends StatefulWidget {
  const PostTagPicksScreen({Key? key}) : super(key: key);

  @override
  State<PostTagPicksScreen> createState() => _PostTagPicksScreenState();
}

class _PostTagPicksScreenState extends State<PostTagPicksScreen> {
  List<String> arrayOfTags = [];

  @override
  Widget build(BuildContext context) {
    final passedData =
        ModalRoute.of(context)!.settings.arguments as PostArguments;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 25),
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
                            arguments: PostArguments(
                              passedData.title,
                              passedData.skills,
                              arrayOfTags,
                            ),
                          );
                        }
                      : null,
                  child: const Text("Next"),
                ),
              ],
            ),
            const Text(
              "Pick the right tags",
              style: TextStyle(fontSize: 20),
            ),
            Align(
              alignment: Alignment.center,
              child: FutureBuilder<List<Tag>>(
                future: FirestoreService().getTags(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    List<Tag> tags = snapshot.data;
                    return Tags(
                      itemCount: tags.length,
                      itemBuilder: (index) {
                        return Tooltip(
                          message: "#" + tags[index].title.toUpperCase(),
                          child: ItemTags(
                            textStyle: const TextStyle(fontSize: 25),
                            index: index,
                            title: "#" + tags[index].title.toUpperCase(),
                            onPressed: (i) {
                              if (arrayOfTags.contains(tags[index].title)) {
                                setState(() {
                                  arrayOfTags.remove(tags[index].title);
                                });
                              } else {
                                setState(() {
                                  arrayOfTags.add(tags[index].title);
                                });
                              }
                            },
                          ),
                        );
                      },
                    );
                  } else {
                    return const LoadingScreen();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
