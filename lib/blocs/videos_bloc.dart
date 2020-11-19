import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_youtube/models/video.dart';
import 'package:favoritos_youtube/screens/api.dart';

class VideoBloc implements BlocBase {
  Api api;

  List<Video> videos = List<Video>();
  final StreamController<List<Video>> _videosController = StreamController<List<Video>>();
  Stream get outVideos => _videosController.stream;

  final StreamController<String> _searchController=StreamController<String>();
  Sink get inSearch =>_searchController.sink;

  VideoBloc() {
    api = Api();
    _searchController.stream.listen(_search);
  }

   _search(String search) async {
     print(search);
    videos = await api.search(search);
    print(videos);

    print('aaaaa');
    _videosController.sink.add(videos);
    print('videos');
    print(videos);
  }

 

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
  }

  @override
  void addListener(void Function() listener) {
      // TODO: implement addListener
    }
  
    @override
    // TODO: implement hasListeners
    bool get hasListeners => throw UnimplementedError();
  
    @override
    void notifyListeners() {
      // TODO: implement notifyListeners
    }
  
    @override
    void removeListener(void Function() listener) {
    // TODO: implement removeListener
  }

 
}
