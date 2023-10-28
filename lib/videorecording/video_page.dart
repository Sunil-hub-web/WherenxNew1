
import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:wherenxnew1/ApiCallingPage/AddVideoReview.dart';
import 'package:wherenxnew1/ApiImplement/ViewDialog.dart';
import 'package:wherenxnew1/Routes/RouteHelper.dart';
import 'package:video_compress/video_compress.dart';

import 'FileCompressionApi.dart';

class VideoPage extends StatefulWidget {
  final String filePath;

  const VideoPage({Key? key, required this.filePath}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _videoPlayerController;
  String text = "", placeId = "", placename = "", F_name = "", formattedDate= "", placeType = "",profileImage = "",filePath1 = "";
  int userId = 0;
  double? _rating = 0.0;
  String googleApikey = "AIzaSyAuFYxq-RX0I1boI5HU5-olArirEi2Ez8k";
  var outputFile = "";
  MediaInfo? compressedVideoInfo;

  Future<void> getUserData() async {

    SharedPreferences pre = await SharedPreferences.getInstance();
    placeId = pre.getString("placeId") ?? "";
    placename = pre.getString("placename") ?? "";
    userId = pre.getInt("userId") ?? 0;
    F_name = pre.getString("name") ?? "";
    placeType = pre.getString("placeType") ?? "";
    profileImage = pre.getString("profileImage") ?? "";
    _rating = pre.getDouble("_rating") ?? 0.0;

    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    formattedDate = formatter.format(now);
    print(formattedDate); // 2016-01-25

  //  Future.delayed( Duration(seconds: 1)).then((value) => setState(() {}));

  }



  Future _initVideoPlayer() async {

    // await _displayFileSize(widget.filePath);
    // Left_indicator_bar_Flushbar(context,"File Size ${_result}");
    // print("Your File Size ${_result}");
    // print("Your File url is ${widget.filePath}");

   // File file = new File(widget.filePath);
    //final info = await FileCompressionApi.compressVideo(file);

    _videoPlayerController = VideoPlayerController.file(File(widget.filePath));
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();

  }

  Future genThumbnailFile() async{
    final thumbnail = await VideoThumbnail.thumbnailFile(
        video: widget.filePath,
        // thumbnailPath: _tempDir,
        imageFormat: ImageFormat.JPEG,
        //maxHeightOrWidth: 0,
        maxHeight:3,
        maxWidth: 2,
        quality: 10);

    setState(() {
      final file = File(thumbnail!);
      filePath1 = file.path;
    });

    print("filepathimage${filePath1}");
  }

  String? _result;
  bool _isRecursive = false;

  Future<int> _getFileSize(String path) async {
    final fileBytes = await File(path).readAsBytes();

    return fileBytes.lengthInBytes;
  }

  Future<void> _displayFileSize(String path) async {
    final fileSizeInBytes = await _getFileSize(path);
    _displaySize(fileSizeInBytes);
  }

  void _displaySize(int fileSizeInBytes) {
    final fileSizeInKB = fileSizeInBytes / 1000;
    final fileSizeInMB = fileSizeInKB / 1000;
    final fileSizeInGB = fileSizeInMB / 1000;
    final fileSizeInTB = fileSizeInGB / 1000;

    final fileSize = '''
  $fileSizeInBytes bytes
  $fileSizeInKB KB
  $fileSizeInMB MB
  $fileSizeInGB GB
  $fileSizeInTB TB
      ''';

    setState(() {
      _result = fileSize;
    });
  }

  @override
  void initState() {

   genThumbnailFile();
    super.initState();

  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
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
            onPressed: () async {
              print("do something with the file ${widget.filePath}");

              File file = new File(widget.filePath);
              final info = await FileCompressionApi.compressVideo(file);
              compressedVideoInfo = info;
              var filePath = compressedVideoInfo!.file!.path;
              //var fileName = (filePath.split('/').last);
             // final destination = "files/videos/$fileName";

              //_lightCompressor.cancelCompression();

              SharedPreferences pre = await SharedPreferences.getInstance();
              placeId = pre.getString("placeId") ?? "";
              placename = pre.getString("placename") ?? "";
              userId = pre.getInt("userId") ?? 0;
              F_name = pre.getString("name") ?? "";
              placeType = pre.getString("placeType") ?? "";
              profileImage = pre.getString("profileImage") ?? "";
              _rating = pre.getDouble("_rating") ?? 0.0;

              var now = DateTime.now();
              var formatter = DateFormat('yyyy-MM-dd');
              formattedDate = formatter.format(now);
              print(formattedDate); // 2016-01-25

              if(_rating == 0.0){

                Left_indicator_bar_Flushbar(context,"Select You Rating");

              } else{

                String struserId = userId.toString();
                String strrating = _rating.toString();

                String allvaluedet = "Your path details $struserId, $formattedDate, $F_name,$placename, $placeId, $strrating, "
                    "$filePath";
                print(allvaluedet);
                print("your video file path $filePath");

                ViewDialog(context: context).showLoadingIndicator("Upload Video Wait...", "Video Preview", context);

                // http.Response response = await AddVideoView().addVideoReviewDetails(
                //     struserId, formattedDate, F_name, placename, placeId, strrating, videopath);

                http.StreamedResponse? response = await AddVideoView().addVideoReviewDetails(struserId, formattedDate,
                    F_name, placename, placeId, strrating, filePath);

                if(response?.statusCode == 201){

                  ViewDialog(context: context).hideOpenDialog();

                  print("show your message ${await response?.stream.bytesToString()}");

                  Fluttertoast.showToast(
                      msg: "Video Upload Success",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0);

                  Get.toNamed(RouteHelper.getdetailsScreen());

                }else{

                  ViewDialog(context: context).hideOpenDialog();

                  print("show your message1${response?.reasonPhrase}");

                  Fluttertoast.showToast(
                      msg: "video Not Upload",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0);

                }

              }

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
            return VideoPlayer(_videoPlayerController);
          }
        },
      ),
    );
  }

  void Left_indicator_bar_Flushbar(BuildContext context,String Message){

    Flushbar(
      message: Message,
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: Colors.blue[300],
      ),
      duration: Duration(seconds: 3),
      leftBarIndicatorColor: Colors.red[300],
    )..show(context);
  }

}
