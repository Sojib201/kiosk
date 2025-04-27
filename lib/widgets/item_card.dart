import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemCard extends StatelessWidget {
  const ItemCard();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('xx');
      },

      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 6.w),
        child: Container(
          padding:  EdgeInsets.only(top: 6.h,left: 6.w,right: 6.w,bottom: 7.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
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
                    "assets/grilledsteak.png",
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
                    '20 min',
                    style: TextStyle(fontSize: 12.sp, color: Colors.black87),
                  ),
                  Text(
                    '⭐ 4.5',
                    style: TextStyle(fontSize: 12.sp, color: Colors.black87),
                  )
                ],
              ),
              SizedBox(height: 2.h),
              Text(
                "Sushi Roll",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),
              ),
              SizedBox(height: 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$5.50",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.add_circle_outline,
                      size: 20.h,
                      color: Colors.red,
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