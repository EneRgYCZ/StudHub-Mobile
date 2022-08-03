import 'package:expandable_search_bar/expandable_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:studhub/services/firestore.dart';
import 'package:studhub/services/models.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Post> searchResults = [];
  final TextEditingController _searchTerm = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final recivedSearchTerm =
        ModalRoute.of(context)!.settings.arguments as dynamic;
    _searchTerm.text = recivedSearchTerm;

    return Scaffold(
      appBar: AppBar(
        title: ExpandableSearchBar(
          editTextController: _searchTerm,
          hintText: "Search a tag",
          onTap: () {},
        ),
      ),
    );
  }
}
