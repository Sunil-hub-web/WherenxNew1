import 'dart:io';

import 'package:file_picker/file_picker.dart';

class FilePickerApi {
  //Picking an image from local storage
  // static Future<File?> pickImage() async {
  //   final pickedFile = await FilePicker.platform.pickFiles(
  //     allowMultiple: false,
  //     type: FileType.image, // Only images will be picked in the file picker
  //   );
  //
  //   if (pickedFile == null) {
  //     return null;
  //   } else {
  //     final pickedImage = pickedFile.files.first;
  //     return File(pickedImage.path!);
  //   }
  // }

  static Future<File?> pickVideo() async {
    final pickedFile = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.video, //Only videos will be picked in the file picker
    );

    if (pickedFile == null) {
      return null;
    } else {
      final pickedVideo = pickedFile.files.first;
      return File(pickedVideo.path!);
    }
  }
}