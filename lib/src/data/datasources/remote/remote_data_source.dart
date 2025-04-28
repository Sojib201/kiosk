import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';


import 'package:http/http.dart' as http;
import 'package:kiosk/src/core/constants/hive_constants.dart';

import 'package:kiosk/src/data/datasources/local/local_data_source.dart';
import 'package:kiosk/src/data/models/branch_user_model.dart';
import 'package:kiosk/src/data/models/guest_count_model.dart';
import 'package:kiosk/src/data/models/settings_mode.dart';
import 'package:kiosk/src/data/models/unpaid_order_model.dart';
import 'package:kiosk/src/data/models/user_model.dart';
import 'package:kiosk/src/data/repositories/repositories.dart';

class GetDataFromApi {
  getDMpath(String cid) async {
    log('Dm path');
    String dmpath = await Repositories().dmPath(cid);
    await HiveOperation().addrestData(dmpath, HiveBoxKeys.baseurl);
  }

  //************** log in ******************* */

  Future<User> logIn(Map<String, String> body) async {
    User userModel = await Repositories().login(body);
    log(jsonEncode(userModel), name: "User Model");
    return userModel;
  }

  //******************* branch urse ******************* */
  Future<List<String>> branchUserList() async {
    BranchUsers allusers = await Repositories().userList();

    log(jsonEncode(allusers), name: "All users");
    if (allusers.status == "Success") {
      return allusers.userList!;
    } else {
      return [];
    }
  }

  //******************* Settings ******************* */
  Future<bool> settingData() async {
    AllSettings allSettings = await Repositories().allSettingData();

    log(jsonEncode(allSettings), name: "All Settings");
    if (allSettings.status == "Success") {
      await HiveOperation().addSettingsData(allSettingsToJson(allSettings), HiveBoxKeys.allSettings);
      return true;
    } else {
      return false;
    }
  }

  //************** book table ******************* */

  Future<Map<String, dynamic>> bookTable(Map<String, dynamic> body) async {
    Map<String, dynamic> data = await Repositories().tableBook(body);
    if (data['status'] == "Success") {
      return data;
    } else {
      return data;
    }
  }

  //************** get  table status ******************* */

  Future<Map<String, dynamic>> getTableStatus(String branchId) async {
    Map<String, dynamic> data = await Repositories().getTableStatus(branchId);
    if (data['status'] == "Success") {
      return data;
    } else {
      return {};
    }
  }
  //************** get  table total guest count ******************* */

  Future<GuestCount> getGuestCount() async {
    GuestCount data = await Repositories().getTotalguestCount();
    log(jsonEncode(data), name: "guest count");
    if (data.status == "Success") {
      return data;
    } else {
      return GuestCount();
    }
  }
  //************** get  table total guest count ******************* */

  Future<UnpaidOrder> getUnpaidOrderList() async {
    UnpaidOrder data = await Repositories().getUnpaidOrderListData();
    log(jsonEncode(data), name: "unpaid order List");
    if (data.status == "Success") {
      return data;
    } else {
      return UnpaidOrder();
    }
  }

  //************** Submit order******************* */

  Future<Map<String, dynamic>> submitOrder(Map<String, dynamic> body) async {
    Map<String, dynamic> data = await Repositories().submitOrder(body);
    log(data.toString(), name: "Resposce");

    return data;
  }

  Future<Map<String, dynamic>> deviceSetUp(Map<String, String> body) async {
    Map<String, dynamic> data = await Repositories().deviceSetup(body);
    log(data.toString(), name: "Resposce");

    return data;
  }
}
