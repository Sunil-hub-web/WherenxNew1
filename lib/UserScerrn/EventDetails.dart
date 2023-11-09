import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:wherenxnew1/UserScerrn/AddEventsDetails.dart';

class EventDetails extends StatefulWidget {
  const EventDetails({super.key});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  TextEditingController textarea = TextEditingController();
  TextEditingController currentDateTime = TextEditingController();

  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles;
  File? galleryFile;
  String filePath1 = "";

  openImages() async {
    try {
      var pickedfiles = await imgpicker.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      // ignore: unnecessary_null_comparison
      if (pickedfiles != null) {
        imagefiles = pickedfiles;
        setState(() {});
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  Future getVideo(
    ImageSource img,
  ) async {
    // Pick an image
    // final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

// Pick a video
    // final XFile? image = await _picker.pickVideo(source: ImageSource.gallery);
    final pickedFile = await imgpicker.pickVideo(
      source: img,
      //preferredCameraDevice: CameraDevice.front,
      // maxDuration: const Duration(minutes: 10)
    );
    XFile? xfilePick = pickedFile;
    setState(
      () {
        if (xfilePick != null) {
          galleryFile = File(pickedFile!.path);
          genThumbnailFile(galleryFile?.path);
          print("imagevideo${galleryFile?.path}");
        } else {
          ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }

  DateTime currentDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
        currentDateTime.text = currentDate.toString();
      });
  }

  Future genThumbnailFile(String? path) async {
    final thumbnail = await VideoThumbnail.thumbnailFile(
        video: path!,
        // thumbnailPath: _tempDir,
        imageFormat: ImageFormat.JPEG,
        //maxHeightOrWidth: 0,
        maxHeight: 3,
        maxWidth: 2,
        quality: 10);

    setState(() {
      final file = File(thumbnail!);
      filePath1 = file.path;
    });

    print("filepathimage${filePath1}");
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, Orientation, ScreenType) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: 100.h,
          width: 100.w,
          margin: EdgeInsets.all(10),
          child: Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton.extended(
              onPressed: () {
                // showDialog(
                //   barrierColor: Colors.black26,
                //   context: context,
                //   builder: (context) {
                //     return setupAlertDialoadContainer();
                //   },
                // );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddEventsDetails()),
                );
              },
              label: const Text('Upload Event'),
              icon: const Icon(Icons.add),
            ),
          ),
        ),

