import 'dart:convert';

NotificationModel notificatoinModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificatoinModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  // Data fields
  String status = "";
  OrderDataOfNotification orderData = OrderDataOfNotification();

  // Constructor
  NotificationModel();

  // Clear all data method
  void clearAllData() {
    status = "";
    orderData = OrderDataOfNotification();
  }

  // Factory method to create an instance from JSON
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel()
      ..status = json["status"] ?? ""
      ..orderData = json["order_data"] == null ? OrderDataOfNotification() : OrderDataOfNotification.fromJson(json["order_data"]);
  }

  // Convert instance to JSON
  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "order_data": orderData.toJson(),
    };
  }
}
class OrderDataOfNotification {
  String cid = "";
  String branchId = "";
  String orderNo = "";
  DateTime orderDatetime = DateTime.now();
  String orderType = "";
  String orderChannel = "";
  String customerId = "";
  String customerName = "";
  String customerPhone = "";
  String customerEmail = "";
  String customerAddress = "";
  String staffId = "";
  String bookingRefNo = "";
  String promoCode = "";
  double totalTp = 0.0;
  double totalTax = 0.0;
  double totalDiscount = 0.0;
  double promoDiscount = 0.0;
  double flatDiscount = 0.0;
  double approvedDiscount = 0.0;
  double grandTotal = 0.0;
  double regulerDiscout = 0.0;
  double otherDiscount = 0.0;
  double collectionAmount = 0.0;
  double dueAmount = 0.0;
  String orderStatus="";
  String paymentStatus="";

  String statusType = "";
  List<OrderDetailOfNotification> orderDetails = [];
  BookingInfoOfNotification bookingInfo = BookingInfoOfNotification();

  OrderDataOfNotification({
    this.cid = "",
    this.branchId = "",
    this.orderNo = "",
    DateTime? orderDatetime,
    this.orderType = "",
    this.orderChannel = "",
    this.customerId = "",
    this.customerName = "",
    this.customerPhone = "",
    this.customerEmail = "",
    this.customerAddress = "",
    this.staffId = "",
    this.bookingRefNo = "",
    this.promoCode = "",
    this.totalTp = 0.0,
    this.totalTax = 0.0,
    this.totalDiscount = 0.0,
    this.promoDiscount = 0.0,
    this.flatDiscount = 0.0,
    this.approvedDiscount = 0.0,
    this.grandTotal = 0.0,
    this.otherDiscount = 0.0,
    this.regulerDiscout = 0.0,
    this.collectionAmount = 0.0,
    this.dueAmount = 0.0,
    this.paymentStatus="",
    this.orderStatus="",
    this.statusType = "",
    List<OrderDetailOfNotification>? orderDetails,
    BookingInfoOfNotification? bookingInfo,
  })  : orderDatetime = orderDatetime ?? DateTime.now(),
        orderDetails = orderDetails ?? [],
        bookingInfo = bookingInfo ?? BookingInfoOfNotification();

  // Factory method to create an instance from JSON
  factory OrderDataOfNotification.fromJson(Map<String, dynamic> json) {
    return OrderDataOfNotification(
      cid: json["cid"] ?? "",
      branchId: json["branch_id"] ?? "",
      orderNo: json["order_no"] ?? "",
      orderDatetime: json["order_datetime"] == null ? DateTime.now() : DateTime.parse(json["order_datetime"]),
      orderType: json["order_type"] ?? "",
      orderChannel: json["order_channel"] ?? "",
      customerId: json["customer_id"] ?? "",
      customerName: json["customer_name"] ?? "",
      customerPhone: json["customer_phone"] ?? "",
      customerEmail: json["customer_email"] ?? "",
      customerAddress: json["customer_address"] ?? "",
      staffId: json["staff_id"] ?? "",
      bookingRefNo: json["booking_ref_no"] ?? "",
      promoCode: json["promo_code"] ?? "",
      totalTp: json["total_tp"] ?? 0.0,
      totalTax: json["total_tax"] ?? 0.0,
      totalDiscount: json["total_discount"] ?? 0.0,
      promoDiscount: json["promo_discount"] ?? 0.0,
      flatDiscount: json["flat_discount"] ?? 0.0,
      approvedDiscount: json["approved_discount"] ?? 0.0,
      grandTotal: json["grand_total"] ?? 0.0,
      regulerDiscout: json["regular_discount"] ?? 0.0,
      otherDiscount: json["others_discount"] ?? 0.0,
      collectionAmount: json["collection_amnt"] ?? 0.0,
      dueAmount: json["dues_amnt"] ?? 0.0,
      orderStatus: json["order_status"] ?? "",
      paymentStatus: json["payment_status"] ?? "",
      statusType: json["status_type"] ?? "",
      orderDetails: json["order_details"] == null ? [] : List<OrderDetailOfNotification>.from(json["order_details"]!.map((x) => OrderDetailOfNotification.fromJson(x))),
      bookingInfo: json["booking_info"] == null ? BookingInfoOfNotification() : BookingInfoOfNotification.fromJson(json["booking_info"]),
    );
  }

