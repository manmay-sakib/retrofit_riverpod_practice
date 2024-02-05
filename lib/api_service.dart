import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'main.dart';
import 'model/post.dart';

part 'api_service.g.dart';

class Apis {
  static const String post = "/posts";
}

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET(Apis.post)
  Future<List<Post>> getPost();
}

// class AlbumPostsNotifier extends StateNotifier<AlbumState>{
//   AlbumPostsNotifier(): super(InitialAlbumPostSate()) ;
//   final ApiClient _apiClient = ApiClient(Dio());
//
//   void fetchPosts() async{
//     try{
//       state = AlbumLoadingSate();
//       List<Album> posts = (await _apiClient.getAlbum()) as List<Album>;
//       state = AlbumLoadedPostState(albums: albums);
//
//     } catch(e){
//       state = ErrorAlbumPostState(message: e.toString());
//
//     }
//   }
//
// }
