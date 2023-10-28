import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import '../Dimension.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../videorecording/FileCompressionApi.dart';

class VideoReviewDetailsScreen extends StatefulWidget {
  final String filePath;
  final String videorating;
  final String videoDate;
  final String videoName;

  VideoReviewDetailsScreen(
      {super.key, required this.filePath, required this.videorating,
        required this.videoDate, required this.videoName});

  @override
  _VideoReviewDetailsScreenState createState() =>
      _VideoReviewDetailsScreenState();
}

class _VideoReviewDetailsScreenState extends State<VideoReviewDetailsScreen> {
  // final String description = "Sed non dictum libero, molestie luctus. Nunc pretium massa nec massa consectetur, "
  //     "vel ullamcorper corem ipsum dolor sit amet, consectetur adipiscing elit. Sed ut facilisis nulla, n"
  //     "on aliquam libero. Nunc pretium massa nec massa consectetur, vel ullamcorper. Vivamus elementum "
  //     "pretium velit, at porta odio euismod et. Nulla facilisi. Vestibulum porttitor elit eget nulla pharetra suscipit.";

  late VideoPlayerController _videoPlayerController;

  //var videoreview = "", videorating = "0.0";

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future _initVideoPlayer() async {
    //SharedPreferences pre = await SharedPreferences.getInstance();
    //videoreview = pre.getString("videoreview") ?? "";
    //videorating = pre.getString("videorating") ?? "";

    // print("videoreview$videoreview");
    // print("videorating$videorating");

    File file = new File(widget.filePath);
    final info = await FileCompressionApi.compressVideo(file);

    print(
        "widgetfilePath${"https://www.2designnerds.com/wherenx_user/public/" + widget.filePath}");

    // MediaInfo? compressedVideoInfo = info;
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
        "https://www.2designnerds.com/wherenx_user/public/${widget.filePath}"));
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();
  }

  @override
  Widget build(BuildContext context) {
    final String description =
        "Sed non dictum libero, molestie luctus. Nunc pretium massa nec massa consectetur, vel ullamcorper corem ipsum dolor sit amet, consectetur adipiscing elit. Sed utfacilisis nulla, non aliquam libero. Nunc pretium massa nec massa consectetur, vel ullamcorper.Vivamus elementum pretium velit, at porta odio euismod et. Nulla facilisi. Vestibulum porttitorelit eget nulla pharetra suscipit.";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview'),
        elevation: 0,
        backgroundColor: Colors.black26,
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.check),
        //     onPressed: () {
        //       print("do something with the file ${widget.filePath}");
        //     },
        //   )
        // ],
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: Dimensions.screenWidth,
          height: Dimensions.screenHeight,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
            children: [
              Container(
                width: Dimensions.screenWidth,
                height: Dimensions.screenHeight / 1.1,
                child: FutureBuilder(
                  future: _initVideoPlayer(),
                  builder: (context, state) {
                    if (state.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return VideoPlayer(
                        _videoPlayerController,
                      );
                    }
                  },
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Container(
                    //   padding: const EdgeInsets.fromLTRB(15, 48, 15, 0),
                    //   alignment: Alignment.centerLeft,
                    //   child: SizedBox(
                    //     height: 22.0,
                    //     width: 26.0,
                    //     child: IconButton(
                    //         padding: const EdgeInsets.all(0.0),
                    //         icon: const Icon(
                    //           Icons.arrow_back_outlined,
                    //           color: Colors.white,
                    //           size: 24.0,
                    //         ),
                    //         onPressed: () {
                    //           Navigator.of(context).pop();
                    //         }),
                    //   ),
                    // ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black87,
                        ],
                      )),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                flex: 2,
                                child: Container(
                                  width: 45,
                                  height: 55,
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  decoration: BoxDecoration(
                                    image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/images/review-img.png"),
                                      fit: BoxFit.cover,
                                    ),
                                    border: Border.all(
                                        width: 2.0, color: Colors.white),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 12,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                       Text(
                                          widget.videoName,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 0),
                                          transform: Matrix4.translationValues(
                                              0.0, 0, 0.0),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 1),
                                            child: RatingBarIndicator(
                                              rating: double.parse(widget.videorating),
                                              itemBuilder: (context, index) =>
                                                  Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              itemCount: 5,
                                              itemSize: 20.0,
                                              direction: Axis.horizontal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                       widget.videoDate,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          // Container(
                          //   child: DescriptionTextWidget(text: description),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          )
        ),
      ),
    );
  }
}

class DescriptionTextWidget extends StatefulWidget {
  final String text;

  DescriptionTextWidget({required this.text});

  @override
  _DescriptionTextWidgetState createState() => _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  late String firstHalf;
  late String secondHalf;
  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 100) {
      firstHalf = widget.text.substring(0, 100);
      secondHalf = widget.text.substring(100, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
      child: secondHalf.isEmpty
          ? Text(firstHalf)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  flag ? (firstHalf + "...") : (firstHalf + secondHalf),
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontFamily: 'Poppins',
                  ),
                ),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        flag ? "more" : "less",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                ),
              ],
            ),
    ),
    );
  }
}
