
import 'package:hive_flutter/adapters.dart';

class HiveBoxesName {
  //********** Box Name *********** */
  static const String basicBox = 'BasicBox';
  static const String settingsBox = 'SettingsBox';
  static const String restbox = 'restbox';
}

//********** open Box *********** */

class OpenBoxes {
  openBox() async {
    await Hive.openBox(HiveBoxesName.basicBox);
    await Hive.openBox(HiveBoxesName.settingsBox);
    await Hive.openBox(HiveBoxesName.restbox);
  }
}

class HiveBoxes {
  static Box get basicBox => Hive.box(HiveBoxesName.basicBox);
  static Box get allSettings => Hive.box(HiveBoxesName.settingsBox);
  static Box get restbox => Hive.box(HiveBoxesName.restbox);
}

class HiveBoxKeys {
  static const String baseurl = "baseurl";
  static const String userInfo = "userInfo";
  static const String isLogIn = "isLogIn";
  static const String isReg = "isLogIn";
  static const String currency = "currency";
  static const String allSettings = "allSettings";
  static const String isSecondaryConnected = "isSecondaryConnected";
  static const String currentSecondaryConnectedIndex = "currentSecondaryConnectedIndex";
  static const String fileDataKey = "fileData";
  static const String fileDataType = "fileDataType";
  static const String readyFoodCount = "readyFoodCount";
  static const String allNewOrders = "allNewOrders";
  static const String deviceId = "deviceId";
  static const String cid = "cid";
  static const String branchID = "branchID";
  static const String isDeviceSetUP = "isDeviceSetUP";
}
