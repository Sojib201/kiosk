import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiosk/src/core/utils/color_utils.dart';

class ItemCard extends StatelessWidget {
  final String itemName;
  final String time;
  final String ratings;
  final String price;
  final String image;

  const ItemCard(
      {super.key,
      required this.itemName,
      required this.time,
      required this.ratings,
      required this.price,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('xx');
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: Container(
          padding:
              EdgeInsets.only(top: 6.h, left: 6.w, right: 6.w, bottom: 7.h),
          decoration: BoxDecoration(
            color: ColorUtils.primaryColor,
            borderRadius: BorderRadius.circular(14.r),
            boxShadow: [
              BoxShadow(
                color: ColorUtils.black.withOpacity(0.2),
                blurRadius: 6.r,
                spreadRadius: 0,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                //flex: 3,
                // child: Stack(
                //   children: [
                //     Opacity(
                //       opacity: 0.3,
                //       child: SizedBox(
                //         child:  Image.asset(
                //           "assets/burger1.png",
                //           width: double.infinity,
                //           fit: BoxFit.fill,
                //         ),
                //       ),
                //     ),
                //     ClipRRect(
                //       borderRadius: BorderRadius.circular(16),
                //       child: BackdropFilter(
                //         filter: ImageFilter.blur(sigmaX: -60.w, sigmaY: 0.h),
                //         child: Image.asset(
                //           "assets/grilledsteak.png",
                //           width: double.infinity,
                //           fit: BoxFit.fill,
                //         ),
                //       ),
                //     ),
                //   ]
                // )1
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14.r),
                  child: Image.asset(
                    image,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    time,
                    style: TextStyle(fontSize: 12.sp, color: ColorUtils.black),
                  ),
                  Text(
                    ratings,
                    style: TextStyle(fontSize: 12.sp, color: ColorUtils.black),
                  )
                ],
              ),
              SizedBox(height: 2.h),
              Text(
                itemName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp,color: ColorUtils.black),
              ),
              SizedBox(height: 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorUtils.black,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.add_circle_outline,
                      size: 24.h,
                      color: ColorUtils.redColor,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
