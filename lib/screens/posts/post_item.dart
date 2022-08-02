import 'package:flutter/material.dart';
import 'package:flutter_tags_x/flutter_tags_x.dart';

import '../../services/models.dart';

class PostItem extends StatelessWidget {
  final Post post;
  const PostItem({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List tags = ["Da", "Nu", "De ce nu?"];
    return Hero(
      tag: post.text,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => PostsScreen(post: post),
              ),
            );
          },
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                        image: NetworkImage(
                          post.userPhoto,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Column(
                      children: [
                        Text(
                          post.userName,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          post.date,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 10),
                child: Row(
                  children: [
                    Tags(
                      itemCount: tags.length,
                      itemBuilder: (int index) {
                        return Tooltip(
                          message: tags[index],
                          child: ItemTags(
                            index: index,
                            title: tags[index],
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Container(
                  height: 10,
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: 300,
                    height: 100,
                    child: Text(
                      post.text,
                      style: const TextStyle(
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PostsScreen extends StatelessWidget {
  final Post post;

  const PostsScreen({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: ListView(children: [
        Hero(
          tag: post.text,
          child: Row(
            children: [
              Container(
                width: 70,
                height: 70,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: NetworkImage(
                      post.userPhoto,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  children: [
                    Text(
                      post.userName,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      post.date,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              post.text,
              style: const TextStyle(
                height: 2,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
