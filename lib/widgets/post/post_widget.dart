import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:like_button/like_button.dart';
import 'package:studhub/services/firestore.dart';
import 'package:flutter_tags_x/flutter_tags_x.dart';
import 'package:studhub/widgets/post/comment_box_widget.dart';

import '../../services/models.dart';

class PostWidget extends StatefulWidget {
  final Post post;
  const PostWidget({Key? key, required this.post}) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    var userExtraData = Provider.of<UserDetails>(context);
    bool isLiked = false;
    bool contains;
    userExtraData.likedPosts.contains(widget.post.postId)
        ? contains = true
        : contains = false;

    return Hero(
      tag: widget.post.postId,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    PostsHeroWidget(post: widget.post),
              ),
            );
          },
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/profile',
                      arguments: widget.post.uid,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 30,
                        height: 30,
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.post.userName,
                            style: const TextStyle(fontSize: 13),
                          ),
                          Text(
                            widget.post.date,
                            style: const TextStyle(
                              fontSize: 9,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      Tags(
                        itemCount: widget.post.skills.length,
                        itemBuilder: (int index) {
                          return Tooltip(
                            message: widget.post.skills[index],
                            child: ItemTags(
                              textScaleFactor: 0.6,
                              onPressed: (i) {
                                Navigator.pushNamed(
                                  context,
                                  '/search',
                                  arguments: widget.post.skills[index],
                                );
                              },
                              textActiveColor: Colors.white,
                              activeColor: userExtraData.skills.contains(widget
                                      .post.skills[index]
                                      .toString()
                                      .toLowerCase())
                                  ? Colors.orange
                                  : Colors.blueGrey,
                              color: userExtraData.skills.contains(widget
                                      .post.skills[index]
                                      .toString()
                                      .toLowerCase())
                                  ? Colors.orange
                                  : Colors.blueGrey,
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
                Container(
                  alignment: Alignment.topLeft,
                  padding:
                      const EdgeInsets.only(left: 15, bottom: 10, right: 15),
                  child: Text(
                    widget.post.text,
                    style: const TextStyle(
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    LikeButton(
                      size: 20.0,
                      isLiked: isLiked,
                      likeCount: widget.post.likes,
                      likeBuilder: (isTaped) {
                        return Icon(
                          Icons.favorite,
                          color: contains ? Colors.red : Colors.white,
                          size: 20,
                        );
                      },
                      onTap: (isLiked) async {
                        if (contains) {
                          FirestoreService().updateLikeCounter(
                            widget.post.postId,
                            isLiked,
                            widget.post.likes,
                          );
                        } else {
                          FirestoreService().updateLikeCounter(
                            widget.post.postId,
                            !isLiked,
                            widget.post.likes,
                          );
                        }
                        return !isLiked;
                      },
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                PostsHeroWidget(post: widget.post),
                          ),
                        );
                      },
                      icon: const Icon(Icons.comment),
                      iconSize: 20,
                    ),
                    (userExtraData.uid == widget.post.uid)
                        ? PopupMenuButton(
                            icon: const Icon(
                              Icons.more_horiz,
                              size: 20,
                            ),
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
                                  onTap: () {
                                    CoolAlert.show(
                                      type: CoolAlertType.confirm,
                                      context: context,
                                      text:
                                          "Are you sure you want to delete the post?",
                                      onConfirmBtnTap: () {
                                        setState(() {
                                          FirestoreService()
                                              .deletePost(widget.post);
                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                                  '/', (route) => false);
                                        });
                                        var snackBar = SnackBar(
                                          elevation: 0,
                                          behavior: SnackBarBehavior.floating,
                                          backgroundColor: Colors.transparent,
                                          content: AwesomeSnackbarContent(
                                            title: 'Great decision!',
                                            message:
                                                'Maybe the idea needs more baking time...',
                                            contentType: ContentType.success,
                                          ),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      },
                                    );
                                  },
                                  leading: const Icon(Icons.delete),
                                  title: const Text('Delete Post'),
                                ),
                              ),
                              const PopupMenuItem(
                                child: ListTile(
                                  leading: Icon(
                                    Icons.article,
                                  ),
                                  title: Text('Item 3'),
                                ),
                              ),
                            ],
                          )
                        : PopupMenuButton(
                            icon: const Icon(
                              Icons.more_horiz,
                              size: 20,
                            ),
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
      ),
    );
  }
}

class PostsHeroWidget extends StatefulWidget {
  final Post post;

  const PostsHeroWidget({Key? key, required this.post}) : super(key: key);

  @override
  State<PostsHeroWidget> createState() => _PostsHeroWidgetState();
}

class _PostsHeroWidgetState extends State<PostsHeroWidget> {
  @override
  Widget build(BuildContext context) {
    var userExtraData = Provider.of<UserDetails>(context);

    final _controller = TextEditingController();
    var _enteredComment = "";

    void _postComment() {
      FocusScope.of(context).unfocus();
      FirestoreService().postComment(
        _enteredComment,
        widget.post.postId,
        userExtraData,
      );
      _enteredComment = "";
      _controller.clear();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          Hero(
            tag: widget.post.postId,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/profile',
                  arguments: widget.post.uid,
                );
              },
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
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 10, right: 15),
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
                        activeColor: userExtraData.skills.contains(widget
                                .post.skills[index]
                                .toString()
                                .toLowerCase())
                            ? Colors.orange
                            : Colors.blueGrey,
                        color: userExtraData.skills.contains(widget
                                .post.skills[index]
                                .toString()
                                .toLowerCase())
                            ? Colors.orange
                            : Colors.blueGrey,
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
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Comments:"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    textCapitalization: TextCapitalization.sentences,
                    controller: _controller,
                    decoration:
                        const InputDecoration(labelText: "Post a comment..."),
                    onChanged: (value) {
                      _enteredComment = value;
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  color: Theme.of(context).hintColor,
                  onPressed: () {
                    _enteredComment.trim().isEmpty ? null : _postComment();
                  },
                )
              ],
            ),
          ),
          CommentBoxWidget(postId: widget.post.postId),
        ],
      ),
      floatingActionButton: userExtraData.uid == widget.post.uid
          ? Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    CoolAlert.show(
                      type: CoolAlertType.confirm,
                      context: context,
                      onConfirmBtnTap: () {
                        setState(() {
                          Navigator.of(context)
                              .pushNamedAndRemoveUntil('/', (route) => false);
                          FirestoreService().deletePost(widget.post);
                        });
                        var snackBar = SnackBar(
                          elevation: 0,
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          content: AwesomeSnackbarContent(
                            title: 'Great decision!',
                            message: 'Maybe the idea needs more baking time...',
                            contentType: ContentType.success,
                          ),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      text: "Are you sure you want to delete the post?",
                    );
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text("Delete"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
