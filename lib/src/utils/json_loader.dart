import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

// Loads and parses JSON data from asset file (hris-option-list).
class JsonLoader {
  static Future<T> loadJson<T>(
    String path,
  ) async {
    final jsonString = await rootBundle.loadString(path);
    return json.decode(jsonString);
  }
}