// To parse this JSON data, do
//
//     final tableStatusModel = tableStatusModelFromJson(jsonString);

import 'dart:convert';

TableStatusModel tableStatusModelFromJson(String str) => TableStatusModel.fromJson(json.decode(str));

String tableStatusModelToJson(TableStatusModel data) => json.encode(data.toJson());

class TableStatusModel {
  String? tableId;
  String? spaceId;
  String? tableName;
  int? capacity;
  String? orderNo;
  String? tableRef;
  String? statusType;

  TableStatusModel({
    this.tableId,
    this.spaceId,
    this.tableName,
    this.capacity,
    this.orderNo,
    this.tableRef,
    this.statusType,
  });

  factory TableStatusModel.fromJson(Map<String, dynamic> json) => TableStatusModel(
    tableId: json["table_id"],
    spaceId: json["space_id"],
    tableName: json["table_name"],
    capacity: json["capacity"],
    orderNo: json["order_no"],
    tableRef: json["table_ref"],
    statusType: json["status_type"],
  );

  Map<String, dynamic> toJson() => {
    "table_id": tableId,
    "space_id": spaceId,
    "table_name": tableName,
    "capacity": capacity,
    "order_no": orderNo,
    "table_ref": tableRef,
    "status_type": statusType,
  };
}