  // Convert instance to JSON
  Map<String, dynamic> toJson() {
    return {
      "cid": cid,
      "branch_id": branchId,
      "order_no": orderNo,
      "order_datetime": orderDatetime.toIso8601String(),
      "order_type": orderType,
      "order_channel": orderChannel,
      "customer_id": customerId,
      "customer_name": customerName,
      "customer_phone": customerPhone,
      "customer_email": customerEmail,
      "customer_address": customerAddress,
      "staff_id": staffId,
      "booking_ref_no": bookingRefNo,
      "promo_code": promoCode,
      "total_tp": totalTp,
      "total_tax": totalTax,
      "total_discount": totalDiscount,
      "promo_discount": promoDiscount,
      "flat_discount": flatDiscount,
      "approved_discount": approvedDiscount,
      "grand_total": grandTotal,
      "regular_discount": regulerDiscout,
      "others_discount": otherDiscount,
      "collection_amnt": collectionAmount,
      "dues_amnt": dueAmount,
      "order_status": orderStatus,
      "payment_status": paymentStatus,
      "status_type": statusType,
      "order_details": List<dynamic>.from(orderDetails.map((x) => x.toJson())),
      "booking_info": bookingInfo.toJson(),
    };
  }
}

class BookingInfoOfNotification {
  String bookingRefNo = "";
  DateTime bookingDate = DateTime.now();
  DateTime bookingDatetime = DateTime.now();
  DateTime startDatetime = DateTime.now();
  String endDatetime = "";
  int totalGuestCount = 0;
  String staffId = "";
  String statusType = "";
  List<TableListOfNotification> tableList = [];

  BookingInfoOfNotification({
    this.bookingRefNo = "",
    DateTime? bookingDate,
    DateTime? bookingDatetime,
    DateTime? startDatetime,
    this.endDatetime = "",
    this.totalGuestCount = 0,
    this.staffId = "",
    this.statusType = "",
    List<TableListOfNotification>? tableList,
  })  : bookingDate = bookingDate ?? DateTime.now(),
        bookingDatetime = bookingDatetime ?? DateTime.now(),
        startDatetime = startDatetime ?? DateTime.now(),
        tableList = tableList ?? [];

  // Factory method to create an instance from JSON
  factory BookingInfoOfNotification.fromJson(Map<String, dynamic> json) {
    return BookingInfoOfNotification(
      bookingRefNo: json["booking_ref_no"] ?? "",
      bookingDate: json["booking_date"] == null ? DateTime.now() : DateTime.parse(json["booking_date"]),
      bookingDatetime: json["booking_datetime"] == null ? DateTime.now() : DateTime.parse(json["booking_datetime"]),
      startDatetime: json["start_datetime"] == null ? DateTime.now() : DateTime.parse(json["start_datetime"]),
      endDatetime: json["end_datetime"] ?? "",
      totalGuestCount: json["total_guest_count"] ?? 0,
      staffId: json["staff_id"] ?? "",
      statusType: json["status_type"] ?? "",
      tableList: json["table_list"] == null ? [] : List<TableListOfNotification>.from(json["table_list"]!.map((x) => TableListOfNotification.fromJson(x))),
    );
  }

