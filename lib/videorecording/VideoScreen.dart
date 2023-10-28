
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:video_compress/video_compress.dart';

import 'FileCompressionApi.dart';
import 'FilePickerApi.dart';


class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  File? videoFile;
  MediaInfo? compressedVideoInfo;
  bool isUploading = false;
  bool isCompressing = false;
  @override
  Widget build(BuildContext context) {
    final fileName =
    videoFile != null ? (videoFile!.path.split('/').last) : "No Video Selected";
    final fileSize = videoFile != null
        ? (videoFile!.lengthSync().roundToDouble() / 1048576).toStringAsFixed(2)
        : "";
    return Scaffold(
        appBar: AppBar(
          title: const Text("Select Video"),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    fileName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    videoFile != null ? "File Size: $fileSize MB" : "",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (videoFile == null)
                    ElevatedButton.icon(
                        onPressed: () async {
                          final result = await FilePickerApi.pickVideo();
                          if (result == null) {
                            return;
                          }
                          final filePath = result.path;
                          setState(() {
                            videoFile = File(filePath);
                          });
                        },
                        icon: const Icon(Icons.video_file),
                        label: const Text("Pick Video"))
                  else
                    (compressedVideoInfo == null)
                        ? ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isCompressing = true;
                          });
                          final result =
                          await FileCompressionApi.compressVideo(
                              videoFile!);
                          if (result == null) {
                            return;
                          }

                          setState(() {
                            compressedVideoInfo = result;
                            videoFile = File(result.file!.path);
                            isCompressing = false;
                          });
                        },
                        child: isCompressing
                            ? const Text("Compressing...")
                            : const Text("Compress Video"))
                        : Column(
                      children: [
                        ElevatedButton.icon(
                            onPressed: () async {
                              String url = compressedVideoInfo!.file!.path;
                              GallerySaver.saveVideo(url,
                                  albumName: "Flutter App Demo")
                                  .whenComplete(() =>
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                      content: Text(
                                          "Saved to Gallery!"))));
                            },
                            icon: const Icon(Icons.download_rounded),
                            label: const Text("Save to Gallery")),
                        const SizedBox(
                          height: 8,
                        ),
                        ElevatedButton.icon(
                            onPressed: () async {
                              setState(() {
                                isUploading = true;
                              });
                              await uploadVideo().whenComplete(() {
                                setState(() {
                                  isUploading = false;
                                });
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                    content: Text(
                                        "Uploaded Successfully!")));
                              });
                            },
                            icon: const Icon(Icons.cloud_upload_rounded),
                            label: isUploading
                                ? const Text("Uploading...")
                                : const Text("Upload to Firebase")),
                      ],
                    ),
                ],
              )),
        ));
  }

  Future uploadVideo() async {
    if (compressedVideoInfo == null)
      return;
    var filePath = compressedVideoInfo!.file!.path;
    var fileName = (filePath.split('/').last);
    final destination = "files/videos/$fileName";

    //await FirebaseApi.uploadFile(destination, compressedVideoInfo!.file!);
  }
}
