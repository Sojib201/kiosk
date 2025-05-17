import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiosk/src/features/home_screen/kiosk_home_screen.dart';

import '../../../core/utils/color_utils.dart';
import '../../../data/models/order_model.dart';
import '../bloc/add_to_cart/order_bloc.dart';

class BuskectBox extends StatefulWidget {
  const BuskectBox({super.key});

  @override
  State<BuskectBox> createState() => _BuskectBoxState();
}

class _BuskectBoxState extends State<BuskectBox> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderBloc, OrderState>(
      listener: (context, state) {
        // if (state is OrderItemEditState) {
        //  ;
        // }
      },
      builder: (context, state) {
        if (state is OrderItemShowState) {
          return InkWell(
            onTap: () {
              // showDialog(
              //   context: context,
              //   builder: (context) => ItemEditDeletePopupWidget(
              //     itemList: state.items,
              //   ),
              // );
              // context.read<OrderBloc>().add(ItemEditEvent(orderedItems: state.items));
            },
            child: Padding(
              padding: EdgeInsets.all(12.h),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  // border: Border.all(
                  //   color: ColorUtils.secondaryColor.withOpacity(0.2),
                  //   width: 2.w,
                  // ),
                  color: ColorUtils.primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: ColorUtils.black.withOpacity(0.4),
                      blurRadius: 0,
                      spreadRadius: 0,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 8.w, top: 5.h),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 9,
                                  child: Text(
                                    'Item',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp, color: ColorUtils.black),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    maxLines: 2,
                                    'Qty',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp, color: ColorUtils.black),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 15.w),
                                    child: Text(
                                      'Price',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp, color: ColorUtils.black),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 10.h,),
                         // const Divider(),
                          Expanded(
                            child: ListView.builder(
                             // itemCount: state.items.length,
                              itemCount: orderModel.orderData.orderDetails.length,
                              itemBuilder: (context, index) {
                                //OrderDetail item = state.items[index];
                                OrderDetail item = orderModel.orderData.orderDetails[index];
                                return Padding(
                                  padding: EdgeInsets.only(left: 3.w,right: 3.w,bottom: 10.h ),
                                  child:
                                      Container(
                                        margin: EdgeInsets.only(top: 6.h),
                                        padding: EdgeInsets.all(20.w),
                                        decoration: BoxDecoration(
                                            color: ColorUtils.secondaryColor.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(12.r),
                                          // border: Border.all(
                                          //   color: ColorUtils.secondaryColor.withOpacity(0.2)
                                          // )
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 8,
                                              child: Text(
                                                ("${item.itemName}${item.portionSize.isNotEmpty ? "-${item.portionSize}" : ""}${item.note.isNotEmpty?"\nNote:${item.note}" : ""}"),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.sp,
                                                  color: ColorUtils.black,
                                                ),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 30.w),
                                                child: Container(
                                                  height: 40.h,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(12.r),
                                                    color: ColorUtils.secondaryColor,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      item.quantity.toString(),
                                                      style: TextStyle(
                                                        fontSize: 18.sp,
                                                        fontWeight: FontWeight.bold,
                                                        color: ColorUtils.primaryColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Padding(
                                                padding: const EdgeInsets.only(right: 8.0),
                                                child: Text(
                                                  item.totalTp.toStringAsFixed(2),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.sp,
                                                    color: ColorUtils.black,
                                                  ),
                                                  textAlign: TextAlign.right,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),


                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Container(
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
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 60.w, top: 5.h),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: Text(
                                'Item',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.sp, color: ColorUtils.black),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                maxLines: 2,
                                'Qty',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.sp, color: ColorUtils.black),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: EdgeInsets.only(left: 15.w),
                                child: Text(
                                  'Price',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.sp, color: ColorUtils.black),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const Divider(),
                      // Expanded(
                      //   child: SizedBox.shrink(),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
