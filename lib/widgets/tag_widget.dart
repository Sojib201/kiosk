import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiosk/utils/color_utils.dart';

class TagWidget extends StatelessWidget {
  final String label;


  const TagWidget({super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 14.w),
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
      ),
      decoration: BoxDecoration(
        color: ColorUtils.primaryColor,
        border: Border.all(width: 1.w),
        borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 6.r,
              spreadRadius: 0,
              offset: Offset(-1, -1),
            ),
          ]
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
