// To parse this JSON data, do
//
//     final branchUsers = branchUsersFromJson(jsonString);

import 'dart:convert';

BranchUsers branchUsersFromJson(String str) => BranchUsers.fromJson(json.decode(str));

String branchUsersToJson(BranchUsers data) => json.encode(data.toJson());

class BranchUsers {
  String? status;
  String? message;
  List<String>? userList;

  BranchUsers({
    this.status,
    this.message,
    this.userList,
  });

  factory BranchUsers.fromJson(Map<String, dynamic> json) => BranchUsers(
        status: json["status"],
        message: json["message"],
        userList: json["user_list"] == null ? [] : List<String>.from(json["user_list"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user_list": userList == null ? [] : List<dynamic>.from(userList!.map((x) => x)),
      };
}
