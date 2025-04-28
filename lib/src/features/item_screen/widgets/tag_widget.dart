import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiosk/src/core/utils/color_utils.dart';
import 'package:kiosk/src/core/utils/style.dart';


class TagWidget extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;


  const TagWidget({super.key,
    required this.label, required this.isSelected, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 14.w),
        padding: EdgeInsets.symmetric(
          horizontal: 8.w,
        ),
        decoration: BoxDecoration(
            border: Border.all(width: 1.w, color:isSelected?ColorUtils.secondaryColor: ColorUtils.secondaryColor),
            color: isSelected ? ColorUtils.secondaryColor : ColorUtils.primaryColor,
          borderRadius: BorderRadius.circular(14.r),
            boxShadow: [
              BoxShadow(
                color: ColorUtils.black.withOpacity(0.2),
                blurRadius: 6.r,
                spreadRadius: 0,
                offset: Offset(-1, -1),
              ),
            ]
        ),
        child: Center(
          child: Text(
            label,
            // style: TextStyle(fontWeight: FontWeight.w500),
            style: isSelected ? MyStyle.heading1.copyWith(fontSize: 18.sp) : MyStyle.heading1.copyWith(color: ColorUtils.black,fontSize: 18.sp),
          ),
        ),
      ),
    );
  }
}
