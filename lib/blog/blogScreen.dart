import 'package:provider/provider.dart';

import 'blog.dart';
import '../services/models.dart';
import '../services/firestore.dart';
import 'package:flutter/material.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider(
      create: (_) => FirestoreService().streamBlogData(),
      initialData: Blog(),
      child: const BlogCard(),
    );
  }
}
