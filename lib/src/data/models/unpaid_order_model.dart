// To parse this JSON data, do
//
//     final unpaidOrder = unpaidOrderFromJson(jsonString);

import 'dart:convert';

import 'order_model.dart';

UnpaidOrder unpaidOrderFromJson(String str) => UnpaidOrder.fromJson(json.decode(str));

String unpaidOrderToJson(UnpaidOrder data) => json.encode(data.toJson());

class UnpaidOrder {
  String? status;
  List<OrderDatum>? orderData;

  UnpaidOrder({
    this.status,
    this.orderData,
  });

  factory UnpaidOrder.fromJson(Map<String, dynamic> json) => UnpaidOrder(
    status: json["status"],
    orderData: json["order_data"] == null ? [] : List<OrderDatum>.from(json["order_data"]!.map((x) => OrderDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "order_data": orderData == null ? [] : List<dynamic>.from(orderData!.map((x) => x.toJson())),
  };
}

class OrderDatum {
  String? orderType;
  List<UnpaidOrderList>? unpaidOrderList;

  OrderDatum({
    this.orderType,
    this.unpaidOrderList,
  });

  factory OrderDatum.fromJson(Map<String, dynamic> json) => OrderDatum(
    orderType: json["order_type"],
    unpaidOrderList: json["unpaid_order_list"] == null ? [] : List<UnpaidOrderList>.from(json["unpaid_order_list"]!.map((x) => UnpaidOrderList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "order_type": orderType,
    "unpaid_order_list": unpaidOrderList == null ? [] : List<dynamic>.from(unpaidOrderList!.map((x) => x.toJson())),
  };
}

class UnpaidOrderList {
  String? cid;
  String? branchId;
  String? orderNo;
  DateTime? orderDatetime;
  String? orderType;
  String? orderChannel;
  String? customerId;
  String? customerName;
  String? customerPhone;
  String? customerEmail;
  String? customerAddress;
  String? staffId;
  String? promoCode;
  double? totalTp;
  double? totalTax;
  double? totalDiscount;
  double? promoDiscount;
  double? flatDiscount;
  double? approvedDiscount;
  double? regularDiscount;
  double? othersDiscount;
  double? grandTotal;
  double? collectionAmnt;
  double? duesAmnt;
  String? orderStatus;
  String? paymentStatus;
  String? statusType;
  List<OrderDetail>? orderDetails;

  UnpaidOrderList({
    this.cid,
    this.branchId,
    this.orderNo,
    this.orderDatetime,
    this.orderType,
    this.orderChannel,
    this.customerId,
    this.customerName,
    this.customerPhone,
    this.customerEmail,
    this.customerAddress,
    this.staffId,
    this.promoCode,
    this.totalTp,
    this.totalTax,
    this.totalDiscount,
    this.promoDiscount,
    this.flatDiscount,
    this.approvedDiscount,
    this.regularDiscount,
    this.othersDiscount,
    this.grandTotal,
    this.collectionAmnt,
    this.duesAmnt,
    this.orderStatus,
    this.paymentStatus,
    this.statusType,
    this.orderDetails,
  });

  factory UnpaidOrderList.fromJson(Map<String, dynamic> json) => UnpaidOrderList(
    cid: json["cid"],
    branchId: json["branch_id"],
    orderNo: json["order_no"],
    orderDatetime: json["order_datetime"] == null ? null : DateTime.parse(json["order_datetime"]),
    orderType: json["order_type"],
    orderChannel: json["order_channel"],
    customerId: json["customer_id"],
    customerName: json["customer_name"],
    customerPhone: json["customer_phone"],
    customerEmail: json["customer_email"],
    customerAddress: json["customer_address"],
    staffId: json["staff_id"],
    promoCode: json["promo_code"],
    totalTp: json["total_tp"]?.toDouble(),
    totalTax: json["total_tax"]?.toDouble(),
    totalDiscount: json["total_discount"]?.toDouble(),
    promoDiscount: json["promo_discount"]?.toDouble(),
    flatDiscount: json["flat_discount"]?.toDouble(),
    approvedDiscount: json["approved_discount"]?.toDouble(),
    regularDiscount: json["regular_discount"]?.toDouble(),
    othersDiscount: json["others_discount"]?.toDouble(),
    grandTotal: json["grand_total"]?.toDouble(),
    collectionAmnt: json["collection_amnt"]?.toDouble(),
    duesAmnt: json["dues_amnt"]?.toDouble(),
    orderStatus: json["order_status"],
    paymentStatus: json["payment_status"],
    statusType: json["status_type"],
    orderDetails: json["order_details"] == null ? [] : List<OrderDetail>.from(json["order_details"]!.map((x) => OrderDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "cid": cid,
    "branch_id": branchId,
    "order_no": orderNo,
    "order_datetime": orderDatetime?.toIso8601String(),
    "order_type": orderType,
    "order_channel": orderChannel,
    "customer_id": customerId,
    "customer_name": customerName,
    "customer_phone": customerPhone,
    "customer_email": customerEmail,
    "customer_address": customerAddress,
    "staff_id": staffId,
    "promo_code": promoCode,
    "total_tp": totalTp,
    "total_tax": totalTax,
    "total_discount": totalDiscount,
    "promo_discount": promoDiscount,
    "flat_discount": flatDiscount,
    "approved_discount": approvedDiscount,
    "regular_discount": regularDiscount,
    "others_discount": othersDiscount,
    "grand_total": grandTotal,
    "collection_amnt": collectionAmnt,
    "dues_amnt": duesAmnt,
    "order_status": orderStatus,
    "payment_status": paymentStatus,
    "status_type": statusType,
    "order_details": orderDetails == null ? [] : List<dynamic>.from(orderDetails!.map((x) => x.toJson())),
  };
}

// class OrderDetail {
//   String? itemId;
//   String? itemName;
//   String? portionSize;
//   String? itemType;
//   int? quantity;
//   int? bonusQuantity;
//   double? unitPrice;
//   double? totalTp;
//   double? totalTax;
//   double? discount;
//   double? grandTotal;
//   String? promotionType;
//   String? promotionRefarence;
//
//   OrderDetail({
//     this.itemId,
//     this.itemName,
//     this.portionSize,
//     this.itemType,
//     this.quantity,
//     this.bonusQuantity,
//     this.unitPrice,
//     this.totalTp,
//     this.totalTax,
//     this.discount,
//     this.grandTotal,
//     this.promotionType,
//     this.promotionRefarence,
//   });
//
//   factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
//     itemId: json["item_id"],
//     itemName: json["item_name"],
//     portionSize: json["portion_size"],
//     itemType: json["item_type"],
//     quantity: json["quantity"],
//     bonusQuantity: json["bonus_quantity"],
//     unitPrice: json["unit_price"]?.toDouble(),
//     totalTp: json["total_tp"]?.toDouble(),
//     totalTax: json["total_tax"]?.toDouble(),
//     discount: json["discount"]?.toDouble(),
//     grandTotal: json["grand_total"]?.toDouble(),
//     promotionType: json["promotion_type"],
//     promotionRefarence: json["promotion_refarence"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "item_id": itemId,
//     "item_name": itemName,
//     "portion_size": portionSize,
//     "item_type": itemType,
//     "quantity": quantity,
//     "bonus_quantity": bonusQuantity,
//     "unit_price": unitPrice,
//     "total_tp": totalTp,
//     "total_tax": totalTax,
//     "discount": discount,
//     "grand_total": grandTotal,
//     "promotion_type": promotionType,
//     "promotion_refarence": promotionRefarence,
//   };
// }
