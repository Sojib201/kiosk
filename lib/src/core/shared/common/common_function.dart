import 'dart:io';
// import 'package:android_id/android_id.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart';
import 'package:kiosk/src/core/utils/color_utils.dart';

class CommonFunction {
  showmessgae(String msg, bool isSuccess) {
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: isSuccess ? ColorUtils.greenColor : ColorUtils.redColor,
    );
  }

  Future<bool> hasInternetConnection() async {
    try {
      final connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult.contains(ConnectivityResult.mobile) || connectivityResult.contains(ConnectivityResult.wifi)) {
        final response = await head(Uri.parse('https://www.google.com'));
        return response.statusCode == 200;
      } else {
        return false;
      }
    } on SocketException {
      // Handle socket exceptions (e.g., device not connected to internet)
      return false;
    } on PlatformException {
      // Handle platform exceptions (e.g., network issues or permission problems)
      return false;
    } catch (e) {
      // Handle unexpected exceptions

      return false;
    }
  }

  String makeImageUrl(String itemeID) {
     return "/data/user/0/com.example.kiosk/app_flutter/$itemeID.png";
    //return "/data/user/0/com.example.kiosk/app_flutter/$itemeID";
  }

  Future<String?> getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
      // return const AndroidId().getId(); // unique ID on Android
    }
  }


}
