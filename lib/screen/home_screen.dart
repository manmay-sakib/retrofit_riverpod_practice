import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit_riverpod_practice/post_state.dart';
import '../model/post.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PostState state = ref.watch(postsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: Center(
        child: switch (state) {
          (InitialPostState _) => const Text("Click to fetch data"),
          (PostLoadingState _) => const CircularProgressIndicator(),
          (PostLoadedState state) => _buildListView(state),
          _ => const Text("Something went wrong")
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // read Used to obtain the current value of a provider without subscribing to future changes.
          ref.read(postsProvider.notifier).fetchPosts();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

Widget _buildListView(PostLoadedState state) {
  return ListView.builder(
    itemBuilder: (context, index) {
      Post post = state.posts[index];
      return ListTile(
        leading: CircleAvatar(
          child: Text(post.id.toString()),
        ),
        title: Text(post.title),
        subtitle: Text(post.body),
      );
    },
  );
}
