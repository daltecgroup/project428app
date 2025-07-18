import 'dart:io';
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
