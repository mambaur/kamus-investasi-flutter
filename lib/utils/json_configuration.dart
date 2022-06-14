import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class JsonConfiguration {
  // parseJsonFromAssets('assets/test.json')
  static Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) {
    if (kDebugMode) {
      print('--- Parse json from: $assetsPath');
    }
    return rootBundle
        .loadString(assetsPath)
        .then((jsonStr) => jsonDecode(jsonStr));
  }
}
