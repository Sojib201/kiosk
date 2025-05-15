import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiosk/src/core/utils/color_utils.dart';

class OrderCartWidget extends StatelessWidget {

  final String orderCount;
  final String price;
  final VoidCallback onCancel;
  final VoidCallback onTap;

  const OrderCartWidget({
    super.key,
    required this.orderCount,
    required this.price,
    required this.onCancel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      padding: EdgeInsets.only(left: 10.w, right: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24.r),topLeft: Radius.circular(24.r),
        ),
        color: ColorUtils.color1,
        boxShadow: [
          BoxShadow(
            color: ColorUtils.black.withOpacity(0.2),
            blurRadius: 8.r,
            spreadRadius: 0,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade300),
            ),
            onPressed: onCancel,
            child: Text(
              "Cancel",
              style: TextStyle(
                fontSize: 22.sp,
                color: ColorUtils.redColor,
              ),
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Your Order',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorUtils.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 14.r,
                          backgroundColor: ColorUtils.secondaryColor,
                          child: Center(
                            child: Text(
                              orderCount.toString(),
                              style: TextStyle(fontSize: 15.sp,color: ColorUtils.primaryColor),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          "\$${price}",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(width: 50.w),
                // ElevatedButton(
                //   onPressed: onTap,
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Colors.deepOrange,
                //     padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(12.r),
                //     ),
                //   ),
                //   child: Text(
                //     "Order",
                //     style: TextStyle(fontSize: 22.sp, color: ColorUtils.primaryColor),
                //   ),
                // ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: Colors.deepOrange,

                  ),
                  child: Text(
                    "Order",
                    style: TextStyle(fontSize: 22.sp, color: ColorUtils.primaryColor,fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
