import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiosk/src/features/home_screen/widgets/add_item_popup/widget/typewidget.dart';
import '../../../../core/shared/common/common_function.dart';
import '../../../../core/utils/style.dart';
import '../../../../data/models/settings_mode.dart';
import '../../../../core/utils/color_utils.dart';
import '../cached_network_widget.dart';
import 'bloc/food_portion/food_portion_bloc.dart';
import 'bloc/food_portion/food_portion_event.dart';
import 'bloc/food_portion/food_portion_state.dart';
import 'bloc/qty_inc_dec/qty_inc_dec_bloc.dart';
import 'bloc/qty_inc_dec/qty_inc_dec_event.dart';
import 'bloc/qty_inc_dec/qty_inc_dec_state.dart';

class SelectedItemPopup extends StatefulWidget {
  final ItemList item;

  const SelectedItemPopup({
    super.key,
    required this.item,
  });

  @override
  State<SelectedItemPopup> createState() => _SelectedItemPopupState();
}

class _SelectedItemPopupState extends State<SelectedItemPopup> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    context
        .read<FoodPortionSizeBloc>()
        .add(GetInitEvent(itemList: widget.item));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    return Dialog(
      child: SingleChildScrollView(
        child: Container(
          height: size.height * 0.70,
          width: size.width * 0.80,
          child: Container(
            decoration: BoxDecoration(
              color: ColorUtils.color1,
              border: Border.all(
                width: 0.3.w,
                color: ColorUtils.secondaryColor,
              ),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 18.w,vertical: 12.h),
              child:
                  BlocConsumer<FoodPortionSizeBloc, FoodPortionSizeState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is InitState) {
                    return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // if (widget.item.imageUrl != null &&
                              //     widget.item.imageUrl!.isNotEmpty)
                              //   ClipRRect(
                              //     borderRadius:
                              //         BorderRadius.circular(10.r),
                              //     child: ImageShow(
                              //       imageUrl: CommonFunction()
                              //           .makeImageUrl(widget.item.foodId
                              //               .toString()),
                              //       height: 200.h,
                              //       width: double.infinity,
                              //       isLocal:
                              //           widget.item.imageUrl!.isNotEmpty,
                              //       fit: BoxFit.fill,
                              //     ),
                              //   ),
                              Stack(
                                children: [
                                  if (widget.item.imageUrl != null &&
                                      widget.item.imageUrl!.isNotEmpty)
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(10.r),
                                      child: ImageShow(
                                        imageUrl: CommonFunction()
                                            .makeImageUrl(widget
                                                .item.foodId
                                                .toString()),
                                        height: 200.h,
                                        width: double.infinity,
                                        isLocal: widget
                                            .item.imageUrl!.isNotEmpty,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  Positioned(
                                    bottom: 0.h,
                                    left: 0.w,
                                    right: 0.w,
                                    top: 0.h,
                                    child: Container(
                                      height: 500.h,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          colors: [
                                            ColorUtils.black
                                                .withOpacity(0.7),
                                            ColorUtils.black
                                                .withOpacity(0.0),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Positioned(
                                  //   // bottom: 80.h,
                                  //   // left: 32.w,
                                  //   // right: 5.w,
                                  //   //  top: 10.h,
                                  //   bottom: 0.h,
                                  //   left: 0.w,
                                  //   right: 0.w,
                                  //   child: Text(
                                  //     widget.item.foodName.toString(),
                                  //     maxLines: 2,
                                  //     style: TextStyle(
                                  //       color: Colors.white,
                                  //       fontSize: 20.sp,
                                  //       fontWeight: FontWeight.bold,
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Name:',
                                    style: MyStyle.heading10.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24.sp),
                                  ),
                                  Container(
                                    height: 50.h,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.w),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.8.w,
                                          color:
                                              ColorUtils.secondaryColor),
                                      borderRadius:
                                          BorderRadius.circular(14.r),
                                    ),
                                    child: Center(
                                      child: Center(
                                        child: Text(
                                          "Price: ${state.finalFoodPrice}",
                                          style: MyStyle.heading10
                                              .copyWith(
                                                  fontWeight:
                                                      FontWeight.w500,
                                                  fontSize: 22.sp),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                widget.item.foodName.toString(),
                                style: MyStyle.heading12.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 21.sp),
                                maxLines: 2,
                              ),
                              SizedBox(height: 20.h),
                              Text(
                                'Description',
                                style: MyStyle.heading10.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.sp),
                              ),
                              SizedBox(height: 4.h),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Text(
                                    widget.item.foodDescription.toString(),
                                    style: MyStyle.heading5
                                        .copyWith(fontSize: 20.sp),
                                    maxLines: 10,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              SizedBox(height: 30.h),

                              // widget.item.foodPortions!.isNotEmpty ? Text('Types', style: MyStyle.heading10.copyWith(fontSize: 22.sp),) : const SizedBox.shrink(),
                              Text(
                                'Types',
                                style: MyStyle.heading10
                                    .copyWith(fontSize: 24.sp),
                              ),
                              SizedBox(height: 6.h),
                              SizedBox(
                                height: 36.h,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  //itemCount: widget.item.foodPortions!.length,
                                  itemCount: 10,
                                  itemBuilder: (context, index) {
                                    //FoodPortion typemodel = widget.item.foodPortions![index];
                                    return TypeWidget(
                                      // type: typemodel.portionSize.toString(),
                                      type: 'Large',
                                      isSelected:
                                          index == state.selectedIndex,
                                      onTap: () {
                                        // print('hnsdfjk');
                                        // context.read<FoodPortionSizeBloc>().add(
                                        //   SelectPortionEvent(
                                        //     selectIndex: index,
                                        //     //item: widget.item,
                                        //     item: widget.item,
                                        //   ),
                                        // );
                                      },
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: 30.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Comment', style: MyStyle.heading10.copyWith(fontSize: 24.sp,fontWeight: FontWeight.bold),),
                                      SizedBox(height: 10.h),
                                      SizedBox(
                                        height: 100.h,
                                        width:200.w,
                                        child: TextField(
                                          controller: _commentController,
                                          textAlignVertical: TextAlignVertical.top,
                                          expands: true,
                                          maxLines: null,
                                          decoration: InputDecoration(
                                            contentPadding:  EdgeInsets.all(16.h),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(color: ColorUtils.secondaryColor),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: ColorUtils.secondaryColor),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 40.h,
                                        width: 120.w,
                                        child: Container(
                                          //padding: EdgeInsets.all(6.w),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: ColorUtils
                                                    .secondaryColor,
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(
                                                    10.r),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Quantity',
                                              style: MyStyle.heading10
                                                  .copyWith(
                                                      fontSize: 22.sp),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20.h),
                                      BlocConsumer<QtyIncDecBloc,
                                          QtyIncDecState>(
                                        listener: (context, state) {
                                          if (state
                                              is QtyIncDecStateResult) {
                                            log("bbbbbbbbbb");
                                            _controller.text =
                                                state.qty.toString();
                                          }
                                        },
                                        builder: (context, state) {
                                          int currentQty = (state
                                                  is QtyIncDecStateResult)
                                              ? state.qty
                                              : 1;

                                          _controller.text =
                                              currentQty.toString();

                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceEvenly,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  if (currentQty > 1) {
                                                    context
                                                        .read<
                                                            QtyIncDecBloc>()
                                                        .add(
                                                          QtyIncDecPerform(
                                                              qty:
                                                                  currentQty -
                                                                      1),
                                                        );
                                                  }
                                                },
                                                child: Container(
                                                  height: 40.h,
                                                  width: 40.w,
                                                  decoration:
                                                      BoxDecoration(
                                                    color: ColorUtils
                                                        .redColor,
                                                    shape:
                                                        BoxShape.circle,
                                                  ),
                                                  child: Center(
                                                    child: Icon(
                                                        Icons.remove,
                                                        color:
                                                            Colors.white,
                                                        size: 40.h),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              SizedBox(
                                                width: 60.w,
                                                height: 60.h,
                                                child: TextField(
                                                  textAlign:
                                                      TextAlign.center,
                                                  style: MyStyle.heading4
                                                      .copyWith(
                                                          fontSize:
                                                              22.sp),
                                                  controller: _controller,
                                                  keyboardType:
                                                      TextInputType
                                                          .number,
                                                  decoration:
                                                      InputDecoration(
                                                    border:
                                                        const OutlineInputBorder(),
                                                    contentPadding:
                                                        EdgeInsets
                                                            .symmetric(
                                                                vertical:
                                                                    10.h),
                                                  ),
                                                  onChanged: (value) {
                                                    final int? qty =
                                                        int.tryParse(
                                                            value);
                                                    if (qty != null) {
                                                      context
                                                          .read<
                                                              QtyIncDecBloc>()
                                                          .add(
                                                            QtyIncDecPerform(
                                                                qty: qty),
                                                          );
                                                    }
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  log("clicked");
                                                  context
                                                      .read<
                                                          QtyIncDecBloc>()
                                                      .add(
                                                        QtyIncDecPerform(
                                                            qty:
                                                                currentQty +
                                                                    1),
                                                      );
                                                },
                                                child: Container(
                                                  height: 40.h,
                                                  width: 40.w,
                                                  decoration:
                                                      BoxDecoration(
                                                    color: ColorUtils
                                                        .redColor,
                                                    shape:
                                                        BoxShape.circle,
                                                  ),
                                                  child: Center(
                                                    child: Icon(Icons.add,
                                                        color:
                                                            Colors.white,
                                                        size: 40.h),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                      SizedBox(height: 20.h),
                                      widget.item.addonList!.isNotEmpty
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceEvenly,
                                              children: [
                                                Text(
                                                  'Add-Extra',
                                                  style: MyStyle.heading9
                                                      .copyWith(
                                                          fontSize:
                                                              20.sp),
                                                ),
                                                SizedBox(width: 20.w),
                                              ],
                                            )
                                          : SizedBox.shrink(),

                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 70.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () =>
                                        Navigator.pop(context),
                                    child: Container(
                                      width: 120.w,
                                      height: 50.h,
                                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                                      decoration: BoxDecoration(
                                        color:
                                        ColorUtils.redColor,
                                        borderRadius:
                                        BorderRadius.circular(
                                            14.r),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Cancel',
                                          style: MyStyle.heading7
                                              .copyWith(
                                              fontSize:
                                              24.sp),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30.h,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      double itemTotal = (widget.item.foodPortions!.isNotEmpty ? (widget.item.foodPortions![state.selectedIndex].portionPrice! * int.parse(_controller.text))
                                          : (double.parse(widget.item.unitPrice.toString()) * int.parse(_controller.text)));
                                      double itemDiscount = widget.item.foodPortions!.isNotEmpty ? widget.item.foodPortions![state.selectedIndex].portionDiscount! : widget.item.discount! * int.parse(_controller.text);
                                      // context.read<OrderBloc>().add(AddOrderItem(
                                      //
                                      //   // {
                                      //   //     "item_id": widget.item.foodId,
                                      //   //     "item_name": widget.item.foodName,
                                      //   //     "item_type": widget.item.itemType,
                                      //   //     "portion_size": widget.item.foodPortion!.isNotEmpty ? widget.item.foodPortion![state.selectedIndex].portionSize : "",
                                      //   //     "unit_price": widget.item.foodPortion!.isNotEmpty ? double.parse(widget.item.foodPortion![state.selectedIndex].portionPrice!) : double.parse(widget.item.unitPrice!).toStringAsFixed(2),
                                      //   //     "quantity": int.parse(_controller.text),
                                      //   //     "bonus_qty": 0,
                                      //   //     "total_price": (itemTotal - itemDiscount).toStringAsFixed(2),
                                      //   //     "promotion_refarence": "",
                                      //   //     "promotion_type": "",
                                      //   //     "item_discount": itemDiscount.toStringAsFixed(2),
                                      //   //     "item_tax": 0.00,
                                      //   //     "item_total": itemTotal.toStringAsFixed(2)
                                      //   //   },
                                      //
                                      //     {
                                      //       "item_id": widget.item.foodId,
                                      //       "item_name": widget.item.foodName,
                                      //       "portion_size": widget.item.foodPortions!.isNotEmpty ? widget.item.foodPortions![state.selectedIndex].portionSize : "",
                                      //       "item_type": widget.item.itemType,
                                      //       "quantity": int.parse(_controller.text),
                                      //       "bonus_quantity": 0,
                                      //       "unit_price": widget.item.foodPortions!.isNotEmpty ? widget.item.foodPortions![state.selectedIndex].portionPrice! : widget.item.unitPrice!,
                                      //       "total_tp": itemTotal,
                                      //       "total_tax": widget.item.foodPortions!.isNotEmpty ? widget.item.foodPortions![state.selectedIndex].portionTax! : widget.item.tax,
                                      //       "discount": itemDiscount,
                                      //       "grand_total": (itemTotal - itemDiscount),
                                      //       "promotion_type": "",
                                      //       "promotion_refarence": "",
                                      //       "note": _commentController.text
                                      //     }));

                                      _controller.clear();

                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      width: 120.w,
                                      height: 50.h,
                                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                                      decoration: BoxDecoration(
                                        color:
                                        ColorUtils.greenColor,
                                        borderRadius:
                                        BorderRadius.circular(
                                            14.r),
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceEvenly,
                                          children: [
                                            Text(
                                              'Cart',
                                              style: MyStyle
                                                  .heading7
                                                  .copyWith(
                                                  fontSize:
                                                  24.sp),
                                            ),
                                            Icon(
                                              Icons
                                                  .shopping_cart_rounded,
                                              color: ColorUtils
                                                  .primaryColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          );

                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../../core/shared/common/common_function.dart';
// import '../../../../data/models/settings_mode.dart';
// import '../../bloc/item_screen_bloc/cart_bloc/cart_event.dart';
// import '../cached_network_widget.dart';
//
//
// class SelectedItemPopup extends StatefulWidget {
//   final ItemList item;
//
//   const SelectedItemPopup({super.key, required this.item});
//
//   @override
//   State<SelectedItemPopup> createState() => _SelectedItemPopupState();
// }
//
// class _SelectedItemPopupState extends State<SelectedItemPopup> {
//   int quantity = 1;
//
//   @override
//   Widget build(BuildContext context) {
//     final item = widget.item;
//
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
//       child: Container(
//         width: 350.w,
//         height: 500.h,
//         padding: EdgeInsets.all(16.w),
//         child: Column(
//           children: [
//             // Scrollable Content
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     if (item.imageUrl != null && item.imageUrl!.isNotEmpty)
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(10.r),
//                         child: ImageShow(
//                           imageUrl: CommonFunction().makeImageUrl(item.foodId.toString()),
//                           height: 150.h,
//                           width: double.infinity,
//                           isLocal: item.imageUrl!.isNotEmpty,
//                           fit: BoxFit.fill,
//                         ),
//                       ),
//                     SizedBox(height: 12.h),
//                     Text(
//                       item.foodName ?? 'Item Name',
//                       style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 8.h),
//                     Text(
//                       item.foodDescription ?? '',
//                       style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
//                     ),
//                     SizedBox(height: 16.h),
//                   ],
//                 ),
//               ),
//             ),
//             // Fixed Content
//             Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text('Price:', style: TextStyle(fontSize: 16.sp)),
//                     Text(
//                       "${item.foodPortions!.isNotEmpty ? item.foodPortions!.first.portionPrice : item.unitPrice} TK",
//                       style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 16.h),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text('Quantity:', style: TextStyle(fontSize: 16.sp)),
//                     Row(
//                       children: [
//                         IconButton(
//                           icon: Icon(Icons.remove_circle_outline),
//                           onPressed: () {
//                             if (quantity > 1) {
//                               setState(() => quantity--);
//                             }
//                           },
//                         ),
//                         Text(quantity.toString(), style: TextStyle(fontSize: 16.sp)),
//                         IconButton(
//                           icon: Icon(Icons.add_circle_outline),
//                           onPressed: () {
//                             setState(() => quantity++);
//                           },
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20.h),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       double? itemTotal = item.foodPortions!.isNotEmpty
//                           ? item.foodPortions!.first.portionPrice
//                           : item.unitPrice;
//
//                       context.read<CartBloc>().add(
//                         AddToCart(CartItem(
//                           title: item.foodName!,
//                           price: itemTotal!,
//                           quantity: quantity,
//                         )),
//                       );
//                       Navigator.pop(context);
//                     },
//                     child: Text("Add to Cart"),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
// }
