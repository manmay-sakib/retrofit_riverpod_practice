import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit_riverpod_practice/api_service.dart';
import 'model/post.dart';

final postsProvider = StateNotifierProvider<PostsNotifier, PostState>(
  (ref) => PostsNotifier(),
);

@immutable
abstract class PostState {}

class InitialPostState extends PostState {}

class PostLoadingState extends PostState {}

class PostLoadedState extends PostState {
  PostLoadedState({required this.posts});

  final List<Post> posts;
}

class ErrorPostState extends PostState {
  ErrorPostState({required this.message});

  final String message;
}

class PostsNotifier extends StateNotifier<PostState> {
  PostsNotifier() : super(InitialPostState());

  final ApiClient _apiClient = ApiClient(
    Dio(
      BaseOptions(contentType: "application/json"),
    ),
  );

  void fetchPosts() async {
    try {
      state = PostLoadingState();
      List<Post> posts = await _apiClient.getPost();
      state = PostLoadedState(posts: posts);
    } catch (e) {
      state = ErrorPostState(message: e.toString());
    }
  }
}
