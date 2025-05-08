import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../../data/datasources/local/local_data_source.dart';
import '../../../data/models/notificationModel.dart';
import '../../../data/models/order_model.dart';
import '../../../data/models/settings_mode.dart';
import '../../../data/models/table_status_model.dart';
import '../../../data/models/user_model.dart';
import '../../../features/home_screen/kiosk_home_screen.dart';
import '../../constants/hive_constants.dart';

String branchId = "";
AllSettings allSettings = AllSettings();
User userInfo = User();

class FirebaseAPIs {
  static FirebaseFirestore mDB = FirebaseFirestore.instanceFor( app: Firebase.app(),
      databaseId: "dinebase");
  TableStatusModel tableStatusModel = TableStatusModel();

  Future<bool> getInformation() async {
    try {
      allSettings = allSettingsFromJson(await HiveOperation().getSettingsData(HiveBoxKeys.allSettings));
      userInfo = userFromJson(await HiveOperation().getData(HiveBoxKeys.userInfo));
      log("initialized");
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<void> addTableInFireBase(Map<String, dynamic> tableData, String tableRef) async {
    // await freeTable(tableData, tableRef);
    // {cid: DBH, branch_id: DBH-B001,
    // staff_id: dbh-001,
    // order_space: [{space_id: G-01, table_id: GB-01, guest_count: 0}]}
    String spaceID = "";
    String tableID = "";
    //  branchId = tableData['branch_id'];
    List tableList = tableData['order_space'];

    for (int i = 0; i < tableData['order_space'].length; i++) {
      tableStatusModel.spaceId = tableData['order_space'][i]['space_id'].toString();
      tableStatusModel.tableId = tableData['order_space'][i]['table_id'].toString();
      tableStatusModel.tableName = tableData['order_space'][i]['table_name'].toString();
      tableStatusModel.statusType = TableStatus.reserved.name;
      tableStatusModel.tableRef = tableRef;
      tableStatusModel.capacity = int.parse(tableData["total_guest_count"] ?? "0");
      await mDB.collection('companyList').doc(userInfo.userInfo!.cid).collection("branchList").doc(userInfo.userInfo!.branchId).collection("tableList").doc(tableStatusModel.spaceId.toString() + tableStatusModel.tableId.toString()).set(tableStatusModel.toJson());
    }
  }

  Future<void> editTableInFireBase(Map<String, dynamic> tableData, String tableRef) async {
    String previousStatus = "";
    if (orderModel.orderData.orderNo.isEmpty && allSettings.branchSettings!.payFirstEnabled!) {
      previousStatus = TableStatus.reserved.name.toString();
    } else {
      previousStatus = await freeTable(tableData, tableRef);
    }
    // {cid: DBH, branch_id: DBH-B001,
    // staff_id: dbh-001,
    // order_space: [{space_id: G-01, table_id: GB-01, guest_count: 0}]}
    // String spaceID = "";
    // String tableID = "";
    //  branchId = tableData['branch_id'];
    List tableList = tableData['order_space'];

    for (int i = 0; i < tableData['order_space'].length; i++) {
      log("again inserting data in table");
      tableStatusModel.orderNo = orderModel.orderData.orderNo;
      tableStatusModel.spaceId = tableData['order_space'][i]['space_id'].toString();
      tableStatusModel.tableId = tableData['order_space'][i]['table_id'].toString();
      tableStatusModel.tableName = tableData['order_space'][i]['table_name'].toString();
      tableStatusModel.statusType = previousStatus.toLowerCase();
      tableStatusModel.tableRef = tableRef;
      tableStatusModel.capacity = int.parse(tableData["total_guest_count"] ?? "0");
      await mDB.collection('companyList').doc(userInfo.userInfo!.cid).collection("branchList").doc(userInfo.userInfo!.branchId).collection("tableList").doc(tableStatusModel.spaceId.toString() + tableStatusModel.tableId.toString()).set(tableStatusModel.toJson());
    }
  }

  Future<void> addOrderToFireBase(
    OrderSingleton orderSingleton,
  ) async {
    print("add order mthod is called ${orderSingleton.orderData.orderNo.toString()}");
    // {cid: DBH, branch_id: DBH-B001,
    // staff_id: dbh-001,
    // order_space: [{space_id: G-01, table_id: GB-01, guest_count: 0}]}
    // {"cid":"DBH","branch_id":"DBH-B001","order_type":"Dine-in",
    // "customer_id":"","staff_id":"dbh-001","table_ref":"1039","order_id":"",
    // "table_info":
    // [{"space_id":"G-01","table_id":"BH-01","guest_count":0,
    // "staff_id":"dbh-001"},{"space_id":"G-01","table_id":"MB-01","guest_count":0,
    // "staff_id":"dbh-001"}],"order_info":{"items":[{"item_id":"102","item_name":"French Fries","item_type":"Main","portion_size":"","unit_price":"2.49","quantity":2,"bonus_qty":0,"total_price":"3.98","promotion_refarence":"","promotion_type":"","item_discount":"1.00","item_tax":"0.0","item_total":"4.98"},{"item_id":"102","item_name":"French Fries","item_type":"Main","portion_size":"","unit_price":"2.49","quantity":1,"bonus_qty":0,"total_price":"1.99","promotion_refarence":"","promotion_type":"","item_discount":"0.50","item_tax":"0.0","item_total":"2.49"}],
    // "sub_total":"7.47","discount":"1.50","tax":"0.00","grand_total":"5.97"}}
    // String spaceID = "";
    // String tableID = "";
    // branchId = orderSingleton.orderData.branchId;
    List<TableList> tableList = orderSingleton.orderData.bookingInfo.tableList;

    for (int i = 0; i < tableList.length; i++) {
      tableStatusModel.spaceId = tableList[i].spaceId.toString();
      tableStatusModel.tableId = tableList[i].tableId.toString();
      tableStatusModel.statusType = TableStatus.ordered.name;
      tableStatusModel.orderNo = orderSingleton.orderData.orderNo.toString();
      await mDB
          .collection('companyList')
          .doc(userInfo.userInfo!.cid)
          .collection("branchList")
          .doc(userInfo.userInfo!.branchId)
          .collection("tableList")
          .doc(tableStatusModel.spaceId.toString() + tableStatusModel.tableId.toString())
          .update({"order_no": orderSingleton.orderData.orderNo.toString(), "status_type": tableStatusModel.statusType.toString()});
    }
    orderSingleton.orderData.statusType = TableStatus.ordered.name;
    // Map<String, dynamic> orderMap = orderSingleton.toJson();
    // orderMap['status_type'] = TableStatus.ordered.name;
    log("order adding");
    await mDB.collection('companyList').doc(userInfo.userInfo!.cid).collection("branchList").doc(userInfo.userInfo!.branchId).collection("orders").doc(orderSingleton.orderData.orderNo.toString()).set(orderSingleton.toJson());
  }
  Future<void> editOrderToFireBase(
      OrderSingleton orderSingleton,
      ) async {
    // print("edit order mthod is called ${orderSingleton.orderData.orderNo.toString()}");
    // {cid: DBH, branch_id: DBH-B001,
    // staff_id: dbh-001,
    // order_space: [{space_id: G-01, table_id: GB-01, guest_count: 0}]}
    // {"cid":"DBH","branch_id":"DBH-B001","order_type":"Dine-in",
    // "customer_id":"","staff_id":"dbh-001","table_ref":"1039","order_id":"",
    // "table_info":
    // [{"space_id":"G-01","table_id":"BH-01","guest_count":0,
    // "staff_id":"dbh-001"},{"space_id":"G-01","table_id":"MB-01","guest_count":0,
    // "staff_id":"dbh-001"}],"order_info":{"items":[{"item_id":"102","item_name":"French Fries","item_type":"Main","portion_size":"","unit_price":"2.49","quantity":2,"bonus_qty":0,"total_price":"3.98","promotion_refarence":"","promotion_type":"","item_discount":"1.00","item_tax":"0.0","item_total":"4.98"},{"item_id":"102","item_name":"French Fries","item_type":"Main","portion_size":"","unit_price":"2.49","quantity":1,"bonus_qty":0,"total_price":"1.99","promotion_refarence":"","promotion_type":"","item_discount":"0.50","item_tax":"0.0","item_total":"2.49"}],
    // "sub_total":"7.47","discount":"1.50","tax":"0.00","grand_total":"5.97"}}
    // String spaceID = "";
    // String tableID = "";
    // branchId = orderSingleton.orderData.branchId;
    // List<TableList> tableList = orderSingleton.orderData.bookingInfo.tableList;

    // for (int i = 0; i < tableList.length; i++) {
    //   tableStatusModel.spaceId = tableList[i].spaceId.toString();
    //   tableStatusModel.tableId = tableList[i].tableId.toString();
    //   tableStatusModel.statusType = TableStatus.ordered.name;
    //   tableStatusModel.orderNo = orderSingleton.orderData.orderNo.toString();
    //   await mDB
    //       .collection('companyList')
    //       .doc(userInfo.userInfo!.cid)
    //       .collection("branchList")
    //       .doc(userInfo.userInfo!.branchId)
    //       .collection("tableList")
    //       .doc(tableStatusModel.spaceId.toString() +
    //       tableStatusModel.tableId.toString())
    //       .update({
    //     "order_no": orderSingleton.orderData.orderNo.toString(),
    //     "status_type": tableStatusModel.statusType.toString()
    //   });
    // }
    // orderSingleton.orderData.statusType = TableStatus.ordered.name;
    // Map<String, dynamic> orderMap = orderSingleton.toJson();
    // orderMap['status_type'] = TableStatus.ordered.name;
    log("order editing order");
    String statusType =TableStatus.ordered.name.toLowerCase();
    //  List<Map<String, dynamic>> updatedOrderDetails = orderSingleton.orderData.orderDetails.map((e) => e.toJson()).toList();
    //orderSingleton.orderData.statusType =TableStatus.ordered.name.toLowerCase();
    final documentSnapshot = await mDB
        .collection('companyList')
        .doc(userInfo.userInfo!.cid)
        .collection("branchList")
        .doc(userInfo.userInfo!.branchId)
        .collection("orders")
        .doc(orderSingleton.orderData.orderNo.toString())
        .get();
    if(documentSnapshot.exists)
    {
      final newOrderSingleton =documentSnapshot.data();
      log(newOrderSingleton.toString(),name: "now status is");
      log(newOrderSingleton!["order_data"]["status_type"].toString(),name: "status");
      if(newOrderSingleton["order_data"]["status_type"].toString().toLowerCase()==TableStatus.cooking.name.toLowerCase())
      {
        statusType=TableStatus.cooking.name.toLowerCase();
      }

    }
    await mDB
        .collection('companyList')
        .doc(userInfo.userInfo!.cid)
        .collection("branchList")
        .doc(userInfo.userInfo!.branchId)
        .collection("orders")
        .doc(orderSingleton.orderData.orderNo.toString())
        .update({"order_data.order_details": orderSingleton.orderData.orderDetails.map((e) => e.toJson()).toList(), "order_data.status_type": statusType});
  }
  Future<void> updateOrderStatusToFireBase(
      NotificationModel notificationModel,String status
  ) async {
    await mDB
        .collection('companyList')
        .doc(userInfo.userInfo!.cid)
        .collection("branchList")
        .doc(userInfo.userInfo!.branchId)
        .collection("orders")
        .doc(notificationModel.orderData.orderNo.toString())
        .update({"order_data.status_type": status});
  }

  Future<void> deleteOrderToFireBase(
    OrderSingleton orderSingleton,
  ) async {
    print("delete mthod is called ${orderSingleton.orderData.orderNo.toString()}");
    String spaceID = "";
    String tableID = "";

    // branchId = orderSingleton.orderData.branchId;
    List<TableList> tableList = orderSingleton.orderData.bookingInfo.tableList;

    for (int i = 0; i < tableList.length; i++) {
      tableStatusModel.spaceId = tableList[i].spaceId.toString();
      tableStatusModel.tableId = tableList[i].tableId.toString();
      tableStatusModel.statusType = TableStatus.reserved.name;
      tableStatusModel.orderNo = "";
      await mDB
          .collection('companyList')
          .doc(userInfo.userInfo!.cid)
          .collection("branchList")
          .doc(userInfo.userInfo!.branchId)
          .collection("tableList")
          .doc(tableStatusModel.spaceId.toString() + tableStatusModel.tableId.toString())
          .update({"order_no": "", "status_type": tableStatusModel.statusType.toString()});
    }
    orderSingleton.orderData.statusType = TableStatus.reserved.name;
    // Map<String, dynamic> orderMap = orderSingleton.toJson();
    // orderMap['status_type'] = TableStatus.ordered.name;

    await mDB.collection('companyList').doc(userInfo.userInfo!.cid).collection("branchList").doc(userInfo.userInfo!.branchId).collection("orders").doc(orderSingleton.orderData.orderNo.toString()).delete();
  }

  Future<void> deleteOrderAfterServedToFireBase(
    NotificationModel orderSingleton,
  ) async {
    print("delete mthod is called ${orderSingleton.orderData.orderNo.toString()}");
    String spaceID = "";
    String tableID = "";

    // branchId = orderSingleton.orderData.branchId;
    List<TableListOfNotification> tableList = orderSingleton.orderData.bookingInfo.tableList;

    for (int i = 0; i < tableList.length; i++) {
      tableStatusModel.spaceId = tableList[i].spaceId.toString();
      tableStatusModel.tableId = tableList[i].tableId.toString();
      tableStatusModel.statusType = TableStatus.reserved.name;
      tableStatusModel.orderNo = "";
      await mDB.collection('companyList').doc(userInfo.userInfo!.cid).collection("branchList").doc(userInfo.userInfo!.branchId).collection("tableList").doc(tableStatusModel.spaceId.toString() + tableStatusModel.tableId.toString()).update({"status_type": orderStatus.Served.name.toLowerCase()});
    }
    orderSingleton.orderData.statusType = TableStatus.reserved.name;
    // Map<String, dynamic> orderMap = orderSingleton.toJson();
    // orderMap['status_type'] = TableStatus.ordered.name;
    try {
      await mDB.collection('companyList').doc(userInfo.userInfo!.cid).collection("branchList").doc(userInfo.userInfo!.branchId).collection("orders").doc(orderSingleton.orderData.orderNo.toString()).delete();
    } catch (e) {
      log(e.toString());
    }
  }

  // for getting table status
  Stream<QuerySnapshot<Map<String, dynamic>>> getFirebaseTableStatus() {
    return mDB.collection('companyList').doc(userInfo.userInfo!.cid).collection("branchList").doc(userInfo.userInfo!.branchId).collection("tableList").snapshots();
    // log('\nUserIds: $userIds');
    // if (userInfo.restaurantInfo != null) {
    //   return mDB.collection('companyList').doc(userInfo.userInfo!.cid).collection("branchList").doc("DBH-B001").collection("tableList").snapshots();
    // }
    // else {
    //   // Handle the case when userInfo or restaurantInfo is null.
    //   return const Stream.empty(); // Return an empty stream.
    // }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getFirebaseTableCount() {
    return mDB.collection('companyList').doc(userInfo.userInfo!.cid).collection("branchList").doc(userInfo.userInfo!.branchId).collection("tableList").snapshots();
    // log('\nUserIds: $userIds');
    // if (userInfo.restaurantInfo != null) {
    //   return mDB.collection('companyList').doc(userInfo.userInfo!.cid).collection("branchList").doc("DBH-B001").collection("tableList").snapshots();
    // }
    // else {
    //   // Handle the case when userInfo or restaurantInfo is null.
    //   return const Stream.empty(); // Return an empty stream.
    // }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getOrders() {
    // log('\nUserIds: $userIds');
    return mDB.collection('companyList').doc(userInfo.userInfo?.cid).collection("branchList").doc(userInfo.userInfo?.branchId).collection("orders").snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllOrderList() {
    // log('\nUserIds: $userIds');
    return mDB.collection('companyList').doc(userInfo.userInfo?.cid).collection("branchList").doc(userInfo.userInfo?.branchId).collection("orders").snapshots();
  }

  Future<List<NotificationModel>> getAllOrderListForCheckData() async {
    List<NotificationModel> dataList = [];
    try {
      QuerySnapshot querySnapshot = await  mDB.collection('companyList').doc(userInfo.userInfo?.cid).collection("branchList").doc(userInfo.userInfo?.branchId).collection("orders").get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> data = querySnapshot.docs as List<QueryDocumentSnapshot<Map<String, dynamic>>>;
      for (var i in data) {
        print("lskjdflksjlkfjsd");
        dataList.add(NotificationModel.fromJson(i.data()));
      }

      log(jsonEncode(dataList), name: "Data List form firebase");

      return dataList;
    } catch (e) {
      print("Error fetching data: $e");
      return [];
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllOrderListForDeliveryTakeAway() {
    // log('\nUserIds: $userIds');
    return mDB.collection('companyList').doc(userInfo.userInfo?.cid).collection("branchList").doc(userInfo.userInfo?.branchId).collection("orders").snapshots();
  }

  // for adding an chat user for our conversation
  Future<String> freeTable(Map<String, dynamic> tableData, String tableRef) async {
    String previousStatus = "reserved";
    try {
      var querySnapshot = await mDB
          .collection('companyList')
          .doc(userInfo.userInfo!.cid)
          .collection("branchList")
          .doc(userInfo.userInfo!.branchId)
          .collection("tableList")
          .where('table_ref', isEqualTo: tableRef) // Filtering by table_ref
          .get();

      // Delete each document found
      if (querySnapshot.docs.isNotEmpty) {
        previousStatus = querySnapshot.docs.first.get('status_type').toString().toLowerCase();
        log(previousStatus, name: "previous status");

        for (var doc in querySnapshot.docs) {
          log("first doing available then other thing");
          // await doc.reference.delete();
          await doc.reference.update({"status_type": "available", "table_ref": "", "capacity": 0, "order_no": ""});
        }
      }

      print("Documents with table_ref = $tableRef updated successfully.");
    } catch (e) {
      print("Error deleting documents: $e");
    }
    return previousStatus;
  }

  // // for adding an chat user for our conversation
  // Future<void> cancelOrder(
  //     Map<String, dynamic> tableData, String tableRef) async {
  //   try {
  //     var querySnapshot = await mDB
  //         .collection('companyList')
  //         .doc(userInfo.userInfo!.cid)
  //         .collection("branchList")
  //         .doc(branchId)
  //         .collection("tableList")
  //         .where('table_ref', isEqualTo: tableRef) // Filtering by table_ref
  //         .get();
  //
  //     // Delete each document found
  //     for (var doc in querySnapshot.docs) {
  //       log("deleting");
  //       // await doc.reference.delete();
  //       await doc.reference.update(
  //           {"status_type": "available", "table_ref": "", "capacity": 0});
  //     }
  //
  //     print("Documents with table_ref = $tableRef deleted successfully.");
  //   } catch (e) {
  //     print("Error deleting documents: $e");
  //   }
  //
  // }

  Future<void> updateTableStatus(String tableRef, String tableStatus) async {
    try {
      var querySnapshot = await mDB
          .collection('companyList')
          .doc(userInfo.userInfo!.cid)
          .collection("branchList")
          .doc(userInfo.userInfo!.branchId)
          .collection("tableList")
          .where('table_ref', isEqualTo: tableRef) // Filtering by table_ref
          .get();


      for (var doc in querySnapshot.docs) {
        log("updating order data");
        // await doc.reference.delete();
        await doc.reference.update({
          "status_type": tableStatus,
        });
      }

      print("Documents with table_ref = $tableRef updated successfully.");
    } catch (e) {
      print("Error deleting documents: $e");
    }
    if (tableStatus == "paid" && !(allSettings.branchSettings!.payFirstEnabled!)) {
      try {
        await mDB.collection('companyList').doc(userInfo.userInfo!.cid).collection("branchList").doc(userInfo.userInfo!.branchId).collection("orders").doc(orderModel.orderData.orderNo.toString()).delete();
      } catch (e) {
        log(e.toString());
      }
    }
  }
}
