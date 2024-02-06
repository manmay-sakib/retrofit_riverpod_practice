import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit_riverpod_practice/api/api_service.dart';
import 'package:retrofit_riverpod_practice/providers/dio_provider.dart';
import 'model/post.dart';

final postsProvider = StateNotifierProvider<PostsNotifier, PostState>(
  (ref) => PostsNotifier(ref.watch(
      apiClientProvider)), //watch Used to subscribe to a provider and rebuild your widget whenever its value changes.
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

//uses riverpod StateNotifier provider
class PostsNotifier extends StateNotifier<PostState> {
  final ApiClient _apiClient;

  PostsNotifier(this._apiClient) : super(InitialPostState());

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
