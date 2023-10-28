import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import '../Dimension.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class VideoReviewDetailsScreen extends StatefulWidget {
  const VideoReviewDetailsScreen({super.key});
  @override
  _VideoReviewDetailsScreenState createState() => _VideoReviewDetailsScreenState();
}

class _VideoReviewDetailsScreenState extends State<VideoReviewDetailsScreen> {
  // final String description = "Sed non dictum libero, molestie luctus. Nunc pretium massa nec massa consectetur, "
  //     "vel ullamcorper corem ipsum dolor sit amet, consectetur adipiscing elit. Sed ut facilisis nulla, n"
  //     "on aliquam libero. Nunc pretium massa nec massa consectetur, vel ullamcorper. Vivamus elementum "
  //     "pretium velit, at porta odio euismod et. Nulla facilisi. Vestibulum porttitor elit eget nulla pharetra suscipit.";

  late VideoPlayerController _videoPlayerController;
  String videoreview = "", videorating = "";

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future _initVideoPlayer() async {

    SharedPreferences pre = await SharedPreferences.getInstance();
    videoreview = pre.getString("videoreview") ?? "";
    videorating = pre.getString("videorating") ?? "";

    print("videoreview${videoreview}");
    print("videorating${videorating}");

    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse("https://www.2designnerds.com/wherenx_user/public/${videoreview}"));

    _videoPlayerController.addListener(() {
      setState(() {});
    });
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      // appBar: AppBar(
      //   backgroundColor: const Color(0xFFF8F8F8),
      //   elevation: 0,
      //   automaticallyImplyLeading: false,
      //   title: Container(
      //     padding: const EdgeInsets.only(
      //       left: 4.0,
      //       right: 22.0,
      //       top: 0.0,
      //       bottom: 0.0,
      //     ),
      //     child: Row(
      //       children: [
      //         SizedBox(
      //           height: 22.0,
      //           width: 26.0,
      //           child: IconButton(
      //               padding: const EdgeInsets.all(0.0),
      //               icon: const Icon(
      //                 Icons.arrow_back_outlined,
      //                 color: Colors.black,
      //                 size: 24.0,
      //               ),
      //               onPressed: () {
      //                 Navigator.of(context).pop();
      //               }),
      //         ),
      //         const SizedBox(
      //           width: 6,
      //         ),
      //         const Text(
      //           'Select your Delights',
      //           style: TextStyle(
      //             fontWeight: FontWeight.w500,
      //             fontSize: 16,
      //             color: Colors.black,
      //           ),
      //         ),
      //         Container(
      //           margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      //           height: 20,
      //           padding: const EdgeInsets.only(left: 6, right: 6),
      //           decoration: BoxDecoration(
      //               color: Colors.grey[400],
      //               borderRadius: const BorderRadius.all(Radius.circular(50))),
      //           child: const Text(
      //             "05",
      //             textAlign: TextAlign.center,
      //             style: TextStyle(
      //               fontWeight: FontWeight.normal,
      //               color: Colors.white,
      //               height: 1.6,
      //               fontSize: 12,
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      body: Container(
        width: Dimensions.screenWidth,
        height: Dimensions.screenHeight,
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(15, 48, 15, 0),
              alignment: Alignment.centerLeft,
              child: SizedBox(
                height: 22.0,
                width: 26.0,
                child: IconButton(
                    padding: const EdgeInsets.all(0.0),
                    icon: const Icon(
                      Icons.arrow_back_outlined,
                      color: Colors.white,
                      size: 24.0,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black87,
                    ],
                  )
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 2,
                        child: FutureBuilder(
                          future: _initVideoPlayer(),
                          builder: (context, state) {
                            if (state.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            } else {
                              return Center(
                                child: InkWell(
                                  onTap: () {
                                    if (_videoPlayerController.value.isPlaying) {
                                      _videoPlayerController.pause();
                                    } else {
                                      _videoPlayerController.play();
                                    }
                                  },
                                  child: AspectRatio(
                                    aspectRatio: _videoPlayerController.value.aspectRatio,
                                    child: VideoPlayer(_videoPlayerController),
                                  ),
                                ),
                              );
                            }
                          },
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
                                const Text(
                                  "Jason Smith",
                                  style:
                                  TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 0),
                                  transform: Matrix4.translationValues(0.0, 0, 0.0),
                                  child:  Container(
                                    margin: const EdgeInsets.only(bottom: 0),
                                    transform: Matrix4.translationValues(0.0, 0, 0.0),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 1),
                                      child:RatingBarIndicator(
                                        rating: double.parse(videorating),
                                        itemBuilder: (context, index) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        itemCount: 5,
                                        itemSize: 20.0,
                                        direction: Axis.horizontal,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Text(
                              "2 Days",
                              style:
                              TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(height: 7,),
                  // Container(
                  //   child: DescriptionTextWidget(text: description),
                  // ),
                ],
              ),
            ),
          ],
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
    return Container(
      child: secondHalf.isEmpty ? Text(firstHalf) :
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(flag ? (firstHalf + "...") : (firstHalf + secondHalf),
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
    );
  }
}