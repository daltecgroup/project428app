import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

// Get the local file path for storing data
Future<String> get getLocalPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> getLocalFile(String fileName) async {
  final path = await getLocalPath;
  return File('$path/$fileName');
}

Future<double> fileSize(File file) async {
  return await file.length() / 1024;
}

Future<File?> resizeImage(File file) async {
  final result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    '${file.parent.path}/img-600x600-${DateTime.now().millisecondsSinceEpoch}.jpg',
    quality: 80,
    minWidth: 600,
    minHeight: 600,
  );
  if (result != null) {
    return File(result.path);
  } else {
    return null;
  }
}
