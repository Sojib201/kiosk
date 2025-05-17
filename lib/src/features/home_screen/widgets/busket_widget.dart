import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/hive_constants.dart';
import '../../../core/shared/common/common_function.dart';
import '../../../core/shared/firebase/firebase_api.dart';
import '../../../core/shared/widget/app_widgets/custom_button2_widget.dart';
import '../../../core/utils/color_utils.dart';
import '../../../core/utils/style.dart';
import '../../../data/datasources/local/local_data_source.dart';
import '../../../data/models/settings_mode.dart';
import '../bloc/item_screen_bloc/item_screen_bloc.dart';
import '../kiosk_home_screen.dart';
import 'buskect.dart';
import 'calculation_part.dart';

class BusketWidget extends StatefulWidget {
  final AllSettings allSettings;
  const BusketWidget({super.key, required this.allSettings});

  @override
  State<BusketWidget> createState() => _BusketWidgetState();
}

class _BusketWidgetState extends State<BusketWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Dialog(
      child: Container(
        height: size.height * 0.70,
        width: size.width * 0.90,
        // decoration: BoxDecoration(
        //   color: ColorUtils.color1,
        // ),
        decoration: BoxDecoration(
          //border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(24.r),
          color: Colors.transparent.withOpacity(0.6)
        ),
        child: Padding(
          padding: EdgeInsets.all(32.h),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 12,
                  offset: Offset(0.w, 12.h),
                ),
              ],
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 6,
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorUtils.primaryColor,
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14.w,vertical: 10.h),
                          child: Text('Your Cart', style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.sp,
                            color: ColorUtils.black,
                          ),),
                        ),

                        Expanded(child: BuskectBox()),
                      ],
                    ),
                  ),),
                               // SizedBox(width: 10.w,),
                Expanded(
                  flex: 4,
                  child: CalculationPart(),
                ),

                Expanded(
                  flex: 2,
                  child: BlocBuilder<ItemScreenBloc, ItemScreenState>(
                    builder: (context, state) {
                      if (state is SubmitLoading || state is CancelOrderLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return Padding(
                          padding: EdgeInsets.all(12.h),
                          child: Container(
                            //padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  !widget.allSettings.branchSettings!.payFirstEnabled!
                                      ? Column(
                                    children: [
                                      Expanded(
                                        child: CustomButton2Widget(
                                          width: 300.w,
                                          label: 'Confirm Order',
                                          textStyle: TextStyle(
                                            color: ColorUtils.primaryColor,
                                            fontSize: 26.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          onTap: () async {
                                            // if (orderModel.orderData.orderDetails.isEmpty) {
                                            //   context.read<HomeBloc>().add(GetTableStatus("B001", false));
                                            //   Navigator.pop(context);
                                            //   return;
                                            // }
                                            Map<String, dynamic> body = {
                                              //"cid": orderModel.orderData.cid,
                                              "cid": userInfo.userInfo!.cid,
                                              //"branch_id": orderModel.orderData.branchId,
                                              "branch_id": userInfo.userInfo!.branchId,
                                              "order_type":'DineIn',
                                              "customer_id": orderModel.orderData.customerId,
                                              "customer_name": orderModel.orderData.customerName,
                                              "customer_phone": orderModel.orderData.customerPhone,
                                              "customer_email": orderModel.orderData.customerEmail,
                                              "customer_address": orderModel.orderData.customerAddress,
                                              "staff_id": userInfo.userInfo!.userId,
                                              //"booking_ref_no": orderModel.orderData.bookingRefNo,
                                              // "booking_ref_no": '',
                                              //"order_no": orderModel.orderData.orderNo,
                                              "order_no": '',
                                              // "promo_code": "",
                                              "order_details": orderModel.orderData.orderDetails,
                                              // "discount_type": orderModel.orderData.discountType,
                                              // "discount": orderModel.orderData.discountPercentage,
                                              "note": orderModel.orderData.note,
                                              "device_id": HiveOperation().getData(HiveBoxKeys.deviceId) == "" ? await CommonFunction().getId() : HiveOperation().getData(HiveBoxKeys.deviceId)
                                            };
                                            log(jsonEncode(body), name: "xxxxxxxxxxxxx");
                                            log("event calling");

                                            context.read<ItemScreenBloc>().add(OrderSubmitEvent(body: body, isCancel: false, allSettings: widget.allSettings));

                                            //h

                                            //hit submit API
                                          },
                                          backgroundColor: ColorUtils.greenColor,
                                          iconColor: ColorUtils.primaryColor,
                                        ),
                                      ),
                                    ],
                                  )
                                      : const SizedBox.shrink(),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Expanded(
                                    child: CustomButton2Widget(
                                      label: 'Cancel',
                                      textStyle: TextStyle(
                                        color: ColorUtils.primaryColor,
                                        fontSize: 28.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      onTap: () async {
                                        if (orderModel.orderData.orderNo != "") {
                                          Map<String, dynamic> body = {
                                            //"cid": orderModel.orderData.cid,
                                            "cid": userInfo.userInfo!.cid,
                                            //"branch_id": orderModel.orderData.branchId,
                                            "branch_id": userInfo.userInfo!.branchId,
                                            "order_type":'DineIn',
                                            "customer_id": orderModel.orderData.customerId,
                                            "customer_name": orderModel.orderData.customerName,
                                            "customer_phone": orderModel.orderData.customerPhone,
                                            "customer_email": orderModel.orderData.customerEmail,
                                            "customer_address": orderModel.orderData.customerAddress,
                                            "staff_id": userInfo.userInfo!.userId,
                                            //"booking_ref_no": orderModel.orderData.bookingRefNo,
                                            // "booking_ref_no": '',
                                            //"order_no": orderModel.orderData.orderNo,
                                            // "order_no": '',
                                            // "promo_code": "",
                                            "order_details": orderModel.orderData.orderDetails,
                                            // "discount_type": orderModel.orderData.discountType,
                                            // "discount": orderModel.orderData.discountPercentage,
                                            "note": orderModel.orderData.note,
                                            "device_id": HiveOperation().getData(HiveBoxKeys.deviceId) == "" ? await CommonFunction().getId() : HiveOperation().getData(HiveBoxKeys.deviceId)
                                          };
                                          log(jsonEncode(body), name: "xxxxxxxxxxxxx");
                                          log("event calling");

                                          context.read<ItemScreenBloc>().add(OrderSubmitEvent(body: body, isCancel: true, allSettings: widget.allSettings));
                                          log("order Number is");
                                          print(orderModel.orderData.orderNo);
                                        } else {
                                          // context.read<HomeBloc>().add(GetTableStatus("B001", false));
                                          Navigator.pop(context);
                                        }
                                      },
                                      height: 120.h,
                                      width: 300.w,
                                      iconColor: ColorUtils.primaryColor,
                                      icon: Icons.cancel,
                                      backgroundColor: ColorUtils.redColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
