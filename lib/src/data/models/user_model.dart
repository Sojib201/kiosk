// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';
import 'dart:typed_data';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String? status;
  String? message;
  UserInfo? userInfo;
  RestaurantInfo? restaurantInfo;
  String? token;

  User({
    this.status,
    this.message,
    this.userInfo,
    this.restaurantInfo,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        status: json["status"],
        message: json["message"],
        userInfo: json["user_info"] == null ? null : UserInfo.fromJson(json["user_info"]),
        restaurantInfo: json["restaurant_info"] == null ? null : RestaurantInfo.fromJson(json["restaurant_info"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user_info": userInfo?.toJson(),
        "restaurant_info": restaurantInfo?.toJson(),
        "token": token,
      };
}

class RestaurantInfo {
  String? cid;
  String? companyName;
  String? tagline;
  int? typeId;
  String? typeName;
  String? email;
  String? mobile;
  String? telephone;
  String? companyAddress;
  String? city;
  String? region;
  String? country;
  String? zipCode;
  String? websiteUrl;
  String? logoUrl;
  String? banner;
  String? timezone;
  String? currency;
  String? currencySymbol ;
  String? subscriptionPlan;
  String? vatRegNo;
  double? serviceExp;
  double? branchVat;
  Uint8List? resImageBytes;

  RestaurantInfo({
    this.cid,
    this.companyName,
    this.tagline,
    this.typeId,
    this.typeName,
    this.email,
    this.mobile,
    this.telephone,
    this.companyAddress,
    this.city,
    this.region,
    this.country,
    this.zipCode,
    this.websiteUrl,
    this.logoUrl,
    this.banner,
    this.timezone,
    this.currency,
    this.currencySymbol,
    this.subscriptionPlan,
    this.vatRegNo,
    this.serviceExp,
    this.branchVat,
    this.resImageBytes,
  });

  factory RestaurantInfo.fromJson(Map<String, dynamic> json) => RestaurantInfo(
        cid: json["cid"],
        companyName: json["company_name"],
        tagline: json["tagline"],
        typeId: json["type_id"],
        typeName: json["type_name"],
        email: json["email"],
        mobile: json["mobile"],
        telephone: json["telephone"],
        companyAddress: json["company_address"],
        city: json["city"],
        region: json["region"],
        country: json["country"],
        zipCode: json["zip_code"],
        websiteUrl: json["website_url"],
        logoUrl: json["logo_url"],
        banner: json["banner"],
        timezone: json["timezone"],
        currency: json["currency"],
        currencySymbol: json["currency_symbol"]??"৳",
        subscriptionPlan: json["subscription_plan"],
        vatRegNo: json["vat_reg_no"],
        serviceExp: json["service_exp"]??0.0,
        branchVat: json["vat_percentage"]??10.0,
        resImageBytes: json["res_image_bytes"] != null ? Uint8List.fromList(List<int>.from(json["res_image_bytes"])) : null,
      );

  Map<String, dynamic> toJson() => {
        "cid": cid,
        "company_name": companyName,
        "tagline": tagline,
        "type_id": typeId,
        "type_name": typeName,
        "email": email,
        "mobile": mobile,
        "telephone": telephone,
        "company_address": companyAddress,
        "city": city,
        "region": region,
        "country": country,
        "zip_code": zipCode,
        "website_url": websiteUrl,
        "logo_url": logoUrl,
        "banner": banner,
        "timezone": timezone,
        "currency": currency,
        "currency_symbol": currencySymbol,
        "subscription_plan": subscriptionPlan,
        "vat_reg_no": vatRegNo,
        "service_exp": serviceExp,
        "vat_percentage": branchVat,
        "res_image_bytes": resImageBytes != null ? resImageBytes!.toList() : null,
      };
}

class UserInfo {
  String? cid;
  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  String? telephone;
  String? address;
  String? city;
  String? region;
  String? country;
  String? zipCode;
  String? profileImage;
  String? gender;
  String? roleId;
  String? roleName;
  String? branchId;
  String? branchName;
  bool? isMaster;

  UserInfo({
    this.cid,
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.mobile,
    this.telephone,
    this.address,
    this.city,
    this.region,
    this.country,
    this.zipCode,
    this.profileImage,
    this.gender,
    this.roleId,
    this.roleName,
    this.branchId,
    this.branchName,
    this.isMaster,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        cid: json["cid"],
        userId: json["user_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        mobile: json["mobile"],
        telephone: json["telephone"],
        address: json["address"],
        city: json["city"],
        region: json["region"],
        country: json["country"],
        zipCode: json["zip_code"],
        profileImage: json["profile_image"],
        gender: json["gender"],
        roleId: json["role_id"],
        roleName: json["role_name"],
        branchId: json["branch_id"],
        branchName: json["branch_name"],
        isMaster: json["is_master"]??false,
      );

  Map<String, dynamic> toJson() => {
        "cid": cid,
        "user_id": userId,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "mobile": mobile,
        "telephone": telephone,
        "address": address,
        "city": city,
        "region": region,
        "country": country,
        "zip_code": zipCode,
        "profile_image": profileImage,
        "gender": gender,
        "role_id": roleId,
        "role_name": roleName,
        "branch_id": branchId,
        "branch_name": branchName,
        "is_master": isMaster,
      };
}
