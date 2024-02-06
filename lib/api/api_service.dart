import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import '../model/post.dart';

part 'api_service.g.dart';

//api end points
class Apis {
  static const String post = "/posts";
}

//base url
@RestApi(baseUrl: "https://jsonplaceholder.typicode.com")

// This class serves as a blueprint for defining network calls without providing
// concrete implementation details.
// It acts as an interface for interacting with APIs.
abstract class ApiClient {
  //this factory constructor, responsible for creating instances of ApiClient.
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET(Apis.post)
  Future<List<Post>> getPost();
}
