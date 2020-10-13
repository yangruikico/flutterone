import 'dart:io';

import 'package:TATO/moudle/entity/file_entity.dart';
import 'package:TATO/view/widget/video_player_controlbar.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class VideoPlayerPage extends StatelessWidget {
  final FileEntity video;
  final File file;
  final VideoPlayerController controller;

  VideoPlayerPage({
    this.video,
    this.file,
    this.controller,
  }) : assert(video != null || file != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.black,
        child: VideoPlayerWithControlBar(
          video: video,
          file: file,
          isAutoPlay: true,
          isFull: true,
          controller: controller,
        ),
      ),
    );
  }
}
