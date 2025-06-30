import 'package:flutter/material.dart';
import 'package:visual_learning/constant/app_colors/app_colors.dart';

class CustomSearchDelegate extends SearchDelegate {
  // Demo list to show querying
  // List<String> searchTerms = ["Apple", "Banana", "Mango", "Pear", "Watermelons", "Blueberries", "Pineapples", "Strawberries"];
  List<String> searchTerms = [];
  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none), //
        isDense: true,
        hintStyle: TextStyle(color: Colors.white),
      ),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(color: AppColors.pramarycolor),
    );
  }

  @override
  TextStyle? get searchFieldStyle => const TextStyle(
    decorationColor: Colors.white,
    color: Colors.white,
    fontWeight: FontWeight.bold,
    decorationThickness: 0, //this hides the text underline
  );
  // First overwrite to clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear, color: Colors.white),
      ),
    ];
  }

  // Second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back, color: Colors.white),
    );
  }

  // Third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(title: Text(result));
      },
    );
  }

  // Last overwrite to show the querying
  // process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(title: Text(result));
      },
    );
  }
}
