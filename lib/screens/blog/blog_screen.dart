import '../../services/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expandable/expandable.dart';

import '../../widgets/blog/blog_card_widget.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blog = Provider.of<List<Blog>>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog"),
      ),
      body: ExpandableTheme(
        data: const ExpandableThemeData(
          iconColor: Colors.blue,
          useInkWell: true,
        ),
        child: ListView.builder(
          itemCount: blog.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return BlogCardWidget(
              title: blog[index].title,
              text: blog[index].text,
              photo: blog[index].photo,
            );
          },
        ),
      ),
    );
  }
}
