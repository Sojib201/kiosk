import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:kiosk/src/core/constants/hive_constants.dart';
import 'package:kiosk/src/core/shared/common/common_function.dart';
import 'package:kiosk/src/core/shared/common/download_show_delete_in_local_image.dart';
import 'package:kiosk/src/data/datasources/local/local_data_source.dart';
import 'package:kiosk/src/data/models/guest_count_model.dart';
import 'package:kiosk/src/data/models/order_model.dart';
import 'package:kiosk/src/data/models/settings_mode.dart';
import 'package:kiosk/src/data/models/user_model.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/datasources/remote/remote_data_source.dart';

part 'item_screen_event.dart';
part 'item_screen_state.dart';

class ItemScreenBloc extends Bloc<ItemScreenEvent, ItemScreenState> {
  AllSettings? allSettings;
  ItemScreenBloc() : super(ItemScreenInitial()) {
    on<SearchItemEvent>((event, emit) async {
      // print('event list : ${event.items.toList()}');
      if (event.items.isNotEmpty) {
        User loginInfo = userFromJson(await HiveOperation().getData(HiveBoxKeys.userInfo));
        final List<ItemList> items = event.items.where((element) => element.categories!.contains(event.searchItem) || element.cuisines!.contains(event.searchItem)).toList();
        emit(ItemLoadedSearched(items, loginInfo.restaurantInfo!.currencySymbol!));
      } else {
        emit(ItemScreenInitial());
      }
      // TODO: implement event handler
    });


    on<SearchingEvent>((event, emit) async {
      emit(ItemSearchLoading());
      print('event list ${event.itemList.toList()}');

      if (event.itemList.isNotEmpty) {
        User loginInfo = userFromJson(await HiveOperation().getData(HiveBoxKeys.userInfo));

        final query = event.searchQuery.trim().toLowerCase();
        final filteredItems = event.itemList.where((element) {
          final nameMatch = element.foodName?.toLowerCase().contains(query) ?? false;


          return nameMatch;
        }).toList();


        emit(ItemSearchResult(filteredItems, loginInfo.restaurantInfo!.currencySymbol!));
      } else {
        emit(ItemScreenInitial());
      }
    });


    on<SearchingTag>((event, emit) async {
      emit(ItemSearchLoading());
      User loginInfo = userFromJson(await HiveOperation().getData(HiveBoxKeys.userInfo));
      final queries = event.selectedTags.map((e) => e.toLowerCase()).toList();
      final filteredItems = event.itemList.where((element) {
        final itemTags = element.tags?.map((e) => e.toLowerCase()) ?? [];
        return queries.any((query) => itemTags.contains(query));
      }).toList();

      emit(ItemSearchResult(filteredItems, loginInfo.restaurantInfo!.currencySymbol!));
    });


    AllSettings allSettings;
    on<GetAllResturantData>((event, emit) async {
      emit(ItemSearchLoading());
      User loginInfo = userFromJson(await HiveOperation().getData(HiveBoxKeys.userInfo));

      if (HiveBoxes.allSettings.isEmpty || event.isOnlineData) {
        //emit(HomeLoading());
        log("if show means from online data getting",name: "online");
        await GetDataFromApi().settingData();
        allSettings = allSettingsFromJson(await HiveOperation().getSettingsData(HiveBoxKeys.allSettings));

        for (var e in allSettings!.category!) {
          for (var element in e.categoryList!) {
            if (element.imageUrl != "") {
              await DownloadShowDeleteInLocalImage().downloadAndSaveImage(element.imageUrl!, element.categoryName!);
            }
          }
        }

        for (var e in allSettings!.cuisinesList!) {
          if (e.imageUrl != "") {
            await DownloadShowDeleteInLocalImage().downloadAndSaveImage(e.imageUrl!, e.cuisineName!);
          }
        }

        for (var element in allSettings!.itemList!) {
          if (element.imageUrl != "") {
            await DownloadShowDeleteInLocalImage().downloadAndSaveImage(element.imageUrl!, element.foodId!);
          }
          if (element.addonList!.isNotEmpty) {
            for (var addon in element.addonList!) {
              if (addon.imageUrl != "") {
                await DownloadShowDeleteInLocalImage().downloadAndSaveImage(addon.imageUrl!, addon.addonId!);
              }
            }
          }
        }
        log(allSettings.toString(), name: "From oNLINE");
      }
      else {
        allSettings = allSettingsFromJson(await HiveOperation().getSettingsData(HiveBoxKeys.allSettings));
        log(allSettings.toString(), name: "From Hive");
      }
      emit(ItemDataLoadedState( allSettings: allSettings,  userData: loginInfo, ));


    });



    // on<OrderSubmitEvent>((event, emit) async {
    //   allSettings = event.allSettings;
    //   log("bloc place");
    //
    //   if (await CommonFunction().hasInternetConnection()) {
    //     if (event.isCancel) {
    //       emit(CancelOrderLoading());
    //     } else {
    //       emit(SubmitLoading());
    //     }
    //
    //     log(jsonEncode(event.body), name: "order bodyssssssssssss");
    //
    //     Map<String, dynamic> responseData = await GetDataFromApi().submitOrder(event.body);
    //     log("resoponse is");
    //
    //     log(responseData.toString(), name: "order resposce");
    //
    //     if (responseData["status"] == "Success") {
    //       if (orderModel.orderData.orderNo.isNotEmpty && event.isCancel) {
    //         try {
    //           await FirebaseAPIs().deleteOrderToFireBase(orderModel);
    //         } catch (e) {
    //           log(e.toString());
    //         }
    //       } else if (orderModel.orderData.orderNo.isEmpty && !event.isCancel) {
    //         orderModel.orderData.orderNo = responseData["order_no"].toString();
    //         try {
    //           log("Adding new order to firebase");
    //           await FirebaseAPIs().addOrderToFireBase(orderModel);
    //         } catch (e) {
    //           log(e.toString());
    //         }
    //       }
    //       else if (orderModel.orderData.orderNo.isNotEmpty && !event.isCancel) {
    //         List newItems = [];
    //         List<String> count = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"];
    //         // Fetch all existing orders
    //         List<NotificationModel> notificationList = await FirebaseAPIs().getAllOrderListForCheckData();
    //
    //         log("🔍 Total fetched orders: ${jsonEncode(notificationList.first.orderData.orderDetails)}");
    //
    //         // Filter by same orderNo
    //         List<NotificationModel> sameOrders = notificationList.where((element) => element.orderData.orderNo == orderModel.orderData.orderNo).toList();
    //         log("🔍 Total same orders: ${sameOrders.length}${jsonEncode(sameOrders)}");
    //
    //
    //         List<String> existingItemIds = sameOrders.first.orderData.orderDetails.map<String>((e) => e.itemId.toString()).toList();
    //        ///old code
    //         orderModel.orderData.orderDetails.forEach((element) {
    //           bool isDifferent = true;
    //
    //           sameOrders.first.orderData.orderDetails.forEach((element1) {
    //             if (element.itemId == element1.itemId) {
    //               isDifferent = false;
    //               if (count.contains(element1.itemType)) {
    //                 element.itemType = (int.parse(element1.itemType.toString()) + 1).toString();
    //               } else {
    //                 if (element1.itemType == "Cooking") {
    //                   element.itemType = "Cooking";
    //                 }
    //                 if (element1.itemType == "Ready") {
    //                   element.itemType = "Ready";
    //                 }
    //               }
    //             }
    //             if (element.itemId == element1.itemId && element.itemName == element1.itemName && element.portionSize == element1.portionSize && element.quantity != element1.quantity) {
    //               isDifferent = true;
    //             }
    //           });
    //
    //           if (isDifferent) {
    //             log("${element.itemId} is not in sameOrders", name: "Different Item ID");
    //
    //             log("message ${element.itemType} ooooo not in count");
    //             element.itemType = "1";
    //
    //             newItems.add(element);
    //           }
    //         });
    //
    //
    //         log(jsonEncode(newItems), name: "new items");
    //
    //         log(jsonEncode(orderModel), name: "order model for update");
    //
    //         try {
    //           log("edit order to firebase");
    //         //  log(jsonEncode(orderModel));
    //           await FirebaseAPIs().editOrderToFireBase(orderModel);
    //         } catch (e) {
    //           log(e.toString());
    //         }
    //       }
    //
    //       // log(jsonEncode(orderModel), name: "Empty");
    //       await printInvoice(orderModel);
    //       await Future.delayed(Duration(seconds: 3));
    //
    //       emit(const OrderSubmittedSuccessState("Order Submit Success"));
    //       if (await HiveOperation().getBooleanData(HiveBoxKeys.isSecondaryConnected) ?? false) {
    //         String dataFile = await HiveOperation().getData(HiveBoxKeys.fileDataKey);
    //         String dataType = await HiveOperation().getData(HiveBoxKeys.fileDataType);
    //         try {
    //           await displayManager.transferDataToPresentation({"file_name": dataFile, "view_type": "video_image_only", "order_model": "", "file_type": dataType});
    //         } catch (e) {
    //           log(e.toString());
    //         }
    //       }
    //
    //       orderModel.clearAllData();
    //     } else {
    //       emit(ErrorState());
    //
    //       CommonFunction().showmessgae("${responseData["message"]}", false);
    //     }
    //   } else {
    //     CommonFunction().showmessgae("No Internet Connection Try With Internet", false);
    //   }
    //
    //   // TODO: implement event handler
    // });
  }



