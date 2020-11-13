import 'package:favoritos_youtube/delegates/data_search.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        elevation: 0,
        title: Container(
            height: 50,
            width: 120,
            child: Image.asset(
              'assets/youtube.png',
              fit: BoxFit.fitWidth,
            )),
        actions: [
         
          Container(child: Text("0",), alignment: Alignment.center,),
          IconButton(
              icon: Icon(
                Icons.star,
                color: Colors.white,
              ),
              onPressed: () {}),IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () async {
                String result= await showSearch(context: context, delegate: DataSearch());
                print(result);
              }),
        ],
      ),
      body: Container(),
    );
  }
}