        // Container(
        //      alignment: Alignment.center,
        //      padding: EdgeInsets.all(20),
        //      child: Column(
        //        children: [
        //           imagefiles != null?Wrap(
        //              children: imagefiles!.map((imageone){
        //                 return Container(
        //                    child:Card(
        //                       child: Container(
        //                          height: 100, width:100,
        //                          child: Image.file(File(imageone.path)),
        //                       ),
        //                    )
        //                 );
        //              }).toList(),
        //           ):Container()
        //        ],
        //      ),
        //   ),
      );
    });
  }

  Widget setupAlertDialoadContainer() {
    return Container(
      height: 100.h,
      width: 100.w,
      margin: EdgeInsets.all(5),
      //  width: MediaQuery.of(context).size.width,
      child: Dialog(
        elevation: 0,
        backgroundColor: Color(0xffffffff),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Container(
            //   margin: const EdgeInsets.all(5),
            //   child: Column(
            //     children: [
            //       filePath1 == ""
            //           ? Card(
            //               elevation: 5,
            //               shadowColor: Colors.black,
            //               color: Colors.white,
            //               shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(10),
            //               ),
            //               child: Image.asset(
            //                 'assets/images/eventimage.jpg',
            //                 height: 100,
            //                 width: 100,
            //               ),
            //             )
            //           : Card(
            //               elevation: 5,
            //               shadowColor: Colors.black,
            //               color: Colors.white,
            //               shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(10),
            //               ),
            //               child: Image.file(
            //                 File(filePath1),
            //                 height: 100,
            //                 width: 100,
            //               ),
            //             )
            //     ],
            //   ),
            // ),
            Container(
              margin: const EdgeInsets.all(15),
              child: Text(
                "Upload Event Details",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    openImages();
                    if (kDebugMode) {
                      print("imagedetails$imagefiles");
                      // Navigator.of(context).pop();
                    }
                  },
                  child: Card(
                    elevation: 5,
                    shadowColor: Colors.black,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/images/images.png',
                            height: 50,
                            width: 50,
                          ),
                          Text("Uplod Image")
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    getVideo(ImageSource.gallery);
                    //   Navigator.of(context).pop();
                    // print("imagedetails123${galleryFile?.path}");
                  },
                  child: Card(
                      elevation: 5,
                      shadowColor: Colors.black,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              'assets/images/uploading.png',
                              height: 50,
                              width: 50,
                            ),
                            Text("Uplod Video")
                          ],
                        ),
                      )),
                )
              ],
            ),
            // Container(
            //   margin: const EdgeInsets.all(5),
            //   child: Card(
            //     elevation: 5,
            //     shadowColor: Colors.black,
            //     color: Colors.white,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     child: TextFormField(
            //       controller: textarea,
            //       minLines: 1,
            //       keyboardType: TextInputType.multiline,
            //       decoration: InputDecoration(
            //           contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            //           hintText: 'Enter Your Name Here',
            //           hintStyle: TextStyle(color: Colors.grey),
            //           border: OutlineInputBorder(
            //             borderRadius: BorderRadius.all(Radius.circular(10)),
            //           )),
            //     ),
            //   ),
            // ),
            // Container(
            //   margin: const EdgeInsets.all(5),
            //   child: Card(
            //     elevation: 5,
            //     shadowColor: Colors.black,
            //     color: Colors.white,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     child: TextFormField(
            //       controller: textarea,
            //       minLines: 1,
            //       keyboardType: TextInputType.multiline,
            //       decoration: InputDecoration(
            //           contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            //           hintText: 'Enter Your Event Name Here',
            //           hintStyle: TextStyle(color: Colors.grey),
            //           border: OutlineInputBorder(
            //             borderRadius: BorderRadius.all(Radius.circular(10)),
            //           )),
            //     ),
            //   ),
            // ),
            // Container(
            //   margin: const EdgeInsets.all(5),
            //   child: Card(
            //     elevation: 5,
            //     shadowColor: Colors.black,
            //     color: Colors.white,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     child: TextFormField(
            //       controller: textarea,
            //       minLines: 1,
            //       keyboardType: TextInputType.multiline,
            //       decoration: InputDecoration(
            //           contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            //           hintText: 'Event Type',
            //           hintStyle: TextStyle(color: Colors.grey),
            //           border: OutlineInputBorder(
            //             borderRadius: BorderRadius.all(Radius.circular(10)),
            //           )),
            //     ),
            //   ),
            // ),
            InkWell(
              onTap: () {
                _selectDate(context);
              },
              child: Container(
                margin: const EdgeInsets.all(5),
                child: Card(
                  elevation: 5,
                  shadowColor: Colors.black,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: currentDateTime,
                    minLines: 1,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        hintText: 'Select Date And Time',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5),
              child: Card(
                elevation: 5,
                shadowColor: Colors.black,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: textarea,
                  minLines: 5,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                      hintText: 'Enter Event Description Here',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      )),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF1FCBDC), Color(0xFF00B8CA)],
                ),
              ),
              height: 46,
              child: ElevatedButton(
                onPressed: () async {
                  //Get.toNamed(RouteHelper.getotpScreenpage());
                  // Get.back();
                },
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  minimumSize: Size(MediaQuery.of(context).size.width, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // <-- Radius
                  ),
                ),
                child: const Text('Publish Your Event Now',
                    style: TextStyle(color: Colors.white, fontSize: 15)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
