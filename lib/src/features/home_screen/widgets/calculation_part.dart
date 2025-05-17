import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/shared/common/bluetooth_check.dart';
import '../../../core/shared/firebase/firebase_api.dart';
import '../../../core/shared/printer/bluetooth_printer_kitchen.dart';
import '../../../core/shared/printer/guest_print_bluetooth.dart';
import '../../../core/shared/printer/printer_guest.dart';
import '../../../core/shared/printer/printer_guest_wifi.dart';
import '../../../core/shared/printer/printer_kitchen.dart';
import '../../../core/shared/printer/printer_kitchen_wifi.dart';
import '../../../core/shared/widget/app_widgets/custom_button2_widget.dart';
import '../../../core/utils/color_utils.dart';
import '../bloc/add_to_cart/order_bloc.dart';
import '../kiosk_home_screen.dart';

class CalculationPart extends StatefulWidget {
  const CalculationPart({super.key});

  @override
  State<CalculationPart> createState() => _CalculationPartState();
}

class _CalculationPartState extends State<CalculationPart> {
  final TextEditingController commentController = TextEditingController();
  @override
  void initState() {
    context.read<OrderBloc>().add(AddOrderItem(
        {
        }));
    // TODO: implement initState
    super.initState();
    commentController.text = orderModel.orderData.note;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if (state is OrderInitial) {
          return Padding(
            padding: EdgeInsets.all(12.h),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(
                  color: ColorUtils.secondaryColor.withOpacity(0.2),
                  width: 2.w,
                ),
                color: ColorUtils.secondaryColor,
                boxShadow: [
                  BoxShadow(
                    color: ColorUtils.black.withOpacity(0.4),
                    blurRadius: 0,
                    spreadRadius: 0,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: Column(
                  //mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(child: _buildRow('Discount', "৳${0}")),
                    const CDivider(),
                    Expanded(child: _buildRow('Tips', "৳${0}")),
                    const CDivider(),
                    Expanded(child: _buildRow('Vat', "৳${0}")),
                    const CDivider(),
                    Expanded(
                      child: _buildRow(
                        'Total',
                        "৳${0}",
                        fontSize: 28.sp,
                      ),
                    ),
                    const CDivider(),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButton2Widget(
                            width: 240.w,
                            height: 80.h,
                            label: 'Guest',
                            textStyle: TextStyle(
                              color: ColorUtils.black,
                              fontSize: 26.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            icon: Icons.print,
                            onTap: () async {
                              print("%%%%%%%%%%%%");

                              Fluttertoast.showToast(msg: "Please add some item first");

                              // ✅ Simulate order update (for testing)
                              // final updatedOrder = orderData.copyWith(
                              //   orderDetails: orderData.orderDetails?.copyWith(
                              //     discount: Discount(discountAmount: 5.0),
                              //   ),
                              // );
                            },
                            iconColor: ColorUtils.black,
                            backgroundColor: ColorUtils.primaryColor,
                          ),
                          CustomButton2Widget(
                            width: 240.w,
                            height: 80.h,
                            label: 'Kitchen',
                            textStyle: TextStyle(
                              color: ColorUtils.black,
                              fontSize: 26.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            icon: Icons.print,
                            onTap: () {
                              log("#########");
                            },
                            iconColor: ColorUtils.black,
                            backgroundColor: ColorUtils.primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        else if (state is OrderItemShowState) {
          return Padding(
            padding: EdgeInsets.all(12.h),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(
                  color: ColorUtils.secondaryColor.withOpacity(0.2),
                  width: 2.w,
                ),
                color: ColorUtils.primaryColor,
                boxShadow: [
                  BoxShadow(
                    color: ColorUtils.black.withOpacity(0.4),
                    blurRadius: 0,
                    spreadRadius: 0,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: SizedBox(
                  height: double.infinity,
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(child: _buildRow('SubTotal', "৳${state.subTotal}")),

                      //const CDivider(),
                      Expanded(child: _buildRow('Discount', "৳${state.discount}")),
                      //const CDivider(),
                      Expanded(child: _buildRow('Service Expense(${userInfo.restaurantInfo!.serviceExp.toString()}%)', "৳${state.serviceExpense}")),
                      //const CDivider(),
                      Expanded(child: _buildRow('Vat(${userInfo.restaurantInfo!.branchVat.toString()}%)', "৳${state.vat}")),
                      //const CDivider(),
                      Expanded(
                        child: _buildRow(
                          'Total',
                          "৳${state.total}",
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       CustomButton2Widget(
                      //         width: 240.w,
                      //         height: 80.h,
                      //         label: 'Guest',
                      //         textStyle: TextStyle(
                      //           color: ColorUtils.black,
                      //           fontSize: 26.sp,
                      //           fontWeight: FontWeight.w500,
                      //         ),
                      //         icon: Icons.print,
                      //         onTap: () async {
                      //           // Navigator.push(
                      //           //     context,
                      //           //     MaterialPageRoute(
                      //           //         builder: (context) =>  BillScreen(orderSingleton: orderModel,)
                      //           //     ));
                      //           try {
                      //             PrinterInvoiceGuest(orderModel: orderModel).printStart();
                      //             if (BluetoothCheck.isBluetoothDeviceConnected) PrinterInvoiceGuestBluetooth(orderModel: orderModel).printStart();
                      //             PrinterInvoiceGuestWifi(orderModel: orderModel).printStart();
                      //           } catch (e) {
                      //             log(e.toString());
                      //             if (BluetoothCheck.isBluetoothDeviceConnected) PrinterInvoiceGuestBluetooth(orderModel: orderModel).printStart();
                      //             PrinterInvoiceGuestWifi(orderModel: orderModel).printStart();
                      //             PrinterInvoiceGuest(orderModel: orderModel).printStart();
                      //           }
                      //
                      //           // ✅ Simulate order update (for testing)
                      //           // final updatedOrder = orderData.copyWith(
                      //           //   orderDetails: orderData.orderDetails?.copyWith(
                      //           //     discount: Discount(discountAmount: 5.0),
                      //           //   ),
                      //           // );
                      //         },
                      //         iconColor: ColorUtils.black,
                      //         backgroundColor: ColorUtils.primaryColor,
                      //       ),
                      //       IconButton(
                      //           onPressed: () {
                      //             showDialog(
                      //               context: context,
                      //               builder: (context) {
                      //                 return AlertDialog(
                      //                   title: const Text("Special instructions or Reason"),
                      //                   content: TextField(
                      //                     controller: commentController,
                      //                     maxLines: 3,
                      //                     decoration: const InputDecoration(
                      //                       hintText: "Enter your comment/reson here...",
                      //                       border: OutlineInputBorder(),
                      //                     ),
                      //                   ),
                      //                   actions: [
                      //                     TextButton(
                      //                       onPressed: () {
                      //                         Navigator.of(context).pop(); // Close dialog
                      //                       },
                      //                       child: const Text("Cancel"),
                      //                     ),
                      //                     ElevatedButton(
                      //                       onPressed: () {
                      //                         orderModel.orderData.note = commentController.text;
                      //                         setState(() {});
                      //                         Navigator.of(context).pop(); // Close dialog
                      //
                      //                         // You can process the comment here, e.g. send to server or save
                      //                       },
                      //                       child: const Text("Submit"),
                      //                     ),
                      //                   ],
                      //                 );
                      //               },
                      //             );
                      //           },
                      //           icon: Icon(
                      //             Icons.add_comment,
                      //             color: ColorUtils.primaryColor,
                      //             size: 55.sp,
                      //           )),
                      //       CustomButton2Widget(
                      //         width: 240.w,
                      //         height: 80.h,
                      //         label: 'Kitchen',
                      //         textStyle: TextStyle(
                      //           color: ColorUtils.black,
                      //           fontSize: 26.sp,
                      //           fontWeight: FontWeight.w500,
                      //         ),
                      //         icon: Icons.print,
                      //         onTap: () async {
                      //           try {
                      //             PrinterInvoiceKitchenAndBar(orderModel: orderModel, printAll: true, printBar: false, printKitchen: false, printNew: false, newItemOrderPrint: {}).printStart();
                      //             if (BluetoothCheck.isBluetoothDeviceConnected) PrintInvoiceKitchenAndBarBluetooth(orderModel: orderModel, printAll: true, printNew: false, printKitchen: false, printBar: false).printStart();
                      //             PrinterInvoiceKitchenAndBarWifi(orderModel: orderModel, printAll: true, printNew: false, printKitchen: false, printBar: false).printStart();
                      //             // if (BluetoothCheck.isBluetoothDeviceConnected) await PrintInvoiceKitchenAndBarBluetooth(orderModel: orderModel).printStart();
                      //             //  await PrinterInvoiceGuestWifi(orderModel: orderModel).printStart();
                      //           } catch (e) {
                      //             log(e.toString());
                      //             if (BluetoothCheck.isBluetoothDeviceConnected) PrintInvoiceKitchenAndBarBluetooth(orderModel: orderModel, printAll: true, printNew: false, printKitchen: false, printBar: false).printStart();
                      //             PrinterInvoiceKitchenAndBarWifi(orderModel: orderModel, printAll: true, printNew: false, printKitchen: false, printBar: false).printStart();
                      //             PrinterInvoiceKitchenAndBar(orderModel: orderModel, printAll: true, printBar: false, printKitchen: false, printNew: false).printStart();
                      //           }
                      //         },
                      //         iconColor: ColorUtils.black,
                      //         backgroundColor: ColorUtils.primaryColor,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Container(
            child: const Text("Empty"),
          );
        }
      },
    );
  }

  Widget _buildRow(String label, String value, {double fontSize = 20}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: fontSize.sp,
              color: ColorUtils.black,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: fontSize.sp,
              color: ColorUtils.black,
            ),
          ),
        ],
      ),
    );
  }
}

class CDivider extends StatelessWidget {
  const CDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Container(
        height: 1.h,
        color: ColorUtils.black,
      ),
    );
  }
}
