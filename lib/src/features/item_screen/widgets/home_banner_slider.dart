import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiosk/src/core/utils/color_utils.dart';

class HomeBannerSlider extends StatelessWidget {
  final List<String> imageAssets;
  final VoidCallback onTap;

  const HomeBannerSlider({
    super.key,
    required this.imageAssets, required this.onTap,

  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlayCurve: Curves.fastLinearToSlowEaseIn,
        height: 240.h,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.8,
        aspectRatio: 16 / 9,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(seconds: 4),
      ),
      items: imageAssets.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: onTap,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  color: ColorUtils.black,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(i),
                  ),
                ),
                alignment: Alignment.center,
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
