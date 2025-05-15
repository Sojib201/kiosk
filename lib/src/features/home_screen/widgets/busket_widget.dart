import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/color_utils.dart';
import '../../../core/utils/style.dart';
import 'buskect.dart';

class BusketWidget extends StatefulWidget {
  const BusketWidget({super.key});

  @override
  State<BusketWidget> createState() => _BusketWidgetState();
}

class _BusketWidgetState extends State<BusketWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Dialog(
      child: Container(
        height: size.height * 0.50,
        width: size.width * 0.90,
        decoration: BoxDecoration(
          color: ColorUtils.color1,
          // border: Border.all(
          //   width: 0.3.w,
          //   color: ColorUtils.secondaryColor,
          // ),
          //borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: ColorUtils.primaryColor,

                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w,vertical: 10.h),
                      child: Text('Your Cart', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                        color: ColorUtils.black,
                      ),),
                    ),

                    // Expanded(
                    //     child: ListView.builder(
                    //   itemCount: 10,
                    //   itemBuilder: (context, index) {
                    //   return Container(
                    //     margin: EdgeInsets.all(10.h),
                    //     padding: EdgeInsets.all(16.h),
                    //     decoration: BoxDecoration(
                    //       color: Colors.grey.withOpacity(0.2),
                    //       borderRadius: BorderRadius.circular(0.r),
                    //       //border: Border.all(color: ColorUtils.secondaryColor)
                    //     ),
                    //     child: Row(
                    //       children: [
                    //         Expanded(
                    //           flex: 4,
                    //           child: Text(
                    //             //("${item.itemName}${item.portionSize.isNotEmpty ? "-${item.portionSize}" : ""}${item.note.isNotEmpty?"\nNote:${item.note}" : ""}"),
                    //             'aiuhfiua',
                    //             style: TextStyle(
                    //               fontWeight: FontWeight.bold,
                    //               fontSize: 20.sp,
                    //               color: ColorUtils.black,
                    //             ),
                    //             maxLines: 3,
                    //             overflow: TextOverflow.ellipsis,
                    //           ),
                    //         ),
                    //         Expanded(
                    //           flex: 4,
                    //           child: Row(
                    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //             children: [
                    //               GestureDetector(
                    //                 onTap: () {
                    //
                    //                 },
                    //                 child: Container(
                    //                   height: 40.h,
                    //                   width: 40.w,
                    //                   decoration: BoxDecoration(
                    //                     color: ColorUtils.redColor,
                    //                     shape: BoxShape.circle,
                    //                   ),
                    //                   child: Center(
                    //                     child: Icon(
                    //                         Icons.remove,
                    //                         color: Colors.white,
                    //                         size: 35.h),
                    //                   ),
                    //                 ),
                    //               ),
                    //               SizedBox(
                    //                 width: 10.w,
                    //               ),
                    //               SizedBox(
                    //                 width: 50.w,
                    //                 height: 50.h,
                    //                 child: TextField(
                    //                   textAlign: TextAlign.center,
                    //                   style: MyStyle.heading4.copyWith(fontSize: 21.sp),
                    //                  // controller: _controller,
                    //                   keyboardType: TextInputType.number,
                    //                   decoration: InputDecoration(
                    //                     border: const OutlineInputBorder(),
                    //                     contentPadding: EdgeInsets.symmetric(vertical: 9.h),
                    //                   ),
                    //                   onChanged: (value) {
                    //                     // final int? qty = int.tryParse(value);
                    //                     // if (qty != null) {
                    //                     //   context.read<QtyIncDecBloc>().add(QtyIncDecPerform(qty: qty),);
                    //                     // }
                    //                   },
                    //                 ),
                    //               ),
                    //               SizedBox(
                    //                 width: 10.w,
                    //               ),
                    //               GestureDetector(
                    //                 onTap: () {
                    //                   // log("clicked");
                    //                   // context.read<QtyIncDecBloc>().add(QtyIncDecPerform(qty: currentQty + 1),);
                    //                 },
                    //                 child: Container(
                    //                   height: 40.h,
                    //                   width: 40.w,
                    //                   decoration:
                    //                   BoxDecoration(
                    //                     color: ColorUtils.redColor,
                    //                     shape: BoxShape.circle,
                    //                   ),
                    //                   child: Center(
                    //                     child: Icon(
                    //                         Icons.add,
                    //                         color: Colors.white,
                    //                         size: 35.h),
                    //                   ),
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //         Expanded(
                    //           flex: 4,
                    //           child: Padding(
                    //             padding: const EdgeInsets.only(right: 8.0),
                    //             child: Text(
                    //               // item.totalTp.toStringAsFixed(2),
                    //               '10',
                    //               style: TextStyle(
                    //                 fontWeight: FontWeight.bold,
                    //                 fontSize: 20.sp,
                    //                 color: ColorUtils.black,
                    //               ),
                    //               textAlign: TextAlign.right,
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   );
                    // },))
                    Expanded(child: BuskectBox()),
                  ],
                ),
              ),),
           // SizedBox(width: 10.w,),
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  color: ColorUtils.black,
                  boxShadow: [
                    BoxShadow(
                      color: ColorUtils.black.withOpacity(0.4),
                      blurRadius: 6.r,
                      spreadRadius: 0,
                      offset: Offset(-4.w, 4.h),
                    ),
                  ],
                ),
              ),),
          ],
        ),
      ),
    );
  }
}
