import 'package:TATO/moudle/entity/post.dart';
import 'package:json_annotation/json_annotation.dart';

class PostPublishForm  {
  PostType type;
  String text;
  List<String> images;
  List<int> imageIds;
  String video;
  int videoId;

  PostPublishForm({
    this.type = PostType.IMAGE,
    this.text = '',
    this.images = const [],
    this.imageIds = const [],
    this.video,
    this.videoId,
  });

}
