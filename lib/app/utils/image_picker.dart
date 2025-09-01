import 'dart:io';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImage({bool fromCamera = false}) async {
  final pickedFile = await ImagePicker().pickImage(
    source: fromCamera ? ImageSource.camera : ImageSource.gallery,
  );
  if (pickedFile != null) {
    return File(pickedFile.path);
  }
  return null;
}


