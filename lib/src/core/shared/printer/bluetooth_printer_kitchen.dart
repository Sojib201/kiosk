// import 'dart:developer';
// import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
// import '../../../data/datasources/local/local_data_source.dart';
// import '../../../data/models/order_model.dart';
// import '../../../data/models/settings_mode.dart';
// import '../../../data/models/user_model.dart';
// import '../../constants/hive_constants.dart';
// import '../common/bluetooth_check.dart';
// import 'guest_print_bluetooth.dart';
// import 'myItem_format.dart';
//
// class PrintInvoiceKitchenAndBarBluetooth {
//   OrderSingleton orderModel;
//   bool printAll;
//   bool printNew;
//   bool printKitchen;
//   bool printBar;
//   Map<String, int>? newItemOrderPrint;
//   List<OrderDetail> finalList = [];
//
//   PrintInvoiceKitchenAndBarBluetooth({required this.orderModel, required this.printAll, required this.printNew, required this.printKitchen, required this.printBar, this.newItemOrderPrint}) {
//     SunmiPrinter.bindingPrinter();
//   }
//
//   //this is for check isFoodOnePortion
//   // Map<String, bool> foodPortionIdentify = {};
//   //
//   // String wordCutOfProtect(String str, int len) {
//   //   if (str.length < len) {
//   //     return str;
//   //   }
//   //   for (int i = 0; i < str.length; i += len) {
//   //     if (i > str.length) {
//   //       return str;
//   //     }
//   //     if (str[i] != ' ') {
//   //       int j = i;
//   //       String space = "";
//   //       while (str[j] != ' ' && j > 0) {
//   //         j--;
//   //         space += ' ';
//   //       }
//   //
//   //       if (space.isNotEmpty && space.length < len) {
//   //         str = (str.substring(0, i - space.length) + space + str.substring(i - space.length + 1, str.length));
//   //       }
//   //     }
//   //   }
//   //   return str;
//   // }
//   //
//   // //--------------------------------------format code start
//   // static const int maxChar = 47;
//   // static const int qtyLimit = 3;
//   // static const int priceLimit = 7;
//   //
//   // String addSpaceToAvoidWordBreking(String planStr) {
//   //   const int limit = maxChar - qtyLimit - priceLimit - 2;
//   //   for (int i = limit; i < planStr.length; i = i + limit) {
//   //     if (planStr[i] != ' ') {
//   //       String bSpace = "";
//   //       for (int j = i - 1; planStr[j] != " "; j--) {
//   //         bSpace += ' ';
//   //       }
//   //       planStr = planStr.substring(0, i - bSpace.length) + bSpace + planStr.substring(i - bSpace.length, planStr.length);
//   //     }
//   //   }
//   //   return planStr;
//   // }
//   //
//   // String makeAlign(String planStr1) {
//   //   String planStr = addSpaceToAvoidWordBreking(planStr1);
//   //   int startPoint = 0;
//   //   int endPoint = maxChar - (priceLimit + qtyLimit + 3);
//   //   for (int i = 0; planStr.length < maxChar - (qtyLimit + priceLimit + 2); i++) {
//   //     planStr += " ";
//   //   }
//   //   String tem = "";
//   //   for (int i = 0; i < planStr.length; i++) {
//   //     if (i == startPoint) {
//   //       tem += "\n    ";
//   //       if (planStr[i] == " ") {
//   //         planStr = planStr.substring(0, i) + planStr.substring(i + 1, planStr.length);
//   //       }
//   //       startPoint += (maxChar - (qtyLimit + priceLimit) - 2);
//   //     }
//   //     tem += planStr[i];
//   //     if (i == endPoint) {
//   //       tem += "        ";
//   //       endPoint += (maxChar - (priceLimit + qtyLimit + 2));
//   //     }
//   //   }
//   //   return tem;
//   // }
//   //
//   // String makeQtyNamePrice(String qty, String name, String crySymbol, String price) {
//   //   String result = makeAlign(name);
//   //   result = qty + result.substring(qty.length + 1, qtyLimit + 1) + result.substring(qtyLimit + 1);
//   //   result = result.substring(0, maxChar - (crySymbol.length + price.length)) + crySymbol + price + result.substring(maxChar);
//   //   return result;
//   // }
//   //
//   // String separateByTwo(String s1, String mid, String s2) {
//   //   String planStr = "";
//   //   for (int i = 0; i < maxChar - (s1.length + s2.length); i++) {
//   //     planStr += mid;
//   //   }
//   //
//   //   return s1 + planStr + s2;
//   // }
//   //
//   // String foodItemRowAlignString(OrderDetail oi, String crySymbol) {
//   //   // final bool hasPortion = oi.foodId.isNotEmpty ? foodPortionIdentify[oi.foodId.first] as bool : false;
//   //   String nameWithPortionStr = oi.itemName.toUpperCase().replaceAll('\n', ',') ;
//   //   nameWithPortionStr = makeQtyNamePrice(oi.quantity < 0 ? "#" : oi.quantity.toString(), nameWithPortionStr, crySymbol, oi.totalTp.toStringAsFixed(2));
//   //   // String optionStr = "";
//   //   // for (int j = 0; j < oi.food[0].options.length; j++) {
//   //   //   String variantStr = "";
//   //   //   double portionPrice = 0.0;
//   //   //   for (int k = 0; k < oi.food[0].options[j].optionVariant.length; k++) {
//   //   //     final coma = k < oi.food[0].options[j].optionVariant.length - 1 ? ", " : "";
//   //   //     // variantStr += ("(" + oi.food[0].options[j].optionVariant[k].variantName + "- " + crySymbol + oi.food[0].options[j].optionVariant[k].variantPrice.toStringAsFixed(2) + ")$coma");
//   //   //     variantStr += (oi.food[0].options[j].optionVariant[k].variantName + coma);
//   //   //     portionPrice += oi.food[0].options[j].optionVariant[k].variantPrice;
//   //   //   }
//   //   //   optionStr += makeAlign(oi.food[0].options[j].optionName + ": $crySymbol${portionPrice.toStringAsFixed(2)}");
//   //   //   optionStr += makeAlign(variantStr);
//   //   // }
//   //
//   //   // String extraStr = "";
//   //   // for (int j = 0; j < oi.food[0].extras.length; j++) {
//   //   //   extraStr += makeAlign(oi.food[0].extras[j].extraQuantity.toString() + "x " + oi.food[0].extras[j].extraName + " " + crySymbol + oi.food[0].extras[j].extraPrice.toStringAsFixed(2));
//   //   // }
//   //
//   //   // final String noteStr =theOrderForPrint.orderSource=='kukd'?oi.food[0].comment.isNotEmpty ? '\n${oi.food[0].comment.toString()}' : "" :oi.food[0].comment.isNotEmpty ? makeAlign("Note: " + oi.food[0].comment.toString()) : "";
//   //
//   //   // final String bonusItem = oi.food[0].bonusItem.isNotEmpty ? makeAlign("[Bonus] " + oi.food[0].bonusItem[0].name.toUpperCase()) : "";
//   //
//   //   return nameWithPortionStr;
//   // }
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
//
// //*************************************Printing Modules****************************************
//
//   Future<void> printStart() async {
//     // List kukdData = [];
//     // if (theOrderForPrint.orderSource == 'kukd') {
//     //   kukdData = await Repositories().getKukdData(theOrderForPrint.v.toString());
//     // }
//     // //food portion has or not
//     // Boxes.foodHive().values.forEach((element) {
//     //   foodPortionIdentify[element.id] = element.portions!.length <= 1;
//     // });
//
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
//     // for (int i = 0; i < orderModel.orderData.orderDetails.length; i++) {
//     //
//     //   allOrderItemsStr += MyItemFormat().formatItem(orderModel.orderData.orderDetails[i],);
//     //   // allOrderItemsStr += "${foodItemRowAlignString(orderModel.orderData.orderDetails[i],await HiveOperation().getData(HiveBoxKeys.currency))}\n\n";
//     // }
//     // log(allOrderItemsStr);
//     String formattedString = formatOrderDetails(orderModel.orderData.orderDetails,HiveOperation().getData(HiveBoxKeys.currency));
//
//     // final imageBytes = await createChineseTextImage(formattedString);
//
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
//     // print('#####################G');
//     // print('G');
//     // print(byte.length);
//     // print(resName);
//     // print(address);
//     // print(invoivenumber.toString());
//     // print(orderType);
//     // print(theOrderForPrint.v);
//     // print(discardReason);
//     // print('**************');
//     // print(paidby);
//     // print(deliveryAndCollectionTime);
//     // print(theOrderForPrint.createdAt);
//     // print(orderDateTime);
//     // // print(printDatetime);
//     // print(tableNo);
//
//     // print(customerName);
//     // print(customerGuests);
//
//     // print(separateByTwo("", "-", ""));
//     // print(separateByTwo("Qty Items", " ", "Price"));
//     // print(separateByTwo("", "-", ""));
//     // print(allOrderItemsStr);
//
//     // print(separateByTwo("", "-", ""));
//     // print(bonusItem);
//
//     // print(separateByTwo("", "-", ""));
//     // print(separateByTwo('Subtotal:', " ", subTotal));
//
//     // print(discount < 0);
//     // print(separateByTwo('Discount:', " ", discount));
//
//     // print(tips > 0);
//     // print(separateByTwo('Service/Tips:', " ", tips));
//     // //del and bag
//     // theOrderForPrint.orderSource == 'kukd' && theOrderForPrint.tips.length > 1 ? print(separateByTwo("Bag Charge", " ", '${ResInfo.currSym}${theOrderForPrint.tips.length > 1 ? (theOrderForPrint.tips[1].tip) : 0.00}')) : null;
//     // theOrderForPrint.orderSource == 'kukd' && theOrderForPrint.tips.length > 2 ? print(separateByTwo("delivery Charge", " ", '${ResInfo.currSym}${theOrderForPrint.tips.length > 2 ? (theOrderForPrint.tips[2].tip) : 0.00}')) : null;
//
//     // print(tax > 0.0);
//     // print(separateByTwo('Vat(${(ResInfo.vat * 100)}%):', " ", tax));
//
//     // print(separateByTwo("", "-", ""));
//     // print(separateByTwo('Total', " ", totalAmount));
//
//     // print(customerDetails);
//
//     // print(bootomMsg);
//     // return;
//
//     /*########################################################################
//     ################################ SUNMI PRINT #############################
//     #########################################################################*/
//
//     //sunmi print start
//     // await SunmiPrinter.startTransactionPrint(true);
//     // await SunmiPrinter.initPrinter();
//     // BlueThermalPrinter BluetoothCheck.bluetooth = BlueThermalPrinter.instance;
//
//     // //res logo and info,
//     // await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
//
//     // await BluetoothCheck.bluetooth.printCustom(resName.toString(), 1, 2);
//     // final response = await http.get(Uri.parse("https://imgs.search.brave.com/fSEBLSIeOe_BtOBSjSrwNzvJvuscuJcjmBKptwPsq2o/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvMTM5/NjY2MzQ2NC92ZWN0/b3IvbWVhdC1yZXN0/YXVyYW50LWZvb2Qt/bWVudS1sb2dvLmpw/Zz9zPTYxMng2MTIm/dz0wJms9MjAmYz1i/WTU0Rml4RnpHNGRB/OFhGeVJOcXRGMWkw/QkFxTTF3eFhnOHNW/OXFidjFJPQ"));
//     //
//     // if (response.statusCode == 200) {
//     //   log("response is succeffull off image");
//     //   Uint8List imageBytes = response.bodyBytes;
//     //   await BluetoothCheck.bluetooth.printImageBytes(imageBytes) ;
//     //
//     // }
//
//     AllSettings allSettings = await allSettingsFromJson(await HiveOperation().getSettingsData(HiveBoxKeys.allSettings));
//     User userInfo = await userFromJson(await HiveOperation().getData(HiveBoxKeys.userInfo));
//     BluetoothCheck.bluetooth.printNewLine();
// //logo print
//     userInfo.restaurantInfo!.resImageBytes != null? BluetoothCheck.bluetooth.printImageBytes(userInfo.restaurantInfo!.resImageBytes!)
//         :
//     null;
//     BluetoothCheck.bluetooth.printNewLine();
//     BluetoothCheck.bluetooth.printCustom(wrapText(userInfo.restaurantInfo!.companyName.toString(),30), 2, 1);
//     BluetoothCheck.bluetooth.printNewLine();
//     BluetoothCheck.bluetooth.printCustom(wrapText("${userInfo.restaurantInfo!.companyAddress},${userInfo.restaurantInfo!.city}", 30), 1, 1);
//
//     await BluetoothCheck.bluetooth.printNewLine();
//     await BluetoothCheck.bluetooth.printCustom("Mobile No-${userInfo.restaurantInfo!.mobile}", 1, 1);
//
//     await BluetoothCheck.bluetooth.printNewLine();
//
//
//     // discardReason == null ? null : await BluetoothCheck.bluetooth.printCustom(discardReason, 1, 1);
//     // discardReason == null ? null : await BluetoothCheck.bluetooth.printNewLine();
//
//     //title date
//     await BluetoothCheck.bluetooth.printCustom("Kitchen Print", 1, 1);
//     // theOrderForPrint.orderSource == "kukd" ? await BluetoothCheck.bluetooth.printCustom('KUKD', 1, 1) : const SizedBox.shrink();
//
//     //  AllService.autoDecimalActive=="0"?
//     await BluetoothCheck.bluetooth.printNewLine();
//     await BluetoothCheck.bluetooth.printCustom("MUSAK -6.3", 1, 2);
//
//     await BluetoothCheck.bluetooth.printNewLine();
//     await BluetoothCheck.bluetooth.printCustom("Vat Registration No-${userInfo.restaurantInfo!.vatRegNo}", 1, 0);
//
//     await BluetoothCheck.bluetooth.printNewLine();
//
//
//     await BluetoothCheck.bluetooth.printCustom("Order No: ${orderModel.orderData.orderNo.toString()}", 1, 0,charset: "UTF-8");
//     // await BluetoothCheck.bluetooth.printNewLine();
//     // :const SizedBox.shrink();
//     await BluetoothCheck.bluetooth.printCustom("Date : ${orderModel.orderData.orderDatetime.toString()}", 1, 0);
//     // orderModel.orderSource == "kukd" ? await BluetoothCheck.bluetooth.printCustom(deliveryAndCollectionTime!, 1, 1) : const SizedBox.shrink();
//     // orderModel.orderSource == "kukd" ? await BluetoothCheck.bluetooth.printCustom(paidby!, 1, 1) : const SizedBox.shrink();
//
//     //  await BluetoothCheck.bluetooth.printCustom(printDatetime, 10,1);
//
//     await BluetoothCheck.bluetooth.printNewLine();
// //it will  apply later
//
//     if (orderModel.orderData.bookingInfo.tableList.isNotEmpty) {
//       String tableInfo = "table";
//       tableInfo = await getTableData(orderModel.orderData.bookingInfo.tableList);
//       await BluetoothCheck.bluetooth.printCustom("Tables: ${tableInfo}" ?? "", 1, 0,charset: "UTF-8");
//       await BluetoothCheck.bluetooth.printCustom("Covers: ${orderModel.orderData.bookingInfo.totalGuestCount.toString()}", 1, 0,charset: "UTF-8");
//     }
//
//
//     // await BluetoothCheck.bluetooth.printCustom("Staff ID: ${orderModel.orderData.staffId.toString()}", 1, 0,charset: "UTF-8");
//     await BluetoothCheck.bluetooth.printCustom("Server: ${userInfo.userInfo!.firstName.toString()+" "+userInfo.userInfo!.lastName.toString()}", 1, 0,charset: "UTF-8");
//     //qty price and ---
//     await BluetoothCheck.bluetooth.printCustom("-----------------------------------------------", 1, 1);
//     await BluetoothCheck.bluetooth.printCustom(separateByTwo("Qty Items", " ", "Price"), 1, 1,charset: "UTF-8");
//     await BluetoothCheck.bluetooth.printCustom("-----------------------------------------------", 1, 1);
//     // await BluetoothCheck.bluetooth.printNewLine();
//
//     // //order list
//     // log(allOrderItemsStr);
//     await BluetoothCheck.bluetooth.printCustom(formattedString, 1, 0,charset: "UTF-8");
//     // await BluetoothCheck.bluetooth.printImageBytes(imageBytes);
//     // await BluetoothCheck.bluetooth.printNewLine(); // await BluetoothCheck.bluetooth.printLeftRight(string1, string2, size)
//
//     //
//     // await BluetoothCheck.bluetooth.printCustom(allOrderItemsStr.toString(), 1, 1);
//     log(orderModel.toString());
//     // await BluetoothCheck.bluetooth.printCustom("বাংলাদেশের টাকার ছবি", 10, 1);
//
//     // //promotion bonus
//
//     //  bonusItem == null ? null : await BluetoothCheck.bluetooth.printCustom(bonusItem, 12, 1);
//
//     //subtotal
//     // ;
//     await BluetoothCheck.bluetooth.printCustom("-----------------------------------------------", 1, 1);
//
//     await BluetoothCheck.bluetooth.printCustom(separateByTwo("Subtotal:", " ",  orderModel.orderData.totalTp.toStringAsFixed(2)), 1, 1,charset: "UTF-8");
//
//     //dis tips/service vat
//     await BluetoothCheck.bluetooth.printCustom(separateByTwo("Discount:", " ",  orderModel.orderData.totalDiscount.toStringAsFixed(2)), 1, 1,charset: "UTF-8");
//     await BluetoothCheck.bluetooth.printCustom(separateByTwo("Service Expense(${userInfo.restaurantInfo!.serviceExp.toString()}%):", " ",  orderModel.orderData.serviceExpense.toStringAsFixed(2)), 1, 1,charset: "UTF-8");
//     await BluetoothCheck.bluetooth.printCustom(separateByTwo("Vat(${userInfo.restaurantInfo!.branchVat.toString()}%):", " ",  orderModel.orderData.totalTax.toStringAsFixed(2)), 1, 1,charset: "UTF-8");
//     // tips > 0.0 ? await BluetoothCheck.bluetooth.printCustom(separateByTwo("Service/Tips:", " ", ResInfo.currSym + tips), 1, 1) : null;
//     // await BluetoothCheck.bluetooth.printCustom(separateByTwo("Vat(${(ResInfo.vat * 100)}%):", " ", ResInfo.currSym + tax), 1, 1) : null;
//     //del and bag
//     // orderModel.orderSource == 'kukd' && orderModel.tips.length > 1
//     //     ? await BluetoothCheck.bluetooth.printCustom(separateByTwo("Bag Charge", " ", '${ResInfo.currSym}${orderModel.tips.length > 1 ? (orderModel.tips[1].tip) : 0.00}'), 10, 1)
//     //     : null;
//     // orderModel.orderSource == 'kukd' && orderModel.tips.length > 2
//     //     ? await BluetoothCheck.bluetooth.printCustom(separateByTwo("Delivery Charge", " ", '${ResInfo.currSym}${orderModel.tips.length > 2 ? (orderModel.tips[2].tip) : 0.00}'), 1, 1)
//     //     : null;
//
//     // //total
//     await BluetoothCheck.bluetooth.printCustom("-----------------------------------------------", 1, 1);
//     await BluetoothCheck.bluetooth.printCustom(separateByTwo("Total:", " ",  orderModel.orderData.grandTotal.toStringAsFixed(2)), 1, 1,charset: "UTF-8");
//
//     await BluetoothCheck.bluetooth.printNewLine();
//     orderModel.orderData.note.isNotEmpty?await BluetoothCheck.bluetooth.printCustom(wrapText("Note: ${orderModel.orderData.note}", 48), 1, 1):null;
//
//     orderModel.orderData.note.isNotEmpty? await BluetoothCheck.bluetooth.printNewLine():null;
//     await BluetoothCheck.bluetooth.printCustom("Thank you for coming", 1, 1);
//     await BluetoothCheck.bluetooth.printNewLine();
//
//
//     await BluetoothCheck.bluetooth.printCustom("Powered By - 3DineBase", 1, 1);
//     await BluetoothCheck.bluetooth.printNewLine();
//     await BluetoothCheck.bluetooth.printNewLine();
//
//     //customer info for delivery
//     // customerDetails != null ? await BluetoothCheck.bluetooth.printCustom("$orderType Details:", 1, 1) : null;
//     // customerDetails != null ? await BluetoothCheck.bluetooth.printCustom(customerDetails, 1, 1) : null;
//     //
//     // // bootom msg
//     // await BluetoothCheck.bluetooth.printCustom(bootomMsg, 1, 1);
//     // await BluetoothCheck.bluetooth.printCustom("powered by :ePos", 1, 1);
//
//     //sunmi print stop
//     BluetoothCheck.bluetooth.paperCut();
//   }
//
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
//   // Future<Uint8List> createChineseTextImage(String text) async {
//   //   final recorder = ui.PictureRecorder();
//   //   final canvas = Canvas(recorder);
//   //   final paint = Paint();
//   //   final textStyle = ui.TextStyle(
//   //     color: Colors.white,
//   //     fontSize: 20,
//   //   );
//   //   final paragraphStyle = ui.ParagraphStyle(textAlign: TextAlign.left);
//   //   final paragraphBuilder = ui.ParagraphBuilder(paragraphStyle)
//   //     ..pushStyle(textStyle)
//   //     ..addText(text);
//   //   final paragraph = paragraphBuilder.build();
//   //   paragraph.layout(ui.ParagraphConstraints(width: 600));
//   //   canvas.drawParagraph(paragraph, Offset(0, 0));
//   //   final picture = recorder.endRecording();
//   //   final img = await picture.toImage(600, 500);
//   //   final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
//   //   return byteData!.buffer.asUint8List();
//   // }
// }