  // Convert instance to JSON
  Map<String, dynamic> toJson() {
    return {
      "booking_ref_no": bookingRefNo,
      "booking_date": "${bookingDate.year.toString().padLeft(4, '0')}-${bookingDate.month.toString().padLeft(2, '0')}-${bookingDate.day.toString().padLeft(2, '0')}",
      "booking_datetime": bookingDatetime.toIso8601String(),
      "start_datetime": startDatetime.toIso8601String(),
      "end_datetime": endDatetime,
      "total_guest_count": totalGuestCount,
      "staff_id": staffId,
      "status_type": statusType,
      "table_list": List<dynamic>.from(tableList.map((x) => x.toJson())),
    };
  }
}

class TableListOfNotification {
  String spaceId = "";
  String spaceName = "";
  String tableId = "";
  String tableName = "";
  int guestCount = 0;
  String tableStaffId = "";

  TableListOfNotification({
    this.spaceId = "",
    this.spaceName = "",
    this.tableId = "",
    this.tableName = "",
    this.guestCount = 0,
    this.tableStaffId = "",
  });

  // Factory method to create an instance from JSON
  factory TableListOfNotification.fromJson(Map<String, dynamic> json) {
    return TableListOfNotification(
      spaceId: json["space_id"] ?? "",
      spaceName: json["space_name"] ?? "",
      tableId: json["table_id"] ?? "",
      tableName: json["table_name"] ?? "",
      guestCount: json["guest_count"] ?? 0,
      tableStaffId: json["table_staff_id"] ?? "",
    );
  }

  // Convert instance to JSON
  Map<String, dynamic> toJson() {
    return {
      "space_id": spaceId,
      "space_name": spaceName,
      "table_id": tableId,
      "table_name": tableName,
      "guest_count": guestCount,
      "table_staff_id": tableStaffId,
    };
  }
}

class OrderDetailOfNotification {
  String itemId = "";
  String itemName = "";
  String portionSize = "";
  String itemType = "";
  int quantity = 0;
  int bonusQuantity = 0;
  double unitPrice = 0.0;
  double totalTp = 0.0;
  double totalTax = 0.0;
  double discount = 0.0;
  double grandTotal = 0.0;
  String promotionType = "";
  String promotionRefarence = "";

  OrderDetailOfNotification({
    this.itemId = "",
    this.itemName = "",
    this.portionSize = "",
    this.itemType = "",
    this.quantity = 0,
    this.bonusQuantity = 0,
    this.unitPrice = 0.0,
    this.totalTp = 0.0,
    this.totalTax = 0.0,
    this.discount = 0.0,
    this.grandTotal = 0.0,
    this.promotionType = "",
    this.promotionRefarence = "",
  });

  // Factory method to create an instance from JSON
  factory OrderDetailOfNotification.fromJson(Map<String, dynamic> json) {
    return OrderDetailOfNotification(
      itemId: json["item_id"] ?? "",
      itemName: json["item_name"] ?? "",
      portionSize: json["portion_size"] ?? "",
      itemType: json["item_type"] ?? "",
      quantity: json["quantity"] ?? 0,
      bonusQuantity: json["bonus_quantity"] ?? 0,
      unitPrice: json["unit_price"] ?? 0.0,
      totalTp: json["total_tp"] ?? 0.0,
      totalTax: json["total_tax"] ?? 0.0,
      discount: json["discount"] ?? 0.0,
      grandTotal: json["grand_total"] ?? 0.0,
      promotionType: json["promotion_type"] ?? "",
      promotionRefarence: json["promotion_refarence"] ?? "",
    );
  }

  // Convert instance to JSON
  Map<String, dynamic> toJson() {
    return {
      "item_id": itemId,
      "item_name": itemName,
      "portion_size": portionSize,
      "item_type": itemType,
      "quantity": quantity,
      "bonus_quantity": bonusQuantity,
      "unit_price": unitPrice,
      "total_tp": totalTp,
      "total_tax": totalTax,
      "discount": discount,
      "grand_total": grandTotal,
      "promotion_type": promotionType,
      "promotion_refarence": promotionRefarence,
    };
  }
}
