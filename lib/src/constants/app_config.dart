import 'dart:convert';

import 'package:flutter/services.dart';

class AppConfig {
  static const environmentDev = 'dev';
  static const environmentProd = 'prod';

  final String apiBaseUrl;

  AppConfig({required this.apiBaseUrl});

  static Future<AppConfig> forEnvironment({required String env}) async {
    // Load the json file
    final contents = await rootBundle.loadString(
      'assets/config/$env.json',
    );

    // Decode our json
    final json = jsonDecode(contents);

    // Convert our JSON into an instance of our AppConfig class
    return AppConfig(apiBaseUrl: json['apiBaseUrl']);
  }
}
