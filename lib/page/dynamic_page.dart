import 'dart:math';

import 'package:TATO/moudle/entity/post.dart';
import 'package:TATO/moudle/entity/user_entity.dart';
import 'package:TATO/page/publish.dart';
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
      //_loadLikedPosts();
    });
  }

  void _loadLikedPosts() async {
    for (int i = 0; i < 10; i++) {
      PostEntity postEntity = PostEntity();
      postEntity.user = UserEntity();
      _likedPosts.add(postEntity);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('动态'),
        actions: <Widget>[
          Container(
            color: Colors.red,
            padding: EdgeInsets.only(right: 20),
            margin: EdgeInsets.only(right: 2),
            child: IconButton(
              icon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '发布',
                    style: TextStyle(fontSize: 14),
                  )
                ],
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PublishPage();
                }));
              },
            ),
          )
        ],
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: ListView.builder(
          itemCount: _likedPosts.length,
          itemBuilder: (context, index) => PostTile(
            key: ValueKey(_likedPosts[index].id),
            //_likedPosts[index].id
            post: _likedPosts[index],
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
        userId = 1;
        final likedPostIds = _likedPostIds[userId] ?? [];
        print("yangrui333");
        final posts = likedPostIds.skip(offset).take(limit).map((v) {
          final post = Map<String, dynamic>.from(
              _posts[_posts.keys.elementAt(_random.nextInt(10))]);
          post['id'] = v;
          return post;
        }).toList();
        print("yangrui4444");
        if (_userId != null) {
          final likedPostIds = _likedPostIds[_userId] ?? [];
          posts.forEach((post) {
            post['liked'] = likedPostIds.contains(post['id']);
          });
        }
        print("yangrui${posts.length}");
        return {'posts': posts};
      },
    );
    return response['posts'].map((v) => PostEntity.fromMap(v)).toList();
  }
}
