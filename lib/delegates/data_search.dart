import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    Future.delayed(Duration.zero).then((_) => close(context, query));
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    } else {
      return FutureBuilder(
        future: suggestions(query),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return  ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      snapshot.data[index],
                    ),
                    leading: Icon(Icons.arrow_forward_ios),
                    onTap: (){
                      close(context,snapshot.data[index]);

                    },
                  );
                },
                itemCount: snapshot.data.length);
          }
        },
      );
    }
  }

  Future<List> suggestions(String search) async {

    http.Response response = await http.get(
        'https://suggestqueries.google.com/complete/search?hl=en&ds=yt&client=youtube&hjson=t&cp=1&q=$search&format=5&alt=json'
        );
        
    if (response.statusCode == 200) {
     return json.decode(response.body)[1].map((s) {
        return s[0];
      }).toList();
    } else {
      throw Exception('Failed to Load Suggestions');
    }
  }
}
