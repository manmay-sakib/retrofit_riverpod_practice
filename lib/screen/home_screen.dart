import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit_riverpod_practice/post_state.dart';

import '../model/post.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      body: Center(
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            PostState state = ref.watch(postsProvider);

            if (state is InitialPostState) {
              return Text("Press FAB to Fetch Data");
            }
            if (state is PostLoadingState) {
              return CircularProgressIndicator();
            }
            if (state is PostLoadedState) {
              return _buildListView(state);
            }
            if (state is ErrorPostState) {
              return Text(state.message);
            }
            return Text("Nothing Found");
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
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
