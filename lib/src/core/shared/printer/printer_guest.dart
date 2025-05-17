import 'dart:developer';
import 'dart:typed_data';
import 'package:sunmi_printer_plus/enums.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'package:sunmi_printer_plus/sunmi_style.dart';

import '../../../data/datasources/local/local_data_source.dart';
import '../../../data/models/order_model.dart';
import '../../../data/models/settings_mode.dart';
import '../../../data/models/user_model.dart';
import '../../constants/hive_constants.dart';
import 'guest_print_bluetooth.dart';

Uint8List? printimge;

class PrinterInvoiceGuest {
  final OrderSingleton orderModel;
  final String? reportTitle;

  PrinterInvoiceGuest({required this.orderModel, this.reportTitle}) {
    SunmiPrinter.bindingPrinter();
  }

  //this is for check isFoodOnePortion
  Map<String, bool> foodPortionIdentify = {};

  String wordCutOfProtect(String str, int len) {
    if (str.length < len) {
      return str;
    }
    for (int i = 0; i < str.length; i += len) {
      if (i > str.length) {
        return str;
      }
      if (str[i] != ' ') {
        int j = i;
        String space = "";
        while (str[j] != ' ' && j > 0) {
          j--;
          space += ' ';
        }

        if (space.isNotEmpty && space.length < len) {
          str = (str.substring(0, i - space.length) + space + str.substring(i - space.length + 1, str.length));
        }
      }
    }
    return str;
  }

  //--------------------------------------format code start
  static const int maxChar = 47;
  static const int qtyLimit = 3;
  static const int priceLimit = 7;

  String addSpaceToAvoidWordBreking(String planStr) {
    const int limit = maxChar - qtyLimit - priceLimit - 2;
    for (int i = limit; i < planStr.length; i = i + limit) {
      if (planStr[i] != ' ') {
        String bSpace = "";
        for (int j = i - 1; planStr[j] != " "; j--) {
          bSpace += ' ';
        }
        planStr = planStr.substring(0, i - bSpace.length) + bSpace + planStr.substring(i - bSpace.length, planStr.length);
      }
    }
    return planStr;
  }

  String makeAlign(String planStr1) {
    String planStr = addSpaceToAvoidWordBreking(planStr1);
    int startPoint = 0;
    int endPoint = maxChar - (priceLimit + qtyLimit + 3);
    for (int i = 0; planStr.length < maxChar - (qtyLimit + priceLimit + 2); i++) {
      planStr += " ";
    }
    String tem = "";
    for (int i = 0; i < planStr.length; i++) {
      if (i == startPoint) {
        tem += "\n    ";
        if (planStr[i] == " ") {
          planStr = planStr.substring(0, i) + planStr.substring(i + 1, planStr.length);
        }
        startPoint += (maxChar - (qtyLimit + priceLimit) - 2);
      }
      tem += planStr[i];
      if (i == endPoint) {
        tem += "        ";
        endPoint += (maxChar - (priceLimit + qtyLimit + 2));
      }
    }
    return tem;
  }

  String makeQtyNamePrice(String qty, String name, String crySymbol, String price) {
    String result = makeAlign(name);
    result = qty + result.substring(qty.length + 1, qtyLimit + 1) + result.substring(qtyLimit + 1);
    result = result.substring(0, maxChar - (crySymbol.length + price.length)) + crySymbol + price + result.substring(maxChar);
    return result;
  }

  String separateByTwo(String s1, String mid, String s2) {
    String planStr = "";
    for (int i = 0; i < maxChar - (s1.length + s2.length); i++) {
      planStr += mid;
    }

    return s1 + planStr + s2;
  }

  String foodItemRowAlignString(OrderDetail oi, String crySymbol) {
    // final bool hasPortion = oi.foodId.isNotEmpty ? foodPortionIdentify[oi.foodId.first] as bool : false;
    String nameWithPortionStr = oi.itemName.toUpperCase().replaceAll('\n', ',');
    nameWithPortionStr = makeQtyNamePrice(oi.quantity < 0 ? "#" : oi.quantity.toString(), nameWithPortionStr, crySymbol, oi.totalTp.toStringAsFixed(2));

    //final String noteStr =theOrderForPrint.orderSource=='kukd'?oi.food[0].comment.isNotEmpty ? '\n${oi.food[0].comment.toString()}' : "" :oi.food[0].comment.isNotEmpty ? makeAlign("Note: " + oi.food[0].comment.toString()) : "";

    //final String bonusItem = oi.food[0].bonusItem.isNotEmpty ? makeAlign("[Bonus] " + oi.food[0].bonusItem[0].name.toUpperCase()) : "";

    return nameWithPortionStr;
  }

//*************************************Printing Modules****************************************

