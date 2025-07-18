import 'package:get/get.dart';

String normalizeName(String name) {
  List splitList = name.split(' ');

  List resultList = [];
  for (var text in splitList) {
    if (isUppercase(text)) {
      resultList.add(text);
    } else {
      resultList.add(text.toString().toLowerCase().capitalize);
    }
  }

  return resultList.join(' ');
}

bool isUppercase(String input) {
  return input == input.toUpperCase();
}
