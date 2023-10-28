import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'FileCompressionApi.dart';

class VideoViewInPath extends StatefulWidget {
  final String filePath;
  VideoViewInPath({super.key, required this.filePath});

  @override
  State<VideoViewInPath> createState() => _VideoViewInPathState();
}

class _VideoViewInPathState extends State<VideoViewInPath> {
  VideoPlayerController? _videoPlayerController;

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  Future _initVideoPlayer() async {

    File file = new File(widget.filePath);
    final info = await FileCompressionApi.compressVideo(file);

    print("widgetfilePath${"https://www.2designnerds.com/wherenx_user/public/"+widget.filePath}");

    // MediaInfo? compressedVideoInfo = info;
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse("https://www.2designnerds.com/wherenx_user/public/${widget.filePath}"));
    await _videoPlayerController?.initialize();
    await _videoPlayerController?.setLooping(true);
    await _videoPlayerController?.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview'),
        elevation: 0,
        backgroundColor: Colors.black26,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              print("do something with the file ${widget.filePath}");
            },
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
        future: _initVideoPlayer(),
        builder: (context, state) {
          if (state.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return VideoPlayer(_videoPlayerController!);
          }
        },

      ),
    );
  }
}
