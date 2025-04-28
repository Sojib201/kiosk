import 'package:flutter/material.dart' show TextStyle, FontWeight;
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color_utils.dart';

class MyStyle {
  static TextStyle tableTextStyle = TextStyle(fontWeight: FontWeight.w400, fontSize: 30.sp, color: ColorUtils.black,height: 0,);
  static TextStyle tableCapTextStyle = TextStyle(fontWeight: FontWeight.w300, fontSize: 50.sp, color: ColorUtils.black);

  static TextStyle itemTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 24.sp, color: ColorUtils.secondaryColor);
  static TextStyle itemPriceTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp, color: ColorUtils.redColor);

  static TextStyle swichButtonTextStyle1 = TextStyle(fontWeight: FontWeight.bold, fontSize: 24.sp, color: ColorUtils.black);
  static TextStyle orderTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 32.sp, color: ColorUtils.black);

  static TextStyle swichButtonTextStyle2 = TextStyle(fontWeight: FontWeight.bold, fontSize: 24.sp, color: ColorUtils.primaryColor);

  static TextStyle titleHeading = TextStyle(
    fontSize: 40.sp,
    fontWeight: FontWeight.bold,
    color: ColorUtils.secondaryColor,
  );

  static TextStyle heading1 = TextStyle(
    fontSize: 30.sp,
    // fontWeight: FontWeight.bold,
    color: ColorUtils.primaryColor,
  );

  static TextStyle heading2 = TextStyle(
    fontSize: 40.sp,
    color: ColorUtils.secondaryColor,
  );

  static TextStyle heading3 = TextStyle(
    fontSize: 35.sp,
    fontWeight: FontWeight.w500,
    color: ColorUtils.secondaryColor,
  );

  static TextStyle heading4 = TextStyle(
    letterSpacing: 1,
    fontSize: 44.sp,
    // fontWeight: FontWeight.bold,
    color: ColorUtils.black,
  );

  static TextStyle heading5 = TextStyle(
    letterSpacing: 1,
    fontSize: 32.sp,
    fontWeight: FontWeight.w500,
    color: ColorUtils.black,
  );

  static TextStyle heading6 = TextStyle(
    fontSize: 30.sp,
    fontWeight: FontWeight.w500,
    color: ColorUtils.secondaryColor,
  );

  static TextStyle heading7 = TextStyle(
    letterSpacing: 1,
    fontSize: 40.sp,
    fontWeight: FontWeight.bold,
    color: ColorUtils.primaryColor,
  );

  static TextStyle heading8 = TextStyle(
    letterSpacing: 1,
    fontSize: 30.sp,
    fontWeight: FontWeight.bold,
    color: ColorUtils.primaryColor,
  );

  static TextStyle heading9 = TextStyle(
    letterSpacing: 1,
    fontSize: 36.sp,
    fontWeight: FontWeight.bold,
    color: ColorUtils.black,
  );
  static TextStyle heading10 = TextStyle(
    letterSpacing: 1,
    fontSize: 44.sp,
     fontWeight: FontWeight.bold,
    color: ColorUtils.black,
  );
  static TextStyle heading11 = TextStyle(
    fontSize: 35.sp,
    fontWeight: FontWeight.w500,
    color: ColorUtils.primaryColor,
  );
  static TextStyle heading12 = TextStyle(
    letterSpacing: 1,
    fontSize: 32.sp,
    fontWeight: FontWeight.w500,
    color: ColorUtils.black,
  );
  static TextStyle statusStyle = TextStyle(
    fontSize: 30.sp,
    fontWeight: FontWeight.w500,
    color: ColorUtils.greyColor,
  );

}
