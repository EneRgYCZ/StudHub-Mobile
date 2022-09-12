import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studhub/services/models.dart';

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
    final user = Provider.of<UserDetails>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(searchHistory: user.history),
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
  List<dynamic> searchHistory;
  CustomSearchDelegate({this.searchHistory = const []});

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
    for (var results in searchHistory) {
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
    for (var result in searchHistory) {
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
