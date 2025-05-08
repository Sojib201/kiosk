// // ignore_for_file: avoid_print
//
// import 'dart:convert';
// import 'dart:developer';
// import 'dart:typed_data';
// import 'package:esc_pos_utils/esc_pos_utils.dart';
// import '../../../data/datasources/local/local_data_source.dart';
// import '../../../data/models/order_model.dart';
// import '../../../data/models/settings_mode.dart';
// import '../../../data/models/user_model.dart';
// import 'package:image/image.dart' as img;
//
// import '../../../features/printer/set_up_wifi_printer.dart';
// import '../../constants/hive_constants.dart';
// import 'guest_print_bluetooth.dart';
//
// class PrinterInvoiceKitchenAndBarWifi {
//   final OrderSingleton orderModel;
//   bool printAll;
//   bool printNew;
//   bool printKitchen;
//   bool printBar;
//   Map<String, int>? newItemOrderPrint;
//
//   PrinterInvoiceKitchenAndBarWifi({required this.orderModel, required this.printAll, required this.printNew, required this.printKitchen, required this.printBar, this.newItemOrderPrint}) {}
//
//   //this is for check isFoodOnePortion
//   Map<String, bool> foodPortionIdentify = {};
//
//   String wordCutOfProtect(String str, int len) {
//     if (str.length < len) {
//       return str;
//     }
//     for (int i = 0; i < str.length; i += len) {
//       if (i > str.length) {
//         return str;
//       }
//       if (str[i] != ' ') {
//         int j = i;
//         String space = "";
//         while (str[j] != ' ' && j > 0) {
//           j--;
//           space += ' ';
//         }
//
//         if (space.isNotEmpty && space.length < len) {
//           str = (str.substring(0, i - space.length) + space + str.substring(i - space.length + 1, str.length));
//         }
//       }
//     }
//     return str;
//   }
//
//   //--------------------------------------format code start
//   static const int maxChar = 47;
//   static const int qtyLimit = 3;
//   static const int priceLimit = 7;
//
//   String addSpaceToAvoidWordBreking(String planStr) {
//     const int limit = maxChar - qtyLimit - priceLimit - 2;
//     for (int i = limit; i < planStr.length; i = i + limit) {
//       if (planStr[i] != ' ') {
//         String bSpace = "";
//         for (int j = i - 1; planStr[j] != " "; j--) {
//           bSpace += ' ';
//         }
//         planStr = planStr.substring(0, i - bSpace.length) + bSpace + planStr.substring(i - bSpace.length, planStr.length);
//       }
//     }
//     return planStr;
//   }
//
//   String makeAlign(String planStr1) {
//     String planStr = addSpaceToAvoidWordBreking(planStr1);
//     int startPoint = 0;
//     int endPoint = maxChar - (priceLimit + qtyLimit + 3);
//     for (int i = 0; planStr.length < maxChar - (qtyLimit + priceLimit + 2); i++) {
//       planStr += " ";
//     }
//     String tem = "";
//     for (int i = 0; i < planStr.length; i++) {
//       if (i == startPoint) {
//         tem += "\n    ";
//         if (planStr[i] == " ") {
//           planStr = planStr.substring(0, i) + planStr.substring(i + 1, planStr.length);
//         }
//         startPoint += (maxChar - (qtyLimit + priceLimit) - 2);
//       }
//       tem += planStr[i];
//       if (i == endPoint) {
//         tem += "        ";
//         endPoint += (maxChar - (priceLimit + qtyLimit + 2));
//       }
//     }
//     return tem;
//   }
//
//   String makeQtyNamePrice(String qty, String name, String crySymbol, String price) {
//     String result = makeAlign(name);
//     result = qty + result.substring(qty.length + 1, qtyLimit + 1) + result.substring(qtyLimit + 1);
//     result = result.substring(0, maxChar - (crySymbol.length + price.length)) + crySymbol + price + result.substring(maxChar);
//     return result;
//   }
//
//   String separateByTwo(String s1, String mid, String s2) {
//     String planStr = "";
//     for (int i = 0; i < maxChar - (s1.length + s2.length); i++) {
//       planStr += mid;
//     }
//
//     return s1 + planStr + s2;
//   }
//
//   String foodItemRowAlignString(OrderDetail oi, String crySymbol) {
//     // final bool hasPortion = oi.foodId.isNotEmpty ? foodPortionIdentify[oi.foodId.first] as bool : false;
//     String nameWithPortionStr = oi.itemName.toUpperCase().replaceAll('\n', ',') ;
//     nameWithPortionStr = makeQtyNamePrice(oi.quantity < 0 ? "#" : oi.quantity.toString(), nameWithPortionStr, crySymbol, oi.totalTp.toStringAsFixed(2));
//     // String optionStr = "";
//     // for (int j = 0; j < oi.food[0].options.length; j++) {
//     //   String variantStr = "";
//     //   double portionPrice = 0.0;
//     //   for (int k = 0; k < oi.food[0].options[j].optionVariant.length; k++) {
//     //     final coma = k < oi.food[0].options[j].optionVariant.length - 1 ? ", " : "";
//     //     // variantStr += ("(" + oi.food[0].options[j].optionVariant[k].variantName + "- " + crySymbol + oi.food[0].options[j].optionVariant[k].variantPrice.toStringAsFixed(2) + ")$coma");
//     //     variantStr += (oi.food[0].options[j].optionVariant[k].variantName + coma);
//     //     portionPrice += oi.food[0].options[j].optionVariant[k].variantPrice;
//     //   }
//     //   optionStr += makeAlign(oi.food[0].options[j].optionName + ": $crySymbol${portionPrice.toStringAsFixed(2)}");
//     //   optionStr += makeAlign(variantStr);
//     // }
//
//     // String extraStr = "";
//     // for (int j = 0; j < oi.food[0].extras.length; j++) {
//     //   extraStr += makeAlign(oi.food[0].extras[j].extraQuantity.toString() + "x " + oi.food[0].extras[j].extraName + " " + crySymbol + oi.food[0].extras[j].extraPrice.toStringAsFixed(2));
//     // }
//
//     // final String noteStr =theOrderForPrint.orderSource=='kukd'?oi.food[0].comment.isNotEmpty ? '\n${oi.food[0].comment.toString()}' : "" :oi.food[0].comment.isNotEmpty ? makeAlign("Note: " + oi.food[0].comment.toString()) : "";
//
//     // final String bonusItem = oi.food[0].bonusItem.isNotEmpty ? makeAlign("[Bonus] " + oi.food[0].bonusItem[0].name.toUpperCase()) : "";
//
//     return nameWithPortionStr;
//   }
//   // String formatOrderDetails(List<OrderDetail> items,String symbol, {int lineLength = 45}) {
//   //   List<String> lines = [];
//   //   const int priceWidth =9; // Total width allocated for price section
//   //   String currencySymbol = "";
//   //
//   //   for (var item in items) {
//   //     // Format quantity to take exactly 3 characters
//   //     String quantityStr = item.quantity.toString().padRight(3);
//   //
//   //     // Format price with currency symbol and right alignment
//   //     String amount = item.totalTp.toStringAsFixed(2);
//   //     String priceStr = (currencySymbol + amount);
//   //     if (priceStr.length < priceWidth)
//   //     {
//   //       for(int i = 0; i <priceWidth;i++)
//   //       {
//   //         if(priceStr.length < priceWidth)
//   //         {
//   //           priceStr=" "+priceStr;
//   //         }
//   //         else
//   //         {
//   //           break;
//   //         }
//   //       }
//   //     }
//   //
//   //     // Calculate available space for item name
//   //     int nameMaxWidth = lineLength - 3 - 2 - priceWidth; // 3(qty) + 2(spaces) + 11(price)
//   //
//   //     // Split item name into wrapped lines
//   //     List<String> nameLines = _wrapText(item.portionSize.isNotEmpty?item.itemName+item.portionSize:item.itemName, nameMaxWidth);
//   //
//   //     // Build first line with quantity, name, and price
//   //     String firstLine = quantityStr + "  " + nameLines.first.padRight(nameMaxWidth) + priceStr;
//   //     lines.add(firstLine);
//   //
//   //     // Add remaining name lines with indentation
//   //     for (int i = 1; i < nameLines.length; i++) {
//   //       lines.add("     " + nameLines[i]); // 5 spaces indentation
//   //     }
//   //   }
//   //   return lines.join('\n');
//   // }
//   //
//   // List<String> _wrapText(String text, int maxWidth) {
//   //   List<String> lines = [];
//   //   if (text.isEmpty) return [""];
//   //
//   //   List<String> words = text.split(' ');
//   //   String currentLine = "";
//   //
//   //   for (String word in words) {
//   //     if ((currentLine + word).length > maxWidth) {
//   //       if (currentLine.isNotEmpty) {
//   //         lines.add(currentLine.trim());
//   //         currentLine = "";
//   //       }
//   //       // Handle long words that exceed maxWidth
//   //       while (word.length > maxWidth) {
//   //         lines.add(word.substring(0, maxWidth));
//   //         word = word.substring(maxWidth);
//   //       }
//   //     }
//   //     currentLine += (currentLine.isEmpty ? "" : " ") + word;
//   //   }
//   //
//   //   if (currentLine.isNotEmpty) {
//   //     lines.add(currentLine);
//   //   }
//   //
//   //   return lines;
//   // }
//   Future<void> printStart() async {
//     // List kukdData = [];
//     // if (theOrderForPrint.orderSource == 'kukd') {
//     //   kukdData = await Repositories().getKukdData(theOrderForPrint.v.toString());
//     // }
//     // //food portion has or not
//     // Boxes.foodHive().values.forEach((element) {
//     //   foodPortionIdentify[element.id] = element.portions!.length <= 1;
//     // });
//     //
//     // final Uint8List byte = Uint8List.fromList(List<int>.from(ResInfo.logo));
//     // final resName = ResInfo.restName;
//     // final String address = ResInfo.addrLn1 + '\n' + ResInfo.addrLn2 + '\n' + ResInfo.addrLn3;
//     // final String bootomMsg = ResInfo.txtLn1 + '\n' + ResInfo.txtLn2 + '\n' + ResInfo.txtLn3;
//     //
//     // String orderType = theOrderForPrint.orderType == "DineIn"
//     //     ? 'DineIn Items'
//     //     : theOrderForPrint.orderType == "Delivery"
//     //         ? theOrderForPrint.orderSource == "kukd"
//     //             ? 'Delivery-${theOrderForPrint.v}'
//     //             : 'Delivery Items'
//     //         : (theOrderForPrint.orderType == "Collection" && theOrderForPrint.orderStatus == '2')
//     //             ? theOrderForPrint.orderSource == "kukd"
//     //                 ? 'Collection-${theOrderForPrint.v}'
//     //                 : 'Collection Items'
//     //             : 'Waiting(Collection) Items';
//     //
//     // //to detect collection and waiting order from report (because ordertype change after release for waiting order)
//     // if (reportTitle != null && theOrderForPrint.orderType == 'Collection+Waiting' && (theOrderForPrint.orderStatus == "10" || theOrderForPrint.orderStatus == "20")) {
//     //   orderType = 'Waiting(Collection)';
//     // } else if (reportTitle != null && theOrderForPrint.orderType == 'Collection' && (theOrderForPrint.orderStatus == "10" || theOrderForPrint.orderStatus == "20")) {
//     //   orderType = 'Collection';
//     // }
//     //
//     // final String orderDateTime = theOrderForPrint.orderSource == "kukd"
//     //     ? 'Order Date: ${DateFormat('dd-MM-yyyy').format(theOrderForPrint.createdAt)} ${DateFormat.Hm().format(theOrderForPrint.createdAt)}'
//     //     : 'Order Date: ${DateFormat('dd-MM-yyyy').format(theOrderForPrint.orderDate)} ${DateFormat.Hm().format(theOrderForPrint.orderDate)}';
//     // // final String printDatetime = 'Print Date: ${DateFormat('dd-MM-yyyy').format(DateTime.now())} ${DateFormat.Hm().format(DateTime.now())}';
//     // final String? tableNo = theOrderForPrint.table.isNotEmpty ? wordCutOfProtect('Table No: ${theOrderForPrint.table.map((e) => e.name)}', 48) : null;
//     // final String? customerName = !(theOrderForPrint.customer.name == "N/A" || theOrderForPrint.customer.name == "") ? "Guest Name: ${theOrderForPrint.customer.name}" : null;
//     // final String? customerGuests = theOrderForPrint.numberOfGuests != 0 ? 'Guests: ${theOrderForPrint.numberOfGuests}' : null;
//     // final String? deliveryAndCollectionTime = theOrderForPrint.orderSource == 'kukd' ? '${theOrderForPrint.orderType} Time(${kukdData.first['collectionDeliveryTime']})' : null;
//     // final String? paidby = theOrderForPrint.orderSource == "kukd"
//     //     ? kukdData.first['chosenPaymentType'] == "1"
//     //         ? "PAID BY CASH"
//     //         : "PAID BY CARD"
//     //     : null;
//     // double subTotal = theOrderForPrint.subTotal.toDouble();
//     // double tips = theOrderForPrint.totalTips.toDouble();
//     // double totalAmount = theOrderForPrint.totalAmount.toDouble();
//     // double tax = theOrderForPrint.tax.toDouble();
//     // double discount = totalAmount - (subTotal + tips + tax);
//     //
//     // // for discard order report print
//     // String? discardReason = theOrderForPrint.discardReason.isEmpty ? null : wordCutOfProtect("Reason: ${theOrderForPrint.discardReason}", 48);
//     //
//     // //for invoice number
//     // String? invoivenumber = theOrderForPrint.sl == 0 ? null : wordCutOfProtect("Invoice No: ${theOrderForPrint.sl}", 48);
//     //
//     // String allOrderItemsStr = "";
//     // for (int i = 0; i < theOrderForPrint.orderItems.length; i++) {
//     //   allOrderItemsStr += foodItemRowAlignString(theOrderForPrint.orderItems[i], ResInfo.currSym) + "\n\n";
//     // }
//     //
//     // final String? bonusItem = theOrderForPrint.rewardItem.isNotEmpty ? "[Bonus] " + theOrderForPrint.rewardItem.first.name.toUpperCase() : null;
//     //
//     // String? customerDetails;
//     // if (theOrderForPrint.orderType == 'Delivery') {
//     //   final String floorAndAptNo = theOrderForPrint.customer.floorAptNo.isNotEmpty ? theOrderForPrint.customer.floorAptNo + "\n" : "";
//     //   final String buildingName = theOrderForPrint.customer.buildingName.isNotEmpty ? theOrderForPrint.customer.buildingName + "\n" : "";
//     //   customerDetails = "" +
//     //       theOrderForPrint.customer.name.toString() +
//     //       "\n" +
//     //       theOrderForPrint.customer.phone.toString() +
//     //       "\n\n" +
//     //       floorAndAptNo +
//     //       theOrderForPrint.customer.houseNo +
//     //       "\n" +
//     //       buildingName +
//     //       theOrderForPrint.customer.streenName +
//     //       "\n" +
//     //       theOrderForPrint.customer.townCity +
//     //       "\n" +
//     //       theOrderForPrint.customer.postCode;
//     //
//     //   if (theOrderForPrint.customer.notes.isNotEmpty) {
//     //     customerDetails += "\n" + wordCutOfProtect('Note: ${theOrderForPrint.customer.notes}', 48);
//     //   }
//     // } else if (theOrderForPrint.orderType == 'Collection' || theOrderForPrint.orderType == 'Waiting') {
//     //   customerDetails = "" + theOrderForPrint.customer.name.toString() + "\n" + theOrderForPrint.customer.phone.toString();
//     //
//     //   if (theOrderForPrint.customer.notes.isNotEmpty) {
//     //     customerDetails += "\n" + wordCutOfProtect('Note: ${theOrderForPrint.customer.notes}', 48);
//     //   }
//     // }
//
//     /*#########################################################################
//     ######################## Console PRINT DON'T Delete ######################
//     #########################################################################*/
//
//     // log(theOrderForPrint.toJson().toString());
//     // return;
//
//     //   print('#####################G');
//     //   print('G');
//     //   print(byte.length);
//     //   print(resName);
//     //   print(address);
//     //   print(invoivenumber.toString());
//     //   print(orderType);
//     //   print(theOrderForPrint.v);
//     //   print(discardReason);
//     //   print('**************');
//     //   print(paidby);
//     //   print(deliveryAndCollectionTime);
//     //   print(theOrderForPrint.createdAt);
//     //   print(orderDateTime);
//     //   // print(printDatetime);
//     //   print(tableNo);
//
//     //   print(customerName);
//     //   print(customerGuests);
//
//     //   print(separateByTwo("", "-", ""));
//     //   print(separateByTwo("Qty Items", " ", "Price"));
//     //   print(separateByTwo("", "-", ""));
//     //   print(allOrderItemsStr);
//
//     //   print(separateByTwo("", "-", ""));
//     //   print(bonusItem);
//
//     //   print(separateByTwo("", "-", ""));
//     //   print(separateByTwo('Subtotal:', " ", subTotal));
//
//     //   print(discount < 0);
//     //   print(separateByTwo('Discount:', " ", discount));
//
//     //   print(tips > 0);
//     //   print(separateByTwo('Service/Tips:', " ", tips));
//     // //del and bag
//     //    theOrderForPrint.orderSource=='kukd'&&theOrderForPrint.tips.length>1?print(separateByTwo("Bag Charge", " ", '${ResInfo.currSym}${theOrderForPrint.tips.length>1? (theOrderForPrint.tips[1].tip):0.00}')):null;
//     //    theOrderForPrint.orderSource=='kukd'&&theOrderForPrint.tips.length>2?print(separateByTwo("delivery Charge", " ", '${ResInfo.currSym}${theOrderForPrint.tips.length>2? (theOrderForPrint.tips[2].tip):0.00}')):null;
//
//     //   print(tax > 0.0);
//     //   print(separateByTwo('Vat(${(ResInfo.vat * 100)}%):', " ", tax));
//
//     //   print(separateByTwo("", "-", ""));
//     //   print(separateByTwo('Total', " ", totalAmount));
//
//     //   print(customerDetails);
//
//     //   print(bootomMsg);
//     //   return;
//
//     /*########################################################################
//     ################################ SUNMI PRINT #############################
//     #########################################################################*/
//     String formattedString = formatOrderDetails(orderModel.orderData.orderDetails,HiveOperation().getData(HiveBoxKeys.currency));
//     AllSettings allSettings = await allSettingsFromJson(await HiveOperation().getSettingsData(HiveBoxKeys.allSettings));
//     User userInfo = await userFromJson(await HiveOperation().getData(HiveBoxKeys.userInfo));
//     //sunmi print start
//     // await SunmiPrinter.startTransactionPrint(true);
//     // await SunmiPrinter.initPrinter();
//     SetUpWifiPrinter wifiPrinter = SetUpWifiPrinter();
//     await wifiPrinter.connectWifiPrinter();
//
//     if (wifiPrinter.isConnected) {
//
//       // logo print
//       Uint8List byte=userInfo.restaurantInfo!.resImageBytes!;
//       if (byte.isNotEmpty) {
//         log("image printing");
//
//         img.Image? logoImage = img.decodeImage(byte);
//         img.Image bwImage = img.grayscale(logoImage!);
//         wifiPrinter.printer.imageRaster(bwImage, align: PosAlign.center, imageFn: PosImageFn.bitImageRaster);
//       }
//       wifiPrinter.printer.emptyLines(1);
//       //wifiPrinter.printer.imageRaster(bwImage, align: PosAlign.center, imageFn: PosImageFn.bitImageRaster);
//       wifiPrinter.printer.text(wrapText(userInfo.restaurantInfo!.companyName.toString(), 30), styles: const PosStyles(width: PosTextSize.size2, align: PosAlign.center, bold: true));
//
//
//       wifiPrinter.printer.emptyLines(1);
//       wifiPrinter.printer.text(wrapText("${userInfo.restaurantInfo!.companyAddress},${userInfo.restaurantInfo!.city}", 30), styles: const PosStyles(width: PosTextSize.size1, align: PosAlign.center, bold: true));
//       wifiPrinter.printer.emptyLines(1);
//       wifiPrinter.printer.text("Mobile No:${userInfo.restaurantInfo!.mobile}", styles: const PosStyles(width: PosTextSize.size1, align: PosAlign.center, bold: true));
//       wifiPrinter.printer.emptyLines(1);
//
//       wifiPrinter.printer.text("Kitchen Print", styles: const PosStyles(width: PosTextSize.size1, align: PosAlign.center, bold: true));
//       wifiPrinter.printer.emptyLines(1);
//       wifiPrinter.printer.text("MUSAK -6.3", styles: const PosStyles(width: PosTextSize.size1, align: PosAlign.right, bold: true));
//       wifiPrinter.printer.emptyLines(1);
//       wifiPrinter.printer.text("Vat Registration No-${userInfo.restaurantInfo!.vatRegNo}", styles: const PosStyles(width: PosTextSize.size1, align: PosAlign.left, bold: true));
//       wifiPrinter.printer.emptyLines(1);
//       wifiPrinter.printer.text("Order No: ${orderModel.orderData.orderNo.toString()}", styles: const PosStyles(width: PosTextSize.size1, align: PosAlign.left, bold: false));
//       // :const SizedBox.shrink();
//       wifiPrinter.printer.text("Date : ${orderModel.orderData.orderDatetime.toString()}", styles: const PosStyles(width: PosTextSize.size1, align: PosAlign.left, bold: false));
//       // theOrderForPrint.orderSource == "kukd" ? wifiPrinter.printer.text(deliveryAndCollectionTime!, styles: const PosStyles(width: PosTextSize.size1, align: PosAlign.left, bold: false)) : const SizedBox.shrink();
//       // theOrderForPrint.orderSource == "kukd" ? wifiPrinter.printer.text(paidby!, styles: const PosStyles(width: PosTextSize.size1, align: PosAlign.left, bold: true)) : const SizedBox.shrink();
//
//       // wifiPrinter.printer.text(printDatetime, style: SunmiStyle(fontSize: SunmiFontSize.MD, align: SunmiPrintAlign.LEFT, bold: false));
//
//       wifiPrinter.printer.emptyLines(1);
//
//       // tableNo != null ? wifiPrinter.printer.text(tableNo, styles: const PosStyles(width: PosTextSize.size1, align: PosAlign.left, bold: true)) : null;
//       // customerGuests != null ? wifiPrinter.printer.text(customerGuests, styles: const PosStyles(width: PosTextSize.size1, align: PosAlign.left, bold: true)) : null;
//       // customerName != null ? wifiPrinter.printer.text(customerName, styles: const PosStyles(width: PosTextSize.size1, align: PosAlign.left, bold: false)) : null;
//
//       //qty price and ---
//       if(orderModel.orderData.bookingInfo.tableList.isNotEmpty)
//       {
//         String tableInfo="table";
//         tableInfo = await getTableData(orderModel.orderData.bookingInfo.tableList);
//         wifiPrinter.printer.text("Tables: ${tableInfo}", styles: const PosStyles(width: PosTextSize.size1, align: PosAlign.left, bold: false));
//         wifiPrinter.printer.text("Covers: ${orderModel.orderData.bookingInfo.totalGuestCount.toString()}", styles: const PosStyles(width: PosTextSize.size1, align: PosAlign.left, bold: false));
//
//       }
//       wifiPrinter.printer.text("Server: ${userInfo.userInfo!.firstName.toString()+" "+userInfo.userInfo!.lastName.toString()}", styles: const PosStyles(width: PosTextSize.size1, align: PosAlign.left, bold: false));
//       wifiPrinter.printer.text("------------------------------------------------");
//       wifiPrinter.printer.text(separateByTwo("Qty Items", " ", "Price"), styles: const PosStyles(width: PosTextSize.size1, align: PosAlign.left, bold: true));
//       wifiPrinter.printer.text("------------------------------------------------");
//
//       // //order list
//       wifiPrinter.printer.textEncoded(Uint8List.fromList(utf8.encode(formattedString)),
//           styles: const PosStyles(width: PosTextSize.size1, align: PosAlign.left, bold: false));
//       wifiPrinter.printer.emptyLines(1);
//
//       wifiPrinter.printer.text("------------------------------------------------");
//
//       wifiPrinter.printer.textEncoded(Uint8List.fromList(utf8.encode(separateByTwo("Subtotal:", " ",  orderModel.orderData.totalTp.toStringAsFixed(2)))), styles: const PosStyles(width: PosTextSize.size1, align: PosAlign.left, bold: false));
//       wifiPrinter.printer.textEncoded(Uint8List.fromList(utf8.encode(separateByTwo("Discount:", " ",  orderModel.orderData.totalDiscount.toStringAsFixed(2)))), styles: const PosStyles(width: PosTextSize.size1, align: PosAlign.left, bold: false));
//       wifiPrinter.printer.textEncoded(Uint8List.fromList(utf8.encode(separateByTwo("Service Expense(${userInfo.restaurantInfo!.serviceExp.toString()}%):", " ",  orderModel.orderData.serviceExpense.toStringAsFixed(2)))), styles: const PosStyles(width: PosTextSize.size1, align: PosAlign.left, bold: false));
//       wifiPrinter.printer.textEncoded(Uint8List.fromList(utf8.encode(separateByTwo("Vat(${userInfo.restaurantInfo!.branchVat.toString()}%):", " ",  orderModel.orderData.totalTax.toStringAsFixed(2)))), styles: const PosStyles(width: PosTextSize.size1, align: PosAlign.left, bold: false));
//
//       //dis tips/service vat
//       //  wifiPrinter.printer.textEncoded(Uint8List.fromList(utf8.encode(separateByTwo("Discount:", " ", orderModel.orderData.totalDiscount.toStringAsFixed(2)))), styles: const PosStyles(width: PosTextSize.size1, align: PosAlign.left, bold: false));
//       // tips > 0.0 ? wifiPrinter.printer.textEncoded(Uint8List.fromList(utf8.encode(separateByTwo("Service/Tips:", " ", ResInfo.currSym + tips))), styles: const PosStyles(width: PosTextSize.size1, align: PosAlign.left, bold: false)) : null;
//       // tax > 0.0 ? wifiPrinter.printer.textEncoded(Uint8List.fromList(utf8.encode(separateByTwo("Vat(${(ResInfo.vat * 100)}%):", " ", ResInfo.currSym + tax))), styles: const PosStyles(width: PosTextSize.size1, align: PosAlign.left, bold: false)) : null;
//       //del and bag
//       // theOrderForPrint.orderSource == 'kukd' && theOrderForPrint.tips.length > 1
//       //     ? wifiPrinter.printer.textEncoded(Uint8List.fromList(utf8.encode(separateByTwo("Bag Charge", " ", '${ResInfo.currSym}${theOrderForPrint.tips.length > 1 ? (theOrderForPrint.tips[1].tip) : 0.00}'))),
//       //         styles: const PosStyles(width: PosTextSize.size1, align: PosAlign.left, bold: false))
//       //     : null;
//       // theOrderForPrint.orderSource == 'kukd' && theOrderForPrint.tips.length > 2
//       //     ? wifiPrinter.printer.textEncoded(Uint8List.fromList(utf8.encode(separateByTwo("Delivery Charge", " ", '${ResInfo.currSym}${theOrderForPrint.tips.length > 2 ? (theOrderForPrint.tips[2].tip) : 0.00}'))),
//       //         styles: const PosStyles(width: PosTextSize.size1, align: PosAlign.left, bold: false))
//       //     : null;
//
//       // //total
//       wifiPrinter.printer.text("------------------------------------------------");
//       wifiPrinter.printer.textEncoded(Uint8List.fromList(utf8.encode(separateByTwo("Total:", " ", orderModel.orderData.grandTotal.toStringAsFixed(2)))), styles: const PosStyles(width: PosTextSize.size1, align: PosAlign.left, bold: true));
//
//       wifiPrinter.printer.emptyLines(1);
//       orderModel.orderData.note.isNotEmpty? wifiPrinter.printer.textEncoded(Uint8List.fromList(utf8.encode(wrapText("Note: ${orderModel.orderData.note}", 48))), styles: const PosStyles(width: PosTextSize.size1, align: PosAlign.center, bold: true)):null;
//       orderModel.orderData.note.isNotEmpty?wifiPrinter.printer.emptyLines(1):null;
//       wifiPrinter.printer.textEncoded(Uint8List.fromList(utf8.encode("Thank you for coming")), styles: const PosStyles(width: PosTextSize.size1, align: PosAlign.center, bold: true));
//       wifiPrinter.printer.emptyLines(1);
//       wifiPrinter.printer.textEncoded(Uint8List.fromList(utf8.encode("Powered By - 3DineBase")), styles: const PosStyles(width: PosTextSize.size1, align: PosAlign.center, bold: true));
//       wifiPrinter.printer.emptyLines(1);
//       wifiPrinter.printer.emptyLines(1);
//       //customer info for delivery
//       // customerDetails != null ? wifiPrinter.printer.text("$orderType Details:", styles: const PosStyles(width: PosTextSize.size1, align: PosAlign.left, bold: true)) : null;
//       // customerDetails != null ? wifiPrinter.printer.text(customerDetails, styles: const PosStyles(width: PosTextSize.size1, align: PosAlign.left, bold: false)) : null;
//
//       //bootom msg
//       //wifiPrinter.printer.text(bootomMsg, styles: const PosStyles(width: PosTextSize.size1, align: PosAlign.center, bold: true));
//
//       //sunmi print stop
//       wifiPrinter.printer.cut();
//     }
//   }
//   Future<String> getTableData(List<TableList> tableInfo) async {
//     String tableNameList = "";
//
//     if (tableInfo.isNotEmpty) {
//       log(tableInfo.toString());
//       for (int i = 0; i < tableInfo.length; i++) {
//         tableNameList = "$tableNameList${tableInfo[i].tableName},";
//       }
//     }
//
//     return tableNameList;
//   }
// }
