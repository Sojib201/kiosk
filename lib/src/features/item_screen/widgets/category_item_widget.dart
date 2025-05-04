import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiosk/src/core/shared/common/common_function.dart';
import 'package:kiosk/src/core/utils/color_utils.dart';

import 'cached_network_widget.dart';

class CategoryItemWidget extends StatelessWidget {
  final VoidCallback onTap;
  final bool isSelected;
  final String categoryName;
  final String imageUrl;

  const CategoryItemWidget(
      {super.key,
      required this.onTap,
      required this.categoryName,
      required this.imageUrl, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:  EdgeInsets.symmetric(horizontal: 3.w),
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
              child:
              // Image.asset(
              //   image,
              //   width: double.infinity,
              //   fit: BoxFit.cover,
              // ),
              ImageShow(
                imageUrl: CommonFunction().makeImageUrl('https://e01.yeapps.com/3dine/api/v1/get-image/DBH_cat_20250310102052.png'),
                isLocal: imageUrl.isNotEmpty,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              categoryName,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp,color: isSelected?ColorUtils.color1:ColorUtils.black),
            ),
            SizedBox(height: 6.h),
          ],
        ),
      ),
    );
  }
}
