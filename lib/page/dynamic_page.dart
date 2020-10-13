import 'dart:math';

import 'package:TATO/moudle/entity/post.dart';
import 'package:TATO/view/widget/post_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DynamicPage extends StatefulWidget {
  @override
  _DynamicPageState createState() => _DynamicPageState();
}

class _DynamicPageState extends State<DynamicPage> {
  List<PostEntity> _likedPosts = [];

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      if (notification.metrics.extentAfter < 500) {
        //_loadLikedPosts();
      }
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      _loadLikedPosts();
    });
  }

  void _loadLikedPosts() async {
    print("yangrui1111");

    final posts = await postLiked(userId: 111, limit: 10, offset: 10);
    print("yangrui${posts.toString()}");
    setState(() {
      _likedPosts.addAll(posts);
    });

    print("yangrui2222");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('动态'),
        actions: <Widget>[
          IconButton(
            icon: Container(
              width: 40,
              height: 40,
              child: Image.asset('images/hb_copy.png'),
            ),
            onPressed: () {
              _loadLikedPosts();
            },
          )
        ],
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: ListView.builder(
          itemCount: _likedPosts.length,
          itemBuilder: (context, index) => PostTile(
            key: ValueKey(1111),
            //_likedPosts[index].id
            post: PostEntity(),
            //_likedPosts[index]
            onLike: () => setState(() {
              _likedPosts[index] = _likedPosts[index].copyWith(liked: true);
            }),
            onUnlike: () => setState(() {
              _likedPosts[index] = _likedPosts[index].copyWith(liked: false);
            }),
            onDelete: () => setState(() {
              _likedPosts.removeAt(index);
            }),
          ),
        ),
      ),
    );
  }

  final _random = Random();
  final _likedPostIds = {
    1: [11, 7, 3],
  };
  int _userId = 111;

  Map<int, Map<String, dynamic>> _posts;

  Future<List<PostEntity>> postLiked(
      {int userId, int limit = 10, int offset = 0}) async {
    final response = await Future.delayed(
      Duration(
        milliseconds: 500 + _random.nextInt(500),
      ),
      () {
        userId = 111;
        final likedPostIds = _likedPostIds[userId] ?? [];

        final posts = likedPostIds.skip(offset).take(limit).map((v) {
          final post = Map<String, dynamic>.from(
              _posts[_posts.keys.elementAt(_random.nextInt(_posts.length))]);
          post['id'] = v;
          return post;
        }).toList();

        if (_userId != null) {
          final likedPostIds = _likedPostIds[_userId] ?? [];
          posts.forEach((post) {
            post['liked'] = likedPostIds.contains(post['id']);
          });
        }

        return {'posts': posts};
      },
    );
    return response['posts'].map((v) => PostEntity.fromMap(v)).toList();
  }
}
