import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:like_button/like_button.dart';
import 'package:studhub/services/firestore.dart';
import 'package:flutter_tags_x/flutter_tags_x.dart';

import '../../services/models.dart';

class PostItem extends StatefulWidget {
  final Post post;
  const PostItem({Key? key, required this.post}) : super(key: key);

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  @override
  Widget build(BuildContext context) {
    var userExtraData = Provider.of<UserInfo>(context);
    bool isLiked = false;

    return Hero(
      tag: widget.post.text,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    PostsScreen(post: widget.post),
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
                          widget.post.userPhoto,
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
                          widget.post.userName,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          widget.post.date,
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
                      itemCount: widget.post.skills.length,
                      itemBuilder: (int index) {
                        return Tooltip(
                          message: widget.post.skills[index],
                          child: ItemTags(
                            onPressed: (i) {
                              Navigator.pushNamed(
                                context,
                                '/search',
                                arguments: widget.post.skills[index],
                              );
                            },
                            textActiveColor: Colors.white,
                            activeColor: Colors.blueGrey,
                            color: Colors.blueGrey,
                            textColor: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            index: index,
                            title: widget.post.skills[index],
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
                      widget.post.text,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  LikeButton(
                    size: 30.0,
                    isLiked: isLiked,
                    likeCount: widget.post.likes,
                    onTap: (isLiked) async {
                      return !isLiked;
                    },
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.comment),
                  ),
                  (userExtraData.uid == widget.post.uid)
                      ? PopupMenuButton(
                          icon: const Icon(Icons.more_horiz),
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry>[
                            const PopupMenuItem(
                              child: ListTile(
                                leading: Icon(Icons.add),
                                title: Text('Add to favorites'),
                              ),
                            ),
                            PopupMenuItem(
                              child: ListTile(
                                onTap: (() =>
                                    FirestoreService().deletePost(widget.post)),
                                leading: const Icon(Icons.delete),
                                title: const Text('Delete Post'),
                              ),
                            ),
                            const PopupMenuItem(
                              child: ListTile(
                                leading: Icon(Icons.article),
                                title: Text('Item 3'),
                              ),
                            ),
                          ],
                        )
                      : PopupMenuButton(
                          icon: const Icon(Icons.more_horiz),
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry>[
                            const PopupMenuItem(
                              child: ListTile(
                                leading: Icon(Icons.add),
                                title: Text('Add to favorites'),
                              ),
                            ),
                            const PopupMenuItem(
                              child: ListTile(
                                leading: Icon(Icons.article),
                                title: Text('Option 3'),
                              ),
                            ),
                          ],
                        ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PostsScreen extends StatefulWidget {
  final Post post;

  const PostsScreen({Key? key, required this.post}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  Widget build(BuildContext context) {
    var userExtraData = Provider.of<UserInfo>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          Hero(
            tag: widget.post.text,
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
                        widget.post.userPhoto,
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
                        widget.post.userName,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        widget.post.date,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 10),
            child: Row(
              children: [
                Tags(
                  itemCount: widget.post.skills.length,
                  itemBuilder: (int index) {
                    return Tooltip(
                      message: widget.post.skills[index],
                      child: ItemTags(
                        onPressed: (i) {
                          Navigator.pushNamed(
                            context,
                            '/search',
                            arguments: widget.post.skills[index],
                          );
                        },
                        textActiveColor: Colors.white,
                        activeColor: Colors.blueGrey,
                        color: Colors.blueGrey,
                        textColor: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        index: index,
                        title: widget.post.skills[index],
                      ),
                    );
                  },
                )
              ],
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                widget.post.text,
                style: const TextStyle(
                  height: 2,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          userExtraData.uid == widget.post.uid
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          FirestoreService().deletePost(widget.post);
                          Navigator.of(context)
                              .pushNamedAndRemoveUntil('/', (route) => false);
                        });
                      },
                      icon: const Icon(Icons.delete),
                      label: const Text("Delete"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