  Future<void> printStart() async {

    //String formattedString = formatOrderDetails(orderModel.orderData.orderDetails, HiveOperation().getData(HiveBoxKeys.currency));

    log(printimge.toString(), name: "printimge");

    User userInfo = await userFromJson(await HiveOperation().getData(HiveBoxKeys.userInfo));
    //sunmi print start
    await SunmiPrinter.startTransactionPrint(true);
    await SunmiPrinter.initPrinter();

    // //res logo and info,
    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    //  await SunmiPrinter.printImage(printimge!);
    log("this is sunmi printer");
    userInfo.restaurantInfo!.resImageBytes != null ? await SunmiPrinter.printImage(userInfo.restaurantInfo!.resImageBytes!) : null;
    await SunmiPrinter.lineWrap(1);
    await SunmiPrinter.printText(userInfo.restaurantInfo!.companyName.toString(), style: SunmiStyle(fontSize: SunmiFontSize.LG, align: SunmiPrintAlign.CENTER, bold: true));
    await SunmiPrinter.lineWrap(1);
    await SunmiPrinter.printText("${userInfo.restaurantInfo!.companyAddress},${userInfo.restaurantInfo!.city}", style: SunmiStyle(fontSize: SunmiFontSize.MD, align: SunmiPrintAlign.CENTER, bold: false));
    await SunmiPrinter.lineWrap(1);
    await SunmiPrinter.printText("Mobile No:${userInfo.restaurantInfo!.mobile}", style: SunmiStyle(fontSize: SunmiFontSize.MD, align: SunmiPrintAlign.CENTER, bold: false));
    await SunmiPrinter.lineWrap(1);
    await SunmiPrinter.printText("Guest Bill", style: SunmiStyle(fontSize: SunmiFontSize.MD, align: SunmiPrintAlign.CENTER, bold: false));
    await SunmiPrinter.lineWrap(1);
    await SunmiPrinter.printText("MUSAK -6.3", style: SunmiStyle(fontSize: SunmiFontSize.MD, align: SunmiPrintAlign.RIGHT, bold: false));
    await SunmiPrinter.lineWrap(1);
    //discardReason == null ? null : await SunmiPrinter.printText(discardReason, style: SunmiStyle(fontSize: SunmiFontSize.MD, align: SunmiPrintAlign.CENTER, bold: true));

    //title date
    //  reportTitle == null ? await SunmiPrinter.printText(orderType, style: SunmiStyle(fontSize: SunmiFontSize.MD, align: SunmiPrintAlign.CENTER, bold: true)) : await SunmiPrinter.printText(reportTitle.toString() + "- " + orderType, style: SunmiStyle(fontSize: SunmiFontSize.MD, align: SunmiPrintAlign.CENTER, bold: true));
    //theOrderForPrint.orderSource=="kukd"? await SunmiPrinter.printText('KUKD', style: SunmiStyle(fontSize: SunmiFontSize.LG, align: SunmiPrintAlign.CENTER, bold: true)):const SizedBox.shrink();

    //  AllService.autoDecimalActive=="0"?
    await SunmiPrinter.printText("Vat Registration No-${userInfo.restaurantInfo!.vatRegNo}", style: SunmiStyle(fontSize: SunmiFontSize.MD, align: SunmiPrintAlign.LEFT, bold: false));
    await SunmiPrinter.lineWrap(1);
    await SunmiPrinter.printText("Order No: ${orderModel.orderData.orderNo.toString()}", style: SunmiStyle(fontSize: SunmiFontSize.MD, align: SunmiPrintAlign.LEFT, bold: false));
    // :const SizedBox.shrink();
    await SunmiPrinter.printText("Date : ${orderModel.orderData.orderDatetime.toString()}", style: SunmiStyle(fontSize: SunmiFontSize.MD, align: SunmiPrintAlign.LEFT, bold: false));
    //theOrderForPrint.orderSource=="kukd"? await SunmiPrinter.printText(deliveryAndCollectionTime!, style: SunmiStyle(fontSize: SunmiFontSize.MD, align: SunmiPrintAlign.LEFT, bold: false)):const SizedBox.shrink();
    //theOrderForPrint.orderSource=="kukd"? await SunmiPrinter.printText(paidby!, style: SunmiStyle(fontSize: SunmiFontSize.MD, align: SunmiPrintAlign.LEFT, bold: true)):const SizedBox.shrink();

    // await SunmiPrinter.printText(printDatetime, style: SunmiStyle(fontSize: SunmiFontSize.MD, align: SunmiPrintAlign.LEFT, bold: false));

    await SunmiPrinter.lineWrap(1);
    //it will  apply later

    if (orderModel.orderData.bookingInfo.tableList.isNotEmpty) {
      String tableInfo = "table";
      tableInfo = await getTableData(orderModel.orderData.bookingInfo.tableList);
      await SunmiPrinter.printText("Tables: ${tableInfo}", style: SunmiStyle(fontSize: SunmiFontSize.MD, align: SunmiPrintAlign.LEFT, bold: false));
      await SunmiPrinter.printText("Covers: ${orderModel.orderData.bookingInfo.totalGuestCount.toString()}", style: SunmiStyle(fontSize: SunmiFontSize.MD, align: SunmiPrintAlign.LEFT, bold: false));
    }
    await SunmiPrinter.printText("Server: ${orderModel.orderData.staffId.toString()}", style: SunmiStyle(fontSize: SunmiFontSize.MD, align: SunmiPrintAlign.LEFT, bold: false));
    // tableNo != null ? await SunmiPrinter.printText(tableNo, style: SunmiStyle(fontSize: SunmiFontSize.MD, align: SunmiPrintAlign.LEFT, bold: true)) : null;
    // customerGuests != null ? await SunmiPrinter.printText(customerGuests, style: SunmiStyle(fontSize: SunmiFontSize.MD, align: SunmiPrintAlign.LEFT, bold: true)) : null;
    // customerName != null ? await SunmiPrinter.printText(customerName, style: SunmiStyle(fontSize: SunmiFontSize.MD, align: SunmiPrintAlign.LEFT, bold: false)) : null;

    //qty price and ---
    await SunmiPrinter.line(len: 48);
    await SunmiPrinter.printText(separateByTwo("Qty Items", " ", "Price"), style: SunmiStyle(fontSize: SunmiFontSize.MD, align: SunmiPrintAlign.LEFT, bold: true));
    await SunmiPrinter.line(len: 48);

    // //order list
    //await SunmiPrinter.printText(formattedString, style: SunmiStyle(fontSize: SunmiFontSize.MD, align: SunmiPrintAlign.LEFT, bold: true));

    // //promotion bonus
    //bonusItem == null ? null : await SunmiPrinter.line(len: 48);
    //bonusItem == null ? null : await SunmiPrinter.printText(bonusItem, style: SunmiStyle(fontSize: SunmiFontSize.MD, align: SunmiPrintAlign.CENTER, bold: false));

    //subtotal
    await SunmiPrinter.line(len: 48);

    await SunmiPrinter.printText(separateByTwo("Subtotal:", " ", orderModel.orderData.totalTp.toStringAsFixed(2)), style: SunmiStyle(fontSize: SunmiFontSize.MD, align: SunmiPrintAlign.LEFT, bold: false));
    await SunmiPrinter.printText(separateByTwo("Discount:", " ", orderModel.orderData.totalDiscount.toStringAsFixed(2)), style: SunmiStyle(fontSize: SunmiFontSize.MD, align: SunmiPrintAlign.LEFT, bold: false));
    await SunmiPrinter.printText(separateByTwo("Service Expense(${userInfo.restaurantInfo!.serviceExp.toString()}%):", " ", orderModel.orderData.serviceExpense.toStringAsFixed(2)), style: SunmiStyle(fontSize: SunmiFontSize.MD, align: SunmiPrintAlign.LEFT, bold: false));

    //dis tips/service vat
    //await SunmiPrinter.printText(separateByTwo("Discount:", " ", orderModel.orderData.totalDiscount.toStringAsFixed(2)), style: SunmiStyle(fontSize: SunmiFontSize.MD, align: SunmiPrintAlign.LEFT, bold: false));
    await SunmiPrinter.printText(separateByTwo("Vat(${userInfo.restaurantInfo!.branchVat.toString()}%):", " ", orderModel.orderData.totalTax.toStringAsFixed(2)), style: SunmiStyle(fontSize: SunmiFontSize.MD, align: SunmiPrintAlign.LEFT, bold: false));
    // tips > 0.0 ? await SunmiPrinter.printText(separateByTwo("Service/Tips:", " ", ResInfo.currSym + tips), style: SunmiStyle(fontSize: SunmiFontSize.MD, align: SunmiPrintAlign.LEFT, bold: false)) : null;
    // tax > 0.0 ? await SunmiPrinter.printText(separateByTwo("Vat(${(ResInfo.vat * 100)}%):", " ", ResInfo.currSym + tax), style: SunmiStyle(fontSize: SunmiFontSize.MD, align: SunmiPrintAlign.LEFT, bold: false)) : null;
    //del and bag
    //  theOrderForPrint.orderSource=='kukd'&&theOrderForPrint.tips.length>1? await SunmiPrinter.printText(separateByTwo("Bag Charge", " ", '${ResInfo.currSym}${theOrderForPrint.tips.length>1? (theOrderForPrint.tips[1].tip):0.00}'), style: SunmiStyle(fontSize: SunmiFontSize.MD, align: SunmiPrintAlign.LEFT, bold: false)) : null;
    // theOrderForPrint.orderSource=='kukd'&&theOrderForPrint.tips.length>2? await SunmiPrinter.printText(separateByTwo("Delivery Charge", " ", '${ResInfo.currSym}${theOrderForPrint.tips.length>2? (theOrderForPrint.tips[2].tip):0.00}'), style: SunmiStyle(fontSize: SunmiFontSize.MD, align: SunmiPrintAlign.LEFT, bold: false)) : null;

    // //total
    await SunmiPrinter.line(len: 48);
    await SunmiPrinter.printText(separateByTwo("Total:", " ", orderModel.orderData.grandTotal.toStringAsFixed(2)), style: SunmiStyle(fontSize: SunmiFontSize.MD, align: SunmiPrintAlign.LEFT, bold: false));

    await SunmiPrinter.lineWrap(1);
    orderModel.orderData.note.isNotEmpty ? await SunmiPrinter.printText("Note: ${orderModel.orderData.note}", style: SunmiStyle(fontSize: SunmiFontSize.MD, align: SunmiPrintAlign.CENTER, bold: true)) : null;

    orderModel.orderData.note.isNotEmpty ? await SunmiPrinter.lineWrap(1) : null;
    await SunmiPrinter.printText("Thank you for coming", style: SunmiStyle(fontSize: SunmiFontSize.MD, align: SunmiPrintAlign.CENTER, bold: true));

    await SunmiPrinter.lineWrap(1);
    await SunmiPrinter.printText("Powered By - 3DineBase", style: SunmiStyle(fontSize: SunmiFontSize.MD, align: SunmiPrintAlign.CENTER, bold: true));

    await SunmiPrinter.lineWrap(1);

    //customer info for delivery
    // customerDetails != null ? await SunmiPrinter.printText("$orderType Details:", style: SunmiStyle(fontSize: SunmiFontSize.MD, align: SunmiPrintAlign.LEFT, bold: true)) : null;
    //  customerDetails != null ? await SunmiPrinter.printText(customerDetails, style: SunmiStyle(fontSize: SunmiFontSize.MD, align: SunmiPrintAlign.LEFT, bold: false)) : null;

    //bootom msg
    // await SunmiPrinter.printText(bootomMsg, style: SunmiStyle(fontSize: SunmiFontSize.MD, align: SunmiPrintAlign.CENTER, bold: false));

    //sunmi print stop
    await SunmiPrinter.cut();
    await SunmiPrinter.exitTransactionPrint(true);
  }

  Future<String> getTableData(List<TableList> tableInfo) async {
    String tableNameList = "";

    if (tableInfo.isNotEmpty) {
      log(tableInfo.toString());
      for (int i = 0; i < tableInfo.length; i++) {
        tableNameList = "$tableNameList${tableInfo[i].tableName},";
      }
    }

    return tableNameList;
  }
}
