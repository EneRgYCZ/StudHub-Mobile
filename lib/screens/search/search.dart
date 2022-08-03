import 'package:flutter/material.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchTerm = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final recivedSearchTerm =
        ModalRoute.of(context)!.settings.arguments as dynamic;
    searchTerm.text = recivedSearchTerm;
    return Scaffold(
      appBar: AppBar(
        title: AnimSearchBar(
          rtl: true,
          width: 400,
          autoFocus: true,
          helpText: "Search",
          textController: searchTerm,
          prefixIcon: const Icon(
            FontAwesomeIcons.search,
            color: Colors.black,
          ),
          suffixIcon: const Icon(
            FontAwesomeIcons.search,
            color: Colors.black,
          ),
          onSuffixTap: () {},
          closeSearchOnSuffixTap: true,
        ),
      ),
    );
  }
}
