import 'dart:convert';
import 'dart:developer';


import 'package:http/http.dart' as http;
import 'package:kiosk/src/data/datasources/local/local_data_source.dart';

class ApiClient {
  Future<String> fetchData(String url) async {
    log("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx$url xxxx");
    // log("token === ${userFromJson(await HiveOperation().getData(HiveBoxKeys.userInfo)).token}");
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${HiveOperation().getToken()}',
      },
    );
    log("&&&&&&&&&&&&&&&& ${response.statusCode}");
    log(response.body.toString(), name: 'Response');
    if (response.statusCode == 200) {
      return utf8.decode(response.bodyBytes);
    } else {
      return utf8.decode(response.bodyBytes);
    }
  }

  Future<String> fetchUserData(String url) async {
    log("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx$url xxxx");
    // log("token === ${userFromJson(await HiveOperation().getData(HiveBoxKeys.userInfo)).token}");
    final response = await http.get(Uri.parse(url), headers: {
      'API-Key': 'EonOE99rngGQ6qsZccNObFaSmkNsh5bwHGX9qxcY5IxLmRLtpFUMKP5iptweKkQz',
      'Content-Type': 'application/json',
    });
    log("&&&&&&&&&&&&&&&& ${response.statusCode}");
    log(response.body.toString(), name: 'Response');
    if (response.statusCode == 200) {
      return utf8.decode(response.bodyBytes);
    } else {
      return utf8.decode(response.bodyBytes);
    }
  }

  Future<String> login(String url, Map<String, String> data) async {
    log('rrrrrrrrrrrrrrr');
    log(url);
    log(data.toString());
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(data),
      headers: {"Content-Type": "application/json"},
    );

    log(response.body.toString(), name: 'login Response ${response.statusCode}');

    if (response.statusCode == 200) {
      // log(response.body);
      // return response.body;
      return utf8.decode(response.bodyBytes);
    } else {
      return utf8.decode(response.bodyBytes);
    }
  }

  Future<String> DeviceSetUp(String url, Map<String, dynamic> data) async {
    log('rrrrrrrrrrrrrrr');
    log(url);
    log(jsonEncode(data.toString()));
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(data),
      headers: {
        'API-Key': 'EonOE99rngGQ6qsZccNObFaSmkNsh5bwHGX9qxcY5IxLmRLtpFUMKP5iptweKkQz',
        'Content-Type': 'application/json',
      },
    );

    log(response.statusCode.toString(), name: "status code");
    log(response.body.toString(), name: "restpdsfjdsfa");

    if (response.statusCode == 200 || response.statusCode == 201) {
      // log(response.body);
      return utf8.decode(response.bodyBytes);
    } else {
      return utf8.decode(response.bodyBytes);
    }
  }

  Future<String> postData(String url, Map<String, dynamic> data) async {
    log('rrrrrrrrrrrrrrr');
    log(url);
    log(data.toString());
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(data),
      headers: {
        'Authorization': 'Bearer ${HiveOperation().getToken()}',
        'Content-Type': 'application/json',
      },
    );

    log(response.statusCode.toString(), name: "status code");
    log(response.body.toString(), name: "restpdsfjdsfa");

    if (response.statusCode == 200 || response.statusCode == 201) {
      // log(response.body);
      return utf8.decode(response.bodyBytes);
    } else {
      return utf8.decode(response.bodyBytes);
    }
  }
}
