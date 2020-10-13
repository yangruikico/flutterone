import 'package:TATO/moudle/entity/stat.dart';
import 'package:TATO/moudle/entity/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

import 'file_entity.dart';



enum PostType { TEXT, IMAGE, VIDEO }

enum PostListType { FOLLOWING, HOT }


class PostEntity  {
  static final typeNames = {
    PostType.TEXT: '文字',
    PostType.IMAGE: '图片',
    PostType.VIDEO: '视频',
  };

  final int id;
  final int userId;
  final PostType type;
  final String text;
  final List<int> imageIds;
  final int videoId;
  final DateTime createdAt;
  final DateTime updatedAt;
   UserEntity user;
  final List<FileEntity> images;
  final FileEntity video;
  final PostStatEntity stat;
  @JsonKey(defaultValue: false)
  final bool liked;

  PostEntity copyWith(
      {int id,
        int userId,
        PostType type,
        String text,
        List<int> imageIds,
        int videoId,
        DateTime createdAt,
        DateTime updatedAt,
        UserEntity user,
        List<FileEntity> images,
        FileEntity video,
        PostStatEntity stat,
        bool liked}) =>
      PostEntity(
          id: id ?? this.id,
          userId: userId ?? this.userId,
          type: type ?? this.type,
          text: text ?? this.text,
          imageIds: imageIds ?? this.imageIds,
          videoId: videoId ?? this.videoId,
          createdAt: createdAt ?? this.createdAt,
          updatedAt: updatedAt ?? this.updatedAt,
          user: user ?? this.user,
          images: images ?? this.images,
          video: video ?? this.video,
          stat: stat ?? this.stat,
          liked: liked ?? this.liked);

   PostEntity({
    this.id=1,
    this.userId=1,
    this.type=PostType.TEXT,
    this.text='文本内容',
    this.imageIds,
    this.videoId,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.images,
    this.video,
    this.stat,
    this.liked,
  });

  static PostEntity fromMap (Map<String, dynamic> json) {
    return PostEntity(
      id: json['id'] as int,
      userId: json['userId'] as int,
      text: json['text'] as String,
      imageIds: (json['imageIds'] as List)?.map((e) => e as int)?.toList(),
      videoId: json['videoId'] as int,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),

      liked: json['liked'] as bool ?? false,
    );
  }

}
