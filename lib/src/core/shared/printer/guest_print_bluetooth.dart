// import 'dart:developer';
// import 'package:http/http.dart' as http;
// import '../../../data/datasources/local/local_data_source.dart';
// import '../../../data/models/order_model.dart';
// import '../../../data/models/settings_mode.dart';
// import '../../../data/models/user_model.dart';
// import '../../constants/hive_constants.dart';
//
// import 'dart:ui' as ui;
//
// import '../common/bluetooth_check.dart';
// String formatOrderDetails(List<OrderDetail> items, String symbol, {int lineLength = 48}) {
//   List<String> lines = [];
//   const int priceWidth = 10;
//   const int quantityWidth = 3;
//   const int gapWidth = 2;
//
//   for (var item in items) {
//     String quantityStr = item.quantity.toString().padRight(quantityWidth);
//
//     String priceStr = '${item.totalTp.toStringAsFixed(2)}'.padLeft(priceWidth);
//
//     String itemName = _composeItemName(item);
//
//     int nameMaxWidth = lineLength - quantityWidth - gapWidth - priceWidth;
//
//     List<String> nameLines = _wrapTextSmart(itemName, nameMaxWidth);
//
//     String firstLine = quantityStr + '  ' +
//         _padRightSmart(nameLines.first, nameMaxWidth) +
//         priceStr;
//     lines.add(firstLine);
//
//     for (int i = 1; i < nameLines.length; i++) {
//       lines.add(' ' * (quantityWidth + gapWidth) + nameLines[i]);
//     }
//     if (item.note.isNotEmpty) {
//       List<String> noteLines = _wrapTextSmart("Note: ${item.note}", lineLength - (quantityWidth + gapWidth));
//       for (var noteLine in noteLines) {
//         lines.add(' ' * (quantityWidth + gapWidth) + noteLine);
//       }
//     }
//
//     lines.add('');
//
//   }
//
//
//
//   return lines.join('\n');
// }
//
// String _composeItemName(OrderDetail item) {
//   String name = item.itemName;
//   if (item.portionSize.isNotEmpty) {
//     name += ' ${item.portionSize}';
//   }
//   // if (item.note.isNotEmpty) {
//   //   name += ', Note: ${item.note}';
//   // }
//   return name;
// }
//
// // Calculate the "real" length considering Chinese chars
// int realLength(String text) {
//   int length = 0;
//   for (var codeUnit in text.codeUnits) {
//     if (codeUnit > 255) {
//       length += 2; // Chinese or non-ASCII character
//     } else {
//       length += 1; // English/ASCII character
//     }
//   }
//   return length;
// }
//
// // PadRight for mixed language
// String _padRightSmart(String text, int targetLength) {
//   int currentLength = realLength(text);
//   if (currentLength >= targetLength) return text;
//   return text + ' ' * (targetLength - currentLength);
// }
//
//
// List<String> _wrapTextSmart(String text, int maxWidth) {
//   if (text.isEmpty) return [''];
//
//   List<String> lines = [];
//   String currentLine = '';
//   int currentLength = 0;
//
//   List<String> words = text.split(' ');
//
//   for (var word in words) {
//     int wordLength = realLength(word);
//     int spaceLength = currentLine.isEmpty ? 0 : 1; // Only add space if line is not empty
//
//     if (currentLength + spaceLength + wordLength <= maxWidth) {
//       // If word fits, add it
//       currentLine += (currentLine.isEmpty ? '' : ' ') + word;
//       currentLength += spaceLength + wordLength;
//     } else {
//       if (currentLine.isNotEmpty) {
//         lines.add(currentLine);
//       }
//       // If word itself is longer than maxWidth, we have to break the word
//       if (wordLength > maxWidth) {
//         String brokenWord = '';
//         int brokenLength = 0;
//         for (int i = 0; i < word.length; i++) {
//           String char = word[i];
//           int charLength = realLength(char);
//
//           if (brokenLength + charLength > maxWidth) {
//             lines.add(brokenWord);
//             brokenWord = '';
//             brokenLength = 0;
//           }
//           brokenWord += char;
//           brokenLength += charLength;
//         }
//         if (brokenWord.isNotEmpty) {
//           lines.add(brokenWord);
//         }
//         currentLine = '';
//         currentLength = 0;
//       } else {
//         currentLine = word;
//         currentLength = wordLength;
//       }
//     }
//   }
//
//   if (currentLine.isNotEmpty) {
//     lines.add(currentLine);
//   }
//
//   return lines;
// }
//
// String wrapText(String text, int maxWidth) {
//   if (text.isEmpty) return '';
//
//   List<String> words = text.split(' ');
//   StringBuffer buffer = StringBuffer();
//   String currentLine = '';
//
//   for (var word in words) {
//     if ((currentLine + (currentLine.isEmpty ? '' : ' ') + word).length <= maxWidth) {
//       currentLine += (currentLine.isEmpty ? '' : ' ') + word;
//     } else {
//       if (currentLine.isNotEmpty) {
//         buffer.writeln(currentLine);
//       }
//       currentLine = word;
//     }
//   }
//
//   if (currentLine.isNotEmpty) {
//     buffer.writeln(currentLine);
//   }
//
//   return buffer.toString().trim();
// }
// // Wrap text for mixed language
// // List<String> _wrapTextSmart(String text, int maxWidth) {
// //   if (text.isEmpty) return [''];
// //
// //   List<String> lines = [];
// //   String currentLine = '';
// //   int currentLength = 0;
// //
// //   for (int i = 0; i < text.length; i++) {
// //     String char = text[i];
// //     int charLength = realLength(char);
// //
// //     if (currentLength + charLength > maxWidth) {
// //       lines.add(currentLine);
// //       currentLine = '';
// //       currentLength = 0;
// //     }
// //
// //     currentLine += char;
// //     currentLength += charLength;
// //   }
// //
// //   if (currentLine.isNotEmpty) {
// //     lines.add(currentLine);
// //   }
// //
// //   return lines;
// // }
//
// // String formatOrderDetails(List<OrderDetail> items, String symbol, {int lineLength = 40}) {
// //   List<String> lines = [];
// //   const int priceWidth = 11; // Total width for price section
// //   const int quantityWidth = 3; // Width for quantity
// //   const int gapWidth = 2; // Space between quantity and name
// //
// //   for (var item in items) {
// //     // Format quantity (3 chars, left-aligned)
// //     String quantityStr = item.quantity.toString().padRight(quantityWidth);
// //
// //     // Format price (right-aligned, with symbol)
// //     String priceStr = '${item.totalTp.toStringAsFixed(2)}'.padLeft(priceWidth);
// //
// //     // Compose item name with portions and notes
// //     String itemName = _composeItemName(item);
// //
// //     // Calculate available space for name
// //     int nameMaxWidth = lineLength - quantityWidth - gapWidth - priceWidth;
// //
// //     // Split name into wrapped lines
// //     List<String> nameLines = _wrapText(itemName, nameMaxWidth);
// //
// //     // Build first line
// //     String firstLine = quantityStr + '  ' +
// //         nameLines.first.padRight(nameMaxWidth) +
// //         priceStr;
// //     lines.add(firstLine);
// //
// //     // Add remaining lines with proper indentation
// //     for (int i = 1; i < nameLines.length; i++) {
// //       lines.add(' ' * (quantityWidth + gapWidth) + nameLines[i]);
// //     }
// //   }
// //   return lines.join('\n');
// // }
// //
// // String _composeItemName(OrderDetail item) {
// //   String name = item.itemName;
// //   if (item.portionSize.isNotEmpty) {
// //     name += ' ${item.portionSize}';
// //   }
// //   if (item.note.isNotEmpty) {
// //     name += ',Note:${item.note}';
// //   }
// //   return name;
// // }
// //
// // List<String> _wrapText(String text, int maxWidth) {
// //   if (text.isEmpty) return [''];
// //
// //   List<String> words = text.split(' ');
// //   List<String> lines = [];
// //   String currentLine = '';
// //
// //   for (String word in words) {
// //     if ((currentLine + word).length <= maxWidth) {
// //       currentLine += (currentLine.isEmpty ? '' : ' ') + word;
// //     } else {
// //       if (currentLine.isNotEmpty) {
// //         lines.add(currentLine);
// //         currentLine = '';
// //       }
// //       // Handle very long words
// //       while (word.length > maxWidth) {
// //         lines.add(word.substring(0, maxWidth));
// //         word = word.substring(maxWidth);
// //       }
// //       currentLine = word;
// //     }
// //   }
// //
// //   if (currentLine.isNotEmpty) {
// //     lines.add(currentLine);
// //   }
// //
// //   return lines;
// // }
// //this is for check isFoodOnePortion
// Map<String, bool> foodPortionIdentify = {};
//
// String wordCutOfProtect(String str, int len) {
//   if (str.length < len) {
//     return str;
//   }
//   for (int i = 0; i < str.length; i += len) {
//     if (i > str.length) {
//       return str;
//     }
//     if (str[i] != ' ') {
//       int j = i;
//       String space = "";
//       while (str[j] != ' ' && j > 0) {
//         j--;
//         space += ' ';
//       }
//
//       if (space.isNotEmpty && space.length < len) {
//         str = (str.substring(0, i - space.length) + space + str.substring(i - space.length + 1, str.length));
//       }
//     }
//   }
//   return str;
// }
//
// //--------------------------------------format code start
//  const int maxChar = 47;
//  const int qtyLimit = 3;
//  const int priceLimit = 7;
//
// String addSpaceToAvoidWordBreking(String planStr) {
//   const int limit = maxChar - qtyLimit - priceLimit - 2;
//   for (int i = limit; i < planStr.length; i = i + limit) {
//     if (planStr[i] != ' ') {
//       String bSpace = "";
//       for (int j = i - 1; planStr[j] != " "; j--) {
//         bSpace += ' ';
//       }
//       planStr = planStr.substring(0, i - bSpace.length) + bSpace + planStr.substring(i - bSpace.length, planStr.length);
//     }
//   }
//   return planStr;
// }
//
// String makeAlign(String planStr1) {
//   String planStr = addSpaceToAvoidWordBreking(planStr1);
//   int startPoint = 0;
//   int endPoint = maxChar - (priceLimit + qtyLimit + 3);
//   for (int i = 0; planStr.length < maxChar - (qtyLimit + priceLimit + 2); i++) {
//     planStr += " ";
//   }
//   String tem = "";
//   for (int i = 0; i < planStr.length; i++) {
//     if (i == startPoint) {
//       tem += "\n    ";
//       if (planStr[i] == " ") {
//         planStr = planStr.substring(0, i) + planStr.substring(i + 1, planStr.length);
//       }
//       startPoint += (maxChar - (qtyLimit + priceLimit) - 2);
//     }
//     tem += planStr[i];
//     if (i == endPoint) {
//       tem += "        ";
//       endPoint += (maxChar - (priceLimit + qtyLimit + 2));
//     }
//   }
//   return tem;
// }
//
// String makeQtyNamePrice(String qty, String name, String crySymbol, String price) {
//   String result = makeAlign(name);
//   result = qty + result.substring(qty.length + 1, qtyLimit + 1) + result.substring(qtyLimit + 1);
//   result = result.substring(0, maxChar - (crySymbol.length + price.length)) + crySymbol + price + result.substring(maxChar);
//   return result;
// }
//
// String separateByTwo(String s1, String mid, String s2) {
//   String planStr = "";
//   for (int i = 0; i < maxChar - (s1.length + s2.length); i++) {
//     planStr += mid;
//   }
//
//   return s1 + planStr + s2;
// }
//
// String foodItemRowAlignString(OrderDetail oi, String crySymbol) {
//   // final bool hasPortion = oi.foodId.isNotEmpty ? foodPortionIdentify[oi.foodId.first] as bool : false;
//   String nameWithPortionStr = oi.itemName.toUpperCase().replaceAll('\n', ',') ;
//   nameWithPortionStr = makeQtyNamePrice(oi.quantity < 0 ? "#" : oi.quantity.toString(), nameWithPortionStr, crySymbol, oi.totalTp.toStringAsFixed(2));
//   // String optionStr = "";
//   // for (int j = 0; j < oi.food[0].options.length; j++) {
//   //   String variantStr = "";
//   //   double portionPrice = 0.0;
//   //   for (int k = 0; k < oi.food[0].options[j].optionVariant.length; k++) {
//   //     final coma = k < oi.food[0].options[j].optionVariant.length - 1 ? ", " : "";
//   //     // variantStr += ("(" + oi.food[0].options[j].optionVariant[k].variantName + "- " + crySymbol + oi.food[0].options[j].optionVariant[k].variantPrice.toStringAsFixed(2) + ")$coma");
//   //     variantStr += (oi.food[0].options[j].optionVariant[k].variantName + coma);
//   //     portionPrice += oi.food[0].options[j].optionVariant[k].variantPrice;
//   //   }
//   //   optionStr += makeAlign(oi.food[0].options[j].optionName + ": $crySymbol${portionPrice.toStringAsFixed(2)}");
//   //   optionStr += makeAlign(variantStr);
//   // }
//
//   // String extraStr = "";
//   // for (int j = 0; j < oi.food[0].extras.length; j++) {
//   //   extraStr += makeAlign(oi.food[0].extras[j].extraQuantity.toString() + "x " + oi.food[0].extras[j].extraName + " " + crySymbol + oi.food[0].extras[j].extraPrice.toStringAsFixed(2));
//   // }
//
//   // final String noteStr =theOrderForPrint.orderSource=='kukd'?oi.food[0].comment.isNotEmpty ? '\n${oi.food[0].comment.toString()}' : "" :oi.food[0].comment.isNotEmpty ? makeAlign("Note: " + oi.food[0].comment.toString()) : "";
//
//   // final String bonusItem = oi.food[0].bonusItem.isNotEmpty ? makeAlign("[Bonus] " + oi.food[0].bonusItem[0].name.toUpperCase()) : "";
//
//   return nameWithPortionStr;
// }
// // String formatOrderDetails(List<OrderDetail> items,String symbol, {int lineLength = 44}) {
// //   List<String> lines = [];
// //   const int priceWidth =11; // Total width allocated for price section
// //   String currencySymbol = "";
// //
// //   for (var item in items) {
// //     // Format quantity to take exactly 3 characters
// //     String quantityStr = item.quantity.toString().padRight(3);
// //
// //     // Format price with currency symbol and right alignment
// //     String amount = item.totalTp.toStringAsFixed(2);
// //     String priceStr = (currencySymbol + amount);
// //     if (priceStr.length < priceWidth)
// //     {
// //       for(int i = 0; i <priceWidth;i++)
// //       {
// //         if(priceStr.length < priceWidth)
// //         {
// //           priceStr=" "+priceStr;
// //         }
// //         else
// //         {
// //           break;
// //         }
// //       }
// //     }
// //
// //     // Calculate available space for item name
// //     int nameMaxWidth = lineLength - 3 - 2 - priceWidth; // 3(qty) + 2(spaces) + 11(price)
// //
// //     // Split item name into wrapped lines
// //     List<String> nameLines = _wrapText(item.portionSize.isNotEmpty?item.note.isNotEmpty?item.itemName+item.portionSize+" N:${item.note}":item.itemName+item.portionSize:item.note.isNotEmpty?item.itemName+" N:${item.note}":item.itemName, nameMaxWidth);
// //
// //     // Build first line with quantity, name, and price
// //     String firstLine = quantityStr + "  " + nameLines.first + priceStr;
// //     lines.add(firstLine);
// //
// //     // Add remaining name lines with indentation
// //     for (int i = 1; i < nameLines.length; i++) {
// //       lines.add("     " + nameLines[i]); // 5 spaces indentation
// //     }
// //   }
// //   return lines.join('\n');
// // }
// //
// // List<String> _wrapText(String text, int maxWidth) {
// //   List<String> lines = [];
// //   if (text.isEmpty) return [""];
// //
// //   List<String> words = text.split(' ');
// //   String currentLine = "";
// //
// //   for (String word in words) {
// //     if ((currentLine + word).length > maxWidth) {
// //       if (currentLine.isNotEmpty) {
// //         lines.add(currentLine.trim());
// //         currentLine = "";
// //       }
// //       // Handle long words that exceed maxWidth
// //       while (word.length > maxWidth) {
// //         lines.add(word.substring(0, maxWidth));
// //         word = word.substring(maxWidth);
// //       }
// //     }
// //     currentLine += (currentLine.isEmpty ? "" : " ") + word;
// //   }
// //
// //   if (currentLine.isNotEmpty) {
// //     lines.add(currentLine);
// //   }
// //
// //   return lines;
// // }
// class PrinterInvoiceGuestBluetooth {
//   final OrderSingleton orderModel;
//   final String? reportTitle;
//
//   PrinterInvoiceGuestBluetooth({required this.orderModel, this.reportTitle});
//
//   // //this is for check isFoodOnePortion
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
//   //  // final String noteStr =theOrderForPrint.orderSource=='kukd'?oi.food[0].comment.isNotEmpty ? '\n${oi.food[0].comment.toString()}' : "" :oi.food[0].comment.isNotEmpty ? makeAlign("Note: " + oi.food[0].comment.toString()) : "";
//   //
//   //  // final String bonusItem = oi.food[0].bonusItem.isNotEmpty ? makeAlign("[Bonus] " + oi.food[0].bonusItem[0].name.toUpperCase()) : "";
//   //
//   //   return nameWithPortionStr;
//   // }
//
//
// //*************************************Printing Modules****************************************
//
//   Future<void> printStart() async {
//     String formattedString = formatOrderDetails(orderModel.orderData.orderDetails,HiveOperation().getData(HiveBoxKeys.currency));
//
//
//
//     AllSettings allSettings = await allSettingsFromJson(await HiveOperation().getSettingsData(HiveBoxKeys.allSettings));
//     User userInfo = await userFromJson(await HiveOperation().getData(HiveBoxKeys.userInfo));
//      BluetoothCheck.bluetooth.printNewLine();
// //logo print
//      userInfo.restaurantInfo!.resImageBytes != null? BluetoothCheck.bluetooth.printImageBytes(userInfo.restaurantInfo!.resImageBytes!)
//          :
//     null;
//      BluetoothCheck.bluetooth.printNewLine();
//      BluetoothCheck.bluetooth.printCustom(wrapText(userInfo.restaurantInfo!.companyName.toString(),30), 2, 1);
//      BluetoothCheck.bluetooth.printNewLine();
//      BluetoothCheck.bluetooth.printCustom(wrapText("${userInfo.restaurantInfo!.companyAddress},${userInfo.restaurantInfo!.city}", 30), 1, 1);
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
//     await BluetoothCheck.bluetooth.printCustom("Guest Bill", 1, 1);
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
//       await BluetoothCheck.bluetooth.printCustom(wrapText("Tables: ${tableInfo}", 48), 1, 0,charset: "UTF-8");
//       await BluetoothCheck.bluetooth.printCustom("Covers: ${orderModel.orderData.bookingInfo.totalGuestCount.toString()}", 1, 0,charset: "UTF-8");
//     }
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
//     //   log(allOrderItemsStr);
//     await BluetoothCheck.bluetooth.printCustom(formattedString, 1, 0,charset: "UTF-8");
//
//     log(orderModel.toString());
//
//     await BluetoothCheck.bluetooth.printCustom("-----------------------------------------------", 1, 1);
//     await BluetoothCheck.bluetooth.printCustom(separateByTwo("Subtotal:", " ",  orderModel.orderData.totalTp.toStringAsFixed(2)), 1, 1,charset: "UTF-8");
//
//     //dis tips/service vat
//     await BluetoothCheck.bluetooth.printCustom(separateByTwo("Discount:", " ",  orderModel.orderData.totalDiscount.toStringAsFixed(2)), 1, 1,charset: "UTF-8");
//     await BluetoothCheck.bluetooth.printCustom(separateByTwo("Service Expense(${userInfo.restaurantInfo!.serviceExp.toString()}%):", " ",  orderModel.orderData.serviceExpense.toStringAsFixed(2)), 1, 1,charset: "UTF-8");
//     await BluetoothCheck.bluetooth.printCustom(separateByTwo("Vat(${userInfo.restaurantInfo!.branchVat.toString()}%):", " ",  orderModel.orderData.totalTax.toStringAsFixed(2)), 1, 1,charset: "UTF-8");
//
//     await BluetoothCheck.bluetooth.printCustom("-----------------------------------------------", 1, 1);
//     await BluetoothCheck.bluetooth.printCustom(separateByTwo("Total:", " ",  orderModel.orderData.grandTotal.toStringAsFixed(2)), 1, 1,charset: "UTF-8");
//
//     await BluetoothCheck.bluetooth.printNewLine();
//     orderModel.orderData.note.isNotEmpty?await BluetoothCheck.bluetooth.printCustom(wrapText("Note: ${orderModel.orderData.note}", 48), 1, 1):null;
//     orderModel.orderData.note.isNotEmpty? await BluetoothCheck.bluetooth.printNewLine():null;
//     await BluetoothCheck.bluetooth.printCustom("Thank you for coming", 1, 1);
//     await BluetoothCheck.bluetooth.printNewLine();
//
//
//     await BluetoothCheck.bluetooth.printCustom("Powered By - 3DineBase", 1, 1);
//     await BluetoothCheck.bluetooth.printNewLine();
//     await BluetoothCheck.bluetooth.printNewLine();
//
//
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
//
// }
//
//