  // Future<void> printInvoice(OrderSingleton orderData) async {
  //   if ((allSettings!.branchSettings!.guestPrintEnabled ?? false)) {
  //     try {
  //       PrinterInvoiceGuest(orderModel: orderData).printStart();
  //       if (BluetoothCheck.isBluetoothDeviceConnected) PrinterInvoiceGuestBluetooth(orderModel: orderData).printStart();
  //       PrinterInvoiceGuestWifi(orderModel: orderData).printStart();
  //     } catch (e) {
  //       log(e.toString());
  //       if (BluetoothCheck.isBluetoothDeviceConnected) PrinterInvoiceGuestBluetooth(orderModel: orderData).printStart();
  //       PrinterInvoiceGuestWifi(orderModel: orderData).printStart();
  //       PrinterInvoiceGuest(orderModel: orderData).printStart();
  //     }
  //   }
  //   if ((allSettings!.branchSettings!.kitchenPrintEnabled ?? false)) {
  //     await Future.delayed(Duration(seconds: 2));
  //     try {
  //       PrinterInvoiceKitchenAndBar(orderModel: orderData, printAll: true, printBar: false, printKitchen: false, printNew: false, newItemOrderPrint: {}).printStart();
  //       if (BluetoothCheck.isBluetoothDeviceConnected) PrintInvoiceKitchenAndBarBluetooth(orderModel: orderData, printAll: true, printNew: false, printKitchen: false, printBar: false).printStart();
  //       PrinterInvoiceKitchenAndBarWifi(orderModel: orderData, printAll: true, printNew: false, printKitchen: false, printBar: false).printStart();
  //
  //     } catch (e) {
  //       log(e.toString());
  //       if (BluetoothCheck.isBluetoothDeviceConnected) PrintInvoiceKitchenAndBarBluetooth(orderModel: orderData, printAll: true, printNew: false, printKitchen: false, printBar: false).printStart();
  //       PrinterInvoiceKitchenAndBarWifi(orderModel: orderData, printAll: true, printNew: false, printKitchen: false, printBar: false).printStart();
  //       PrinterInvoiceKitchenAndBar(orderModel: orderData, printAll: true, printBar: false, printKitchen: false, printNew: false).printStart();
  //     }
  //   }
  // }
}
