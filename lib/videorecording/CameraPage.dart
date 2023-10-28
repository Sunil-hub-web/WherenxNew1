import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:wherenxnew1/videorecording/video_page.dart';

import 'OtpController.dart';
import 'package:get/get.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  bool _isLoading = true;
  bool _isRecording = false;
  late CameraController _cameraController;
  final globalKey = GlobalKey<ScaffoldState>();
  bool _isVisiable_recPoPup = false;
  bool _isVisiable_recordTime = false;
  bool _isVisiable_beforerec = false;
  bool _isVisiable_ellipse = false;
  bool _isVisiable_endEllipse = false;

  String filePath = "";
  bool _isFrontCamera = false;
  List<CameraDescription> cameras = [];

  int ellipeeState = 0;

  final OtpController controller = Get.put(OtpController());
  RxInt count = 30.obs;
  late Timer _timer;

  bool isLoading = true;

  @override
  void initState() {
    _initCamera();
    super.initState();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  _initCamera() async {
    final cameras = await availableCameras();

    if(cameras != null){

     // final front = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front);
     // _cameraController = CameraController(front, ResolutionPreset.max);

      if(_isFrontCamera){
        _cameraController = CameraController(cameras[1], ResolutionPreset.max);
      }else{
        _cameraController = CameraController(cameras[0], ResolutionPreset.max);
      }

      _cameraController.initialize().then((_){

        if(!mounted){
          return;
        }
        setState(() => _isLoading = false);

      });

    }else{

      print("No Any Camera Not Found");
    }

  //  await _cameraController.initialize();
  //  setState(() => _isLoading = false);
  }

  _recordVideo() async {
    if (_isRecording) {
      _isVisiable_recPoPup = false;
      final file = await _cameraController.stopVideoRecording();
      filePath = file.path;
      print("filepathedetails${file.path}");
      double filesize = getFileSize(File(file.path));
      print("metathesizedfile  $filesize");
      setState(() => _isRecording = false);
      final route = MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => VideoPage(filePath: file.path.toString()),
      );
      Navigator.push(context, route);
    } else {
      _isVisiable_recPoPup = true;
      controller.startTimer();
      await _cameraController.prepareForVideoRecording();
      await _cameraController.startVideoRecording();
      setState(() => _isRecording = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CameraPreview(_cameraController),
              Padding(
                padding: const EdgeInsets.all(30),
                child: FloatingActionButton(
                  backgroundColor: Colors.red,
                  child: Icon(_isRecording ? Icons.stop : Icons.circle),
                  onPressed: (){

                    _recordVideo();

                    const oneSec = Duration(seconds: 1);
                    _timer = Timer.periodic(oneSec, (Timer timer) {
                      if (count == 0) {

                        _recordVideo();

                        timer.cancel();
                        isLoading = false;

                        count = 30.obs;

                      } else {
                        count--;
                      }
                    },
                    );

                    setState(() {});
                  }

                ),
              ),
              Visibility(
                visible: _isVisiable_recPoPup,
                child: Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.all(10),
                    child: Obx(
                          () => controller.count != 0
                          ? Text(
                        '00 : ${controller.count}',
                        style: const TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                          : TextButton(
                        child: const Text("",
                            style: TextStyle(
                                color: Colors.teal,
                                fontSize: 16,
                                fontWeight: FontWeight.normal)),
                        onPressed: () async {
                          // pr.show();
                          setState(() {});
                        },
                      ),
                    )
                ),
              ),

              if(controller.count == 0)
                _recordVideo()

            ],
          ),
        ),
      );
    }
  }

  double getFileSize(File file){
    int sizeInBytes = file.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    return sizeInMb;
  }
}