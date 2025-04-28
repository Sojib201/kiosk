import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiosk/src/core/utils/color_utils.dart';

class SidebarItem extends StatelessWidget {
  final VoidCallback onTap;
  final bool isSelected;
  final String title;
  final String image;

  const SidebarItem(
      {super.key,
      required this.onTap,
      required this.title,
      required this.image, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: isSelected?  EdgeInsets.all(3.w): EdgeInsets.all(0.w),
        decoration: BoxDecoration(
          // color: ColorUtils.primaryColor,
          color: isSelected ? Colors.deepOrange : ColorUtils.primaryColor,
          borderRadius:  BorderRadius.circular(14.r),
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
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14.r),
                topRight: Radius.circular(14.r),
              ),
              child: Image.asset(
                image,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp,color: isSelected?ColorUtils.color1:ColorUtils.black),
            ),
            SizedBox(height: 4.h),
          ],
        ),
      ),
    );
  }
}
