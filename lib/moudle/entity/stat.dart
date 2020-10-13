import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()

class UserStatEntity {
  final int id;
  final int userId;
  final int postCount;
  final int likeCount;
  final int followingCount;
  final int followerCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserStatEntity({
    this.id,
    this.userId,
    this.postCount,
    this.likeCount,
    this.followingCount,
    this.followerCount,
    this.createdAt,
    this.updatedAt,
  });


}


class PostStatEntity  {
  final int id;
  final int postId;
  final int likeCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  const PostStatEntity({
    this.id,
    this.postId,
    this.likeCount,
    this.createdAt,
    this.updatedAt,
  });


}
