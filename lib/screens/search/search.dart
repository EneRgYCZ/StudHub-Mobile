import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<dynamic> lastSearches = [];
  List<dynamic> searchResults = [];
  final TextEditingController _searchTerm = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final recivedSearchTerm =
        ModalRoute.of(context)!.settings.arguments as dynamic;
    _searchTerm.text = recivedSearchTerm;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (lastSearches.isEmpty)
            const Center(
              child: Text(
                "No history...",
                style: TextStyle(fontSize: 21),
                textAlign: TextAlign.center,
              ),
            )
          else
            Text(searchResults[0])
        ],
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<dynamic> searchTerms = ["Mama", "Tata", "Tunete", "Fulgere"];

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
    for (var results in searchTerms) {
      if (results.contains(query.toLowerCase())) {
        matchQuerry.add(results);
      }
    }
    return ListView.builder(
      itemCount: matchQuerry.length,
      itemBuilder: ((context, index) {
        var result = matchQuerry[index];
        return ListTile(
          title: Text(result),
        );
      }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<dynamic> matchQuerry = [];
    for (var result in searchTerms) {
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
        );
      }),
    );
  }
}
