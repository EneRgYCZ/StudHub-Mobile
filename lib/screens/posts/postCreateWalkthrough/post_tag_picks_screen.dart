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

List<String> arrayOfTags = [];

class _PostTagPicksScreenState extends State<PostTagPicksScreen> {
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
              "Most popular tags",
              style: TextStyle(fontSize: 20),
            ),
            Align(
              alignment: Alignment.center,
              child: FutureBuilder<List<Tag>>(
                future: FirestoreService().getLimitTags(),
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
            ),
            FutureBuilder<List<Tag>>(
              future: FirestoreService().getAllTags(),
              builder: (context, AsyncSnapshot snapshot) {
                List<Tag> tags = snapshot.data;
                List<String> tagsTitle = [];
                for (var element in tags) {
                  tagsTitle.add(element.title);
                }
                return IconButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(tagsList: tagsTitle),
                    );
                  },
                  icon: const Icon(Icons.search),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<dynamic> tagsList;
  CustomSearchDelegate({this.tagsList = const []});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<dynamic> matchQuerry = [];
    for (var results in tagsList) {
      if (results.contains(query.toLowerCase())) {
        matchQuerry.add(results.title);
      }
    }
    return ListView.builder(
      itemCount: matchQuerry.length,
      itemBuilder: ((context, index) {
        var result = matchQuerry[index];
        return ListTile(
          title: Text(result.title),
        );
      }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<dynamic> matchQuerry = [];
    for (var result in tagsList) {
      if (result.contains(query.toLowerCase())) {
        matchQuerry.add(result);
      }
    }
    return ListView.builder(
      itemCount: matchQuerry.length,
      itemBuilder: ((context, index) {
        var result = matchQuerry[index];
        return ListTile(
          title: Text(result),
          onTap: () {
            arrayOfTags.add(result);
          },
        );
      }),
    );
  }
}
