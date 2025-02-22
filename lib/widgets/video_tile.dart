import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_youtube/blocs/favorite_bloc.dart';
import 'package:favoritos_youtube/models/video.dart';
import 'package:flutter/material.dart';

class VideoTile extends StatelessWidget {
  final Video video;
  

  const VideoTile(this.video);
  
  @override
  Widget build(BuildContext context) {
        final bloc = BlocProvider.getBloc<FavoriteBloc>();

    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              video.thumb,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Text(
                      video.title,
                      maxLines: 2,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      video.channel,
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ],
              )),
              StreamBuilder<Map<String,Video>>(
                stream: bloc.outFav,
                initialData: {},
                builder: (context, snapshot) {
                  if (snapshot.hasData){
                return IconButton(
                    icon: Icon(
                      snapshot.data.containsKey(video.id)? Icons.star:
                      Icons.star_border,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      return bloc.togglefavorite(video);

                    });}
                    else{return CircularProgressIndicator();}
              }),
            ],
          )
        ],
      ),
    );
  }
}
