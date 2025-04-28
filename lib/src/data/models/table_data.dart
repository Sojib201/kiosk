// To parse this JSON data, do
//
//     final tableData = tableDataFromJson(jsonString);

import 'dart:convert';

TableData tableDataFromJson(String str) => TableData.fromJson(json.decode(str));

String tableDataToJson(TableData data) => json.encode(data.toJson());

class TableData {
  String? status;
  String? branchId;
  List<SpaceList>? spaceList;

  TableData({
    this.status,
    this.branchId,
    this.spaceList,
  });

  factory TableData.fromJson(Map<String, dynamic> json) => TableData(
        status: json["status"],
        branchId: json["branch_id"],
        spaceList: json["space_list"] == null ? [] : List<SpaceList>.from(json["space_list"]!.map((x) => SpaceList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "branch_id": branchId,
        "space_list": spaceList == null ? [] : List<dynamic>.from(spaceList!.map((x) => x.toJson())),
      };
}

class SpaceList {
  String? spaceId;
  String? spaceName;
  String? spaceType;
  int? spaceCapacity;
  String? floor;
  String? statusType;
  List<TableLists>? tableList;

  SpaceList({
    this.spaceId,
    this.spaceName,
    this.spaceType,
    this.spaceCapacity,
    this.floor,
    this.statusType,
    this.tableList,
  });

  factory SpaceList.fromJson(Map<String, dynamic> json) => SpaceList(
        spaceId: json["space_id"],
        spaceName: json["space_name"],
        spaceType: json["space_type"],
        spaceCapacity: json["space_capacity"],
        floor: json["floor"],
        statusType: json["status_type"],
        tableList: json["table_list"] == null ? [] : List<TableLists>.from(json["table_list"]!.map((x) => TableLists.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "space_id": spaceId,
        "space_name": spaceName,
        "space_type": spaceType,
        "space_capacity": spaceCapacity,
        "floor": floor,
        "status_type": statusType,
        "table_list": tableList == null ? [] : List<dynamic>.from(tableList!.map((x) => x.toJson())),
      };
}

class TableLists {
  String? tableId;
  String? spaceId;
  String? tableName;
  int? capacity;
  String? tableRef;
  String? customerId;
  String? customerName;
  String? customerPhone;
  String? customerEmail;
  String? customerAddress;
  String? startDatetime;
  String? endDatetime;
  int? totalGuestCount;
  String? orderNo;
  String? statusType;

  TableLists({
    this.tableId,
    this.spaceId,
    this.tableName,
    this.capacity,
    this.tableRef,
    this.customerId,
    this.customerName,
    this.customerPhone,
    this.customerEmail,
    this.customerAddress,
    this.startDatetime,
    this.endDatetime,
    this.totalGuestCount,
    this.orderNo,
    this.statusType,
  });

  factory TableLists.fromJson(Map<String, dynamic> json) => TableLists(
        tableId: json["table_id"],
        spaceId: json["space_id"],
        tableName: json["table_name"],
        capacity: json["capacity"],
        tableRef: json["table_ref"],
        customerId: json["customer_id"],
        customerName: json["customer_name"],
        customerPhone: json["customer_phone"],
        customerEmail: json["customer_email"],
        customerAddress: json["customer_address"],
        startDatetime: json["start_datetime"],
        endDatetime: json["end_datetime"],
        totalGuestCount: json["total_guest_count"],
        orderNo: json["order_no"],
        statusType: json["status_type"],
      );

  Map<String, dynamic> toJson() => {
        "table_id": tableId,
        "space_id": spaceId,
        "table_name": tableName,
        "capacity": capacity,
        "table_ref": tableRef,
        "customer_id": customerId,
        "customer_name": customerName,
        "customer_phone": customerPhone,
        "customer_email": customerEmail,
        "customer_address": customerAddress,
        "start_datetime": startDatetime,
        "end_datetime": endDatetime,
        "total_guest_count": totalGuestCount,
        "order_no": orderNo,
        "status_type": statusType,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
