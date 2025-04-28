import 'dart:developer';

import 'package:kiosk/src/core/constants/hive_constants.dart';
import 'package:kiosk/src/data/models/user_model.dart';




class HiveOperation {
  Future<void> addData(dynamic data, String key) async {
    await HiveBoxes.basicBox.put(key, data);
  }

  Future<void> addrestData(dynamic data, String key) async {
    await HiveBoxes.restbox.put(key, data);
  }

  getData(String key) {
    return HiveBoxes.basicBox.get(key) ?? "";
  }
  getBooleanData(String key) {
    return HiveBoxes.basicBox.get(key) ?? false;
  }

  getrestData(String key) {
    return HiveBoxes.restbox.get(key) ?? "";
  }

  Future<void> addSettingsData(dynamic data, String key) async {
    await HiveBoxes.allSettings.put(key, data);
  }

  Future<String> getSettingsData(String key) async {
    return await HiveBoxes.allSettings.get(key) ?? "";
  }

  String getToken() {
    String token = (userFromJson(HiveBoxes.basicBox.get('userInfo') ?? '{}').token) ?? '';
    log('hive box data-----------------${HiveBoxes.basicBox.values.toString()}');

    return token;
  }
}
