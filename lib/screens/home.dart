import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_youtube/blocs/videos_bloc.dart';
import 'package:favoritos_youtube/delegates/data_search.dart';
import 'package:favoritos_youtube/widgets/video_tile.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
          Container(
            child: Text(
              "0",
            ),
            alignment: Alignment.center,
          ),
          IconButton(
              icon: Icon(
                Icons.star,
                color: Colors.white,
              ),
              onPressed: () {}),
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () async {
                String result =
                    await showSearch(context: context, delegate: DataSearch());
                if (result != null)
                  BlocProvider.getBloc<VideoBloc>().inSearch.add(result);
              }),
        ],
      ),
      body: StreamBuilder(
        stream: BlocProvider.getBloc<VideoBloc>().outVideos,
        builder: (context, snapshot) {
          if (snapshot.hasData) { 
            return ListView.builder(
              itemBuilder: (context, index) {
                return VideoTile(snapshot.data[index]);
              },
              itemCount: snapshot.data.length,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
