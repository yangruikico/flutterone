
import 'package:TATO/moudle/entity/post.dart';
import 'package:TATO/page/home.dart';
import 'package:TATO/util/number.dart';
import 'package:TATO/view/widget/video_player_controlbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../user_info_provide.dart';


class PostTile extends StatefulWidget {
  final PostEntity post;
  final void Function() onLike;
  final void Function() onUnlike;
  final void Function() onDelete;

  PostTile({
    Key key,
    @required this.post,
    this.onLike,
    this.onUnlike,
    this.onDelete,
  }) : super(key: key);

  @override
  _PostTileState createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  void _likePost() async {
    if (widget.onLike != null) widget.onLike();
  }

  void _unlikePost() async {
    if (widget.onUnlike != null) widget.onUnlike();
  }

  void _deletePost() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (c) => AlertDialog(
        title: Text('确认删除'),
        content: Text('是否确认删除动态？'),
        actions: [
          FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('取消'),
          ),
          FlatButton(
            onPressed: () async {
              Navigator.of(context).pop();
              if (widget.onDelete != null) widget.onDelete();
            },
            child: Text('确认'),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: Feedback.wrapForTap(
              () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                    return HomePage() ;//UserDetailPage(userId: widget.post.userId)
                  })),
              context,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundImage: widget.post.user.avatar == null
                      ? null
                      : CachedNetworkImageProvider(
                          widget.post.user.avatar),
                  child: widget.post.user.avatar == null
                      ? Icon(Icons.person)
                      : null,
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    widget.post.user.username,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.body2,
                  ),
                ),
              ],
            ),
          ),
          Text(
            widget.post.createdAt.toString().substring(0, 16),
            style: Theme.of(context)
                .textTheme
                .body1
                .copyWith(color: Theme.of(context).hintColor),
          ),
        ],
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(vertical: 11),
      child: Text(widget.post.text),
    );
  }

  Widget _buildImages(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final margin = 5.0;
        final columns =
            widget.post.images.length >= 3 ? 3 : widget.post.images.length;
        final width = (constraints.maxWidth - (columns - 1) * margin) / columns;
        final height = width;


        return Wrap(
          spacing: margin,
          runSpacing: margin,
          children: widget.post.images
              .asMap()
              .entries
              .map((entry) => GestureDetector(
                  onTap: Feedback.wrapForTap(
                    () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return HomePage();//
                        })),
                    context,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: entry.value.path,
                    fit: BoxFit.cover,
                    width: width,
                    height: height,
                  )))
              .toList(),
        );
      },
    );
  }

  Widget _buildVideo(BuildContext context) {
    return VideoPlayerWithCover(video: widget.post.video);
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.whatshot,
                color: Theme.of(context).hintColor,
                size: 20,
              ),
              Text(
                '${formatNumber(widget.post.stat?.likeCount ?? 0)}',
                style: Theme.of(context)
                    .textTheme
                    .body1
                    .copyWith(color: Theme.of(context).hintColor),
              ),
            ],
          ),
          Row(
            children: [
              widget.post.liked
                  ? GestureDetector(
                      onTap: Feedback.wrapForTap(_unlikePost, context),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Icon(
                          Icons.favorite,
                          size: 20,
                          color: Colors.red[300],
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: Feedback.wrapForTap(_likePost, context),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Icon(
                          Icons.favorite_border,
                          size: 20,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                    ),
              if (widget.post.userId.toString() ==Provider.of<UserInfoProvide>(context, listen: false).userEntity.username)
                GestureDetector(
                  onTap: Feedback.wrapForTap(_deletePost, context),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Icon(
                      Icons.delete_outline,
                      size: 20,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          _buildHeader(context),
          Divider(height: 1),
          if (widget.post.text != '') _buildText(context),
          if (widget.post.images.isNotEmpty) _buildImages(context),
          if (widget.post.video != null) _buildVideo(context),
          Divider(height: 1),
          _buildFooter(context),
        ],
      ),
    );
  }
}
