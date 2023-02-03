import 'dart:io';

class CommonService {
  static Future<bool> isNetworkAvailable() async {
    bool isConnected = true;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      }
    } on SocketException catch (_) {
      isConnected = false;
    }

    return isConnected;
  }
}
