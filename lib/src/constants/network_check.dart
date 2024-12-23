/*import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkCheck {
  static Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}*/

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class NetworkCheck {
  // Create a logger instance
  static var logger = Logger();

  static Future<bool> check() async {
    // Log the connectivity check
    logger.i("Checking network connectivity...");

    // Check if device is connected to any network
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      logger.w("No network connection detected");
      return false; // No network connection
    }

    // Log the connection type (Mobile or Wi-Fi)
    if (connectivityResult == ConnectivityResult.mobile) {
      logger.i("Connected to mobile network");
    } else if (connectivityResult == ConnectivityResult.wifi) {
      logger.i("Connected to Wi-Fi network");
    }

    // If connected, check for actual internet connectivity
    try {
      logger.i("Checking internet availability...");
      final result = await http.get(Uri.parse('https://www.google.com/'));

      if (result.statusCode == 200) {
        logger.i("Internet is available");
        return true; // Internet is available
      } else {
        logger
            .e("Internet is not available. Status code: ${result.statusCode}");
        return false; // No internet access
      }
    } catch (e) {
      logger.e("Error checking internet access: $e");
      return false; // Network error (e.g., no internet)
    }
  }
}
