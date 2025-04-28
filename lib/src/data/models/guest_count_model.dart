// To parse this JSON data, do
//
//     final guestCount = guestCountFromJson(jsonString);

import 'dart:convert';

GuestCount guestCountFromJson(String str) => GuestCount.fromJson(json.decode(str));

String guestCountToJson(GuestCount data) => json.encode(data.toJson());

class GuestCount {
  List<BookingList>? bookingList;
  int? netGuestCount;
  String? status;
  List<StatusGuestCount>? statusGuestCount;

  GuestCount({
    this.bookingList,
    this.netGuestCount,
    this.status,
    this.statusGuestCount,
  });

  factory GuestCount.fromJson(Map<String, dynamic> json) => GuestCount(
        bookingList: json["booking_list"] == null ? [] : List<BookingList>.from(json["booking_list"]!.map((x) => BookingList.fromJson(x))),
        netGuestCount: json["net_guest_count"],
        status: json["status"],
        statusGuestCount: json["status_guest_count"] == null ? [] : List<StatusGuestCount>.from(json["status_guest_count"]!.map((x) => StatusGuestCount.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "booking_list": bookingList == null ? [] : List<dynamic>.from(bookingList!.map((x) => x.toJson())),
        "net_guest_count": netGuestCount,
        "status": status,
        "status_guest_count": statusGuestCount == null ? [] : List<dynamic>.from(statusGuestCount!.map((x) => x.toJson())),
      };
}

class BookingList {
  DateTime? bookingDate;
  DateTime? bookingDatetime;
  String? bookingRef;
  String? customerAddress;
  String? customerEmail;
  String? customerId;
  String? customerName;
  String? customerPhone;
  String? endDatetime;
  String? orderNo;
  String? staffId;
  DateTime? startDatetime;
  String? statusType;
  List<TableList>? tableList;
  int? totalGuestCount;

  BookingList({
    this.bookingDate,
    this.bookingDatetime,
    this.bookingRef,
    this.customerAddress,
    this.customerEmail,
    this.customerId,
    this.customerName,
    this.customerPhone,
    this.endDatetime,
    this.orderNo,
    this.staffId,
    this.startDatetime,
    this.statusType,
    this.tableList,
    this.totalGuestCount,
  });

  factory BookingList.fromJson(Map<String, dynamic> json) => BookingList(
        bookingDate: json["booking_date"] == null ? null : DateTime.parse(json["booking_date"]),
        bookingDatetime: json["booking_datetime"] == null ? null : DateTime.parse(json["booking_datetime"]),
        bookingRef: json["booking_ref"],
        customerAddress: json["customer_address"],
        customerEmail: json["customer_email"],
        customerId: json["customer_id"],
        customerName: json["customer_name"],
        customerPhone: json["customer_phone"],
        endDatetime: json["end_datetime"],
        orderNo: json["order_no"],
        staffId: json["staff_id"],
        startDatetime: json["start_datetime"] == null ? null : DateTime.parse(json["start_datetime"]),
        statusType: json["status_type"],
        tableList: json["table_list"] == null ? [] : List<TableList>.from(json["table_list"]!.map((x) => TableList.fromJson(x))),
        totalGuestCount: json["total_guest_count"],
      );

  Map<String, dynamic> toJson() => {
        "booking_date": "${bookingDate!.year.toString().padLeft(4, '0')}-${bookingDate!.month.toString().padLeft(2, '0')}-${bookingDate!.day.toString().padLeft(2, '0')}",
        "booking_datetime": bookingDatetime?.toIso8601String(),
        "booking_ref": bookingRef,
        "customer_address": customerAddress,
        "customer_email": customerEmail,
        "customer_id": customerId,
        "customer_name": customerName,
        "customer_phone": customerPhone,
        "end_datetime": endDatetime,
        "order_no": orderNo,
        "staff_id": staffId,
        "start_datetime": startDatetime?.toIso8601String(),
        "status_type": statusType,
        "table_list": tableList == null ? [] : List<dynamic>.from(tableList!.map((x) => x.toJson())),
        "total_guest_count": totalGuestCount,
      };
}

class TableList {
  int? guestCount;
  String? spaceId;
  String? spaceName;
  String? tableId;
  String? tableName;
  String? tableStaffId;

  TableList({
    this.guestCount,
    this.spaceId,
    this.spaceName,
    this.tableId,
    this.tableName,
    this.tableStaffId,
  });

  factory TableList.fromJson(Map<String, dynamic> json) => TableList(
        guestCount: json["guest_count"],
        spaceId: json["space_id"],
        spaceName: json["space_name"],
        tableId: json["table_id"],
        tableName: json["table_name"],
        tableStaffId: json["table_staff_id"],
      );

  Map<String, dynamic> toJson() => {
        "guest_count": guestCount,
        "space_id": spaceId,
        "space_name": spaceName,
        "table_id": tableId,
        "table_name": tableName,
        "table_staff_id": tableStaffId,
      };
}

class StatusGuestCount {
  String? statusType;
  int? totalGuestCount;

  StatusGuestCount({
    this.statusType,
    this.totalGuestCount,
  });

  factory StatusGuestCount.fromJson(Map<String, dynamic> json) => StatusGuestCount(
        statusType: json["status_type"],
        totalGuestCount: json["total_guest_count"],
      );

  Map<String, dynamic> toJson() => {
        "status_type": statusType,
        "total_guest_count": totalGuestCount,
      };
}
