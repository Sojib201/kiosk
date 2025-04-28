import 'dart:convert';
import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:kiosk/src/core/constants/api_urls.dart';
import 'package:kiosk/src/core/constants/hive_constants.dart';
import 'package:kiosk/src/core/errors/exceptions.dart';
import 'package:kiosk/src/core/network/api_clieant.dart';
import 'package:kiosk/src/core/shared/common/common_function.dart';
import 'package:kiosk/src/data/datasources/local/local_data_source.dart';
import 'package:kiosk/src/data/models/branch_user_model.dart';
import 'package:kiosk/src/data/models/guest_count_model.dart';
import 'package:kiosk/src/data/models/settings_mode.dart';
import 'package:kiosk/src/data/models/unpaid_order_model.dart';
import 'package:kiosk/src/data/models/user_model.dart';


class Repositories {
  ApiClient apiClient = ApiClient();

  ///********************Dm path ***************** */
  Future<String> dmPath(String cid) async {
    try {
      Map<String, dynamic> data = jsonDecode(await apiClient.fetchData(ApiUrls().dmpath(cid)));
      log("Dmmmmmmmmmmmmmmmmmmmm$data");
      if (data['status'] == "Success") {
        return data['base-url'].toString();
        // Boxes.getDmPath().put("base_url", data['base_url'].toString());
      } else {
        CommonFunction().showmessgae("${data['message']}", false);
      }
    } catch (e) {
      CommonFunction().showmessgae("$e", false);
    }

    return "";
  }

  ///********************  Log in  ***************** */
  Future<User> login(Map<String, String> body) async {
    String url = await HiveOperation().getrestData(HiveBoxKeys.baseurl);
    log(url, name: "SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
    String data = await apiClient.login(ApiUrls().login(await HiveOperation().getrestData(HiveBoxKeys.baseurl)), body);
    // log("${jsonDecode(data)['restaurant_info']['currency_symbol']}", name: "currencyssssssssss");
    // await HiveOperation().addData(jsonDecode(data)['restaurant_info']['currency_symbol'], HiveBoxKeys.currency);
    log(jsonEncode(userFromJson(data)), name: "User Modelxxx");
    return userFromJson(data);
  }

  // ************************* Device Setup *************************
  Future<Map<String, dynamic>> deviceSetup(Map<String, String> body) async {
    String url = await HiveOperation().getrestData(HiveBoxKeys.baseurl);
    log(url, name: "SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
    String data = await apiClient.DeviceSetUp(ApiUrls().deviceSetup(await HiveOperation().getrestData(HiveBoxKeys.baseurl)), body);
    return jsonDecode(data);
  }

  ///********************  book table ***************** */
  Future<Map<String, dynamic>> tableBook(Map<String, dynamic> body) async {
    try {
      return jsonDecode(await apiClient.postData(ApiUrls().bookTableUrl(await HiveOperation().getrestData(HiveBoxKeys.baseurl)), body));
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  ///********************  get  table status***************** */
  Future<Map<String, dynamic>> getTableStatus(String branchId) async {
    try {
      String url = (ApiUrls().getTableStatusUrl(await HiveOperation().getrestData(HiveBoxKeys.baseurl)));
      log(url);
      return jsonDecode(await apiClient.fetchData(url));
    } catch (e) {
      log(e.toString());
      throw ServerException(e.toString());
    }
  }

  ///********************  get  get total guest count ***************** */
  Future<GuestCount> getTotalguestCount() async {
    try {
      String url = (ApiUrls().totalGuestCountUrl(await HiveOperation().getrestData(HiveBoxKeys.baseurl)));
      log(url);
      log(await apiClient.fetchData(url), name: "guest count");
      return guestCountFromJson(await apiClient.fetchData(url));
    } catch (e) {
      log(e.toString());
      throw ServerException(e.toString());
    }
  }

  ///********************  get  get total guest count ***************** */
  Future<UnpaidOrder> getUnpaidOrderListData() async {
    try {
      String url = (ApiUrls().unpaidOrderListUrl(await HiveOperation().getrestData(HiveBoxKeys.baseurl)));
      log(url);
      log(await apiClient.fetchData(url), name: "guest count");
      return unpaidOrderFromJson(await apiClient.fetchData(url));
    } catch (e) {
      log(e.toString());
      throw ServerException(e.toString());
    }
  }

  ///******************** All Settings Data ***************** */
  Future<AllSettings> allSettingData() async {
    try {
      return allSettingsFromJson(await apiClient.fetchData(ApiUrls().allSettings(await HiveOperation().getrestData(HiveBoxKeys.baseurl))));
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  //********User list */
  Future<BranchUsers> userList() async {
    log(await HiveOperation().getrestData(HiveBoxKeys.cid).toString(), name: "CID");
    log(await HiveOperation().getrestData(HiveBoxKeys.branchID).toString(), name: "branchID");
    log(await HiveOperation().getrestData(HiveBoxKeys.baseurl).toString(), name: "baseuil");
    try {
      return branchUsersFromJson(await apiClient.fetchUserData(ApiUrls().branchUserList(await HiveOperation().getrestData(HiveBoxKeys.baseurl), await HiveOperation().getrestData(HiveBoxKeys.cid), await HiveOperation().getrestData(HiveBoxKeys.branchID))));
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  ///******************** submit order ***************** */
  Future<Map<String, dynamic>> submitOrder(Map<String, dynamic> body) async {
    try {
      String url = (ApiUrls().submitOrderUrl(await HiveOperation().getrestData(HiveBoxKeys.baseurl)));
      log(url);
      log(jsonEncode(body), name: "my api body");
      return jsonDecode(await apiClient.postData(url, body));
    } catch (e) {
      log(e.toString());
      throw ServerException(e.toString());
    }
  }

  Future<Map<String, dynamic>> paymentCollection(Map<String, dynamic> body) async {
    String url = (ApiUrls().paymentCollection(await HiveOperation().getrestData(HiveBoxKeys.baseurl)));
    log(url);
    log(jsonEncode(body), name: "my api body");
    return jsonDecode(await apiClient.postData(url, body));
  }

  // Future<bool> updateOrderStatus(Map<String, dynamic> body) async {
  //   userInfo = userFromJson(await HiveOperation().getData(HiveBoxKeys.userInfo));
  //   try {
  //     final Response res = await http.post(
  //       Uri.parse(ApiUrls().updateOrderStatus(await HiveOperation().getrestData(HiveBoxKeys.baseurl))),
  //       body: jsonEncode(body),
  //       headers: {
  //         'Authorization': 'Bearer ${userInfo.token.toString()}',
  //         'Content-Type': 'application/json',
  //       },
  //     );
  //     Map<String, dynamic> data = jsonDecode(res.body);
  //     log(data.toString(), name: "maruf");
  //     if (data['status'] == "Success") {
  //       Fluttertoast.showToast(msg: data['message'].toString());
  //       log("data inserted");
  //       return true;
  //     } else {
  //       Fluttertoast.showToast(msg: data['message'].toString());
  //       log("data not inserted");
  //       log("data not inserted ${data['message']}");
  //       return false;
  //     }
  //   } catch (e) {
  //     debugPrint('Repositories.getOrderList() func error: $e');
  //     return false;
  //   }
  // }
}
