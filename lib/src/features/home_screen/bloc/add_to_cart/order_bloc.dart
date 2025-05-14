import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/constants/hive_constants.dart';
import '../../../../core/shared/firebase/firebase_api.dart';
import '../../../../data/datasources/local/local_data_source.dart';
import '../../../../data/models/order_model.dart';
import '../../../../data/models/user_model.dart';
import '../../kiosk_home_screen.dart';
part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  double tips = 0;
  // DisplayManager displayManager = DisplayManager();

  OrderBloc() : super(OrderInitial()) {
    on<AddOrderItem>((event, emit) async {
      if (event.item.isNotEmpty) {
        emit(OrderInitial());
        OrderDetail newItem = OrderDetail.fromJson(event.item);

        List<OrderDetail> itemsToAdd = [];

        if (orderModel.orderData.orderDetails.isNotEmpty) {
          bool found = false;

          for (var element in orderModel.orderData.orderDetails) {
            if (element.itemId == newItem.itemId && element.itemName == newItem.itemName && element.portionSize == newItem.portionSize) {
              element.totalTp = element.totalTp + newItem.totalTp;
              element.quantity = element.quantity + newItem.quantity;
              element.discount = element.discount + newItem.discount;
              element.totalTax = element.totalTax + newItem.totalTax;
              element.grandTotal = element.grandTotal + newItem.grandTotal;
              element.note = newItem.note;

              found = true;
              break;
            }
          }

          if (!found) {
            itemsToAdd.add(newItem);
          }
        } else {
          itemsToAdd.add(newItem);
        }

        orderModel.orderData.orderDetails.addAll(itemsToAdd);

        _calculateTotals();
        log(jsonEncode(orderModel), name: "------------------order bloc--------------");
        log('Edddddddddddddddddddddddddddddddddddd ${orderModel.orderData.orderDetails.first.quantity}');
        emit(
          OrderItemShowState(
            List.from(orderModel.orderData.orderDetails),
            total: orderModel.orderData.grandTotal.toStringAsFixed(2),
            discount: orderModel.orderData.totalDiscount.toStringAsFixed(2),
            tips: tips.toStringAsFixed(2),
            serviceExpense: orderModel.orderData.serviceExpense.toStringAsFixed(2),
            vat: orderModel.orderData.totalTax.toStringAsFixed(2),
            subTotal: orderModel.orderData.totalTp.toStringAsFixed(2),
          ),
        );
      } else {
        emit(OrderInitial());
        _calculateTotals();
        log(jsonEncode(orderModel), name: "------------------order bloc--------------");
        emit(
          OrderItemShowState(
            List.from(orderModel.orderData.orderDetails),
            total: orderModel.orderData.grandTotal.toStringAsFixed(2),
            discount: orderModel.orderData.totalDiscount.toStringAsFixed(2),
            tips: tips.toStringAsFixed(2),
            serviceExpense: orderModel.orderData.serviceExpense.toStringAsFixed(2),
            vat: orderModel.orderData.totalTax.toStringAsFixed(2),
            subTotal: orderModel.orderData.totalTp.toStringAsFixed(2),
          ),
        );
      }

      // log(jsonEncode(orderModel), name: "current order data");
      // bool isDuel = await HiveOperation().getBooleanData(HiveBoxKeys.isSecondaryConnected) ?? false;
      // if (isDuel) {
      //   String dataFile = await HiveOperation().getData(HiveBoxKeys.fileDataKey);
      //   String dataType = await HiveOperation().getData(HiveBoxKeys.fileDataType);
      //   try {
      //     await displayManager.transferDataToPresentation({"file_name": dataFile, "view_type": "video_image_data", "order_model": jsonEncode(orderModel), "file_type": dataType});
      //   } catch (e) {
      //     log(e.toString());
      //   }
      // }
    });
    // on<RefreshEvent>((event, emit) async {
    //
    //   emit(OrderInitial());
    //   if (orderModel.orderData.discountType.toLowerCase() == DiscountType.percentage.name.toLowerCase()) {
    //
    //     orderModel.orderData.totalDiscount =  (orderModel.orderData.totalTp*(orderModel.orderData.discountPercentage/100));
    //
    //   } else {
    //     orderModel.orderData.totalDiscount = orderModel.orderData.discountPercentage;
    //
    //   }
    //
    //   orderModel.orderData.totalTp = orderModel.orderData.orderDetails.fold(0.0, (sum, item) => sum + item.totalTp);
    //   orderModel.orderData.serviceExpense =  (orderModel.orderData.totalTp - orderModel.orderData.totalDiscount) * (userInfo.restaurantInfo!.serviceExp! / 100);
    //
    //   // orderModel.orderData.totalTax = orderModel.orderData.orderDetails.fold(0.0, (sum, element) => sum + element.totalTax);
    //   // orderModel.orderData.totalTax = orderModel.orderData.orderDetails.fold(0.0, (sum, item) => sum + item.totalTax);
    //   log("total tax is ${orderModel.orderData.totalTax.toString()}");
    //   orderModel.orderData.totalTax =((orderModel.orderData.totalTp- orderModel.orderData.totalDiscount) +orderModel.orderData.serviceExpense)*userInfo.restaurantInfo!.branchVat! / 100;
    //   // orderModel.orderData.totalTax = ((orderModel.orderData.totalTax - (orderModel.orderData.totalDiscount * userInfo.restaurantInfo!.branchVat! / 100) +(orderModel.orderData.serviceExpense *userInfo.restaurantInfo!.branchVat! / 100) ));
    //
    //   orderModel.orderData.grandTotal = (orderModel.orderData.totalTp - orderModel.orderData.totalDiscount +orderModel.orderData.serviceExpense ) +orderModel.orderData.totalTax;
    //
    //   emit(
    //     OrderItemShowState(
    //       List.from(orderModel.orderData.orderDetails),
    //       total: orderModel.orderData.grandTotal.toStringAsFixed(2),
    //       discount: orderModel.orderData.totalDiscount.toStringAsFixed(2),
    //       tips: tips.toStringAsFixed(2),
    //       serviceExpense:  orderModel.orderData.serviceExpense.toStringAsFixed(2),
    //       vat: orderModel.orderData.totalTax.toStringAsFixed(2),
    //       subTotal: orderModel.orderData.totalTp.toStringAsFixed(2),
    //     ),
    //   );
    //
    //
    //
    // });

    // on<ItemEditEvent>((event, emit) {
    //   emit(OrderItemEditState(
    //     List.from(orderModel.orderData!.items),
    //     total: orderModel.orderData!.grandTotal,
    //     discount: orderModel.orderData!.discount,
    //     tips: tips.toStringAsFixed(2),
    //     vat: vat.toStringAsFixed(2),
    //     subTotal: orderModel.orderData!.subTotal,
    //   ));
    // });
  }

  void _calculateTotals() {
    ///prev cal
    // orderModel.orderData.totalDiscount = orderModel.orderData.orderDetails.fold(0.0, (sum, element) => sum + element.discount);
    // orderModel.orderData.totalTp = orderModel.orderData.orderDetails.fold(0.0, (sum, item) => sum + item.totalTp);
    // orderModel.orderData.totalTax = orderModel.orderData.orderDetails.fold(0.0, (sum, element) => sum + element.totalTax);
    // orderModel.orderData.grandTotal = orderModel.orderData.orderDetails.fold(0.0, (sum, item) => sum + item.grandTotal);
    // orderModel.orderData.totalTax = orderModel.orderData.orderDetails.fold(0.0, (sum, item) => sum + item.totalTax);
    log("total tax is ${orderModel.orderData.totalTax.toString()}");

    ///

    if (orderModel.orderData.discountType.toLowerCase() == DiscountType.percentage.name.toLowerCase()) {
      orderModel.orderData.totalDiscount = (orderModel.orderData.totalTp * (orderModel.orderData.discountPercentage / 100));
    } else {
      //orderModel.orderData.totalDiscount = orderModel.orderData.discountPercentage;
    }
    final userInfos = userFromJson( HiveOperation().getData(HiveBoxKeys.userInfo));
    orderModel.orderData.totalTp = orderModel.orderData.orderDetails.fold(0.0, (sum, item) => sum + item.totalTp);
    orderModel.orderData.serviceExpense = (orderModel.orderData.totalTp - orderModel.orderData.totalDiscount) * (userInfos.restaurantInfo!.serviceExp! / 100);
    // orderModel.orderData.totalTax = orderModel.orderData.orderDetails.fold(0.0, (sum, element) => sum + element.totalTax);
    // orderModel.orderData.totalTax = orderModel.orderData.orderDetails.fold(0.0, (sum, item) => sum + item.totalTax);
    log("total tax is ${orderModel.orderData.totalTax.toString()}");
    orderModel.orderData.totalTax = ((orderModel.orderData.totalTp - orderModel.orderData.totalDiscount) + orderModel.orderData.serviceExpense) * userInfos.restaurantInfo!.branchVat! / 100;
    // orderModel.orderData.totalTax = ((orderModel.orderData.totalTax - (orderModel.orderData.totalDiscount * userInfo.restaurantInfo!.branchVat! / 100) +(orderModel.orderData.serviceExpense *userInfo.restaurantInfo!.branchVat! / 100) ));

    orderModel.orderData.grandTotal = (orderModel.orderData.totalTp - orderModel.orderData.totalDiscount + orderModel.orderData.serviceExpense) + orderModel.orderData.totalTax;
  }
}
