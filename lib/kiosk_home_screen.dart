import 'dart:ui';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiosk/utils/color_utils.dart';
import 'package:kiosk/widgets/home_banner_slider.dart';
import 'package:kiosk/widgets/item_card.dart';
import 'package:kiosk/widgets/order_cart_widget.dart';
import 'package:kiosk/widgets/side_bar_item.dart';
import 'package:kiosk/widgets/tag_widget.dart';

import 'main.dart';

class FoodKioskScreen extends StatefulWidget {
  const FoodKioskScreen({super.key});

  @override
  State<FoodKioskScreen> createState() => _FoodKioskScreenState();
}

class _FoodKioskScreenState extends State<FoodKioskScreen> {
  final List<String> imageAssets = [
    'assets/chowmin.png',
    'assets/pizza.png',
    'assets/burger1.jpg',
  ];

  int selectedIndex = -1;

  int getCrossAxisCount(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    if (deviceWidth > 600) {
      return 4;
    } else {
      return 2;
    }
  }


  @override
  Widget build(BuildContext context) {


    // final bool tablet = isTablet();
    // final int crossAxisCount = tablet ? 4 : 2;
    // final double containerWidth = tablet
    //     ? (MediaQuery.of(context).size.width * 0.14).w
    //     : (MediaQuery.of(context).size.width * 0.22).w;

    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding:  EdgeInsets.all(12.h),
            child: Row(

              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Expanded(
                //   flex: 6,
                //   child:RichText(
                //     text:  TextSpan(
                //       style: TextStyle(
                //         fontSize: 30.sp,
                //         fontWeight: FontWeight.bold,
                //         color: Colors.deepOrange,
                //       ),
                //       children: [
                //         TextSpan(text: "3"),
                //         TextSpan(
                //           text: "DineBase",
                //           style: TextStyle(color: Colors.brown),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    'assets/3DineBase.png',
                    fit: BoxFit.scaleDown,
                    height: 55.h,
                  ),
                ),

                Expanded(
                  flex: 3,
                  child:Padding(
                    padding:  EdgeInsets.only(top: 20.h),
                    child: SizedBox(
                      height: 45.h,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search",
                          suffixIcon: const Icon(
                            Icons.search,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 12.w),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.r),
                            borderSide:  BorderSide(color: Colors.black, width: 0.5.w),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.r),
                            borderSide:  BorderSide(color: Colors.black, width: 0.5.w),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.r),
                            borderSide:  BorderSide(color: Colors.black, width: 0.5.w),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h,),
          Expanded(
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                     // color: Colors.grey.shade700,
                      color: ColorUtils.secondaryColor,
                      borderRadius: BorderRadius.circular(14.r),),
                  //width: (size.width * 0.22).w,
                  //width: containerWidth,
                  width: (MediaQuery.of(context).size.width * 0.14).w,
                  padding:  EdgeInsets.symmetric(vertical: 10.h),
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                        child: SidebarItem(
                          onTap: (){},
                          title: 'Sushi Roll',
                          image:  "assets/burger1.png",
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HomeBannerSlider(
                        imageAssets: imageAssets,
                        onTap: (){
                        print('yyy');
                      },
                      ),
                      SizedBox(height: 20.h,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                        child: SizedBox(
                          height: 36.h,
                          width:double.infinity,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return TagWidget(
                                isSelected: index == selectedIndex,
                                onTap: (){
                                  setState(
                                        () {
                                      if (selectedIndex == index) {
                                        selectedIndex = -1;
                                      } else {
                                        selectedIndex = index;
                                      }

                                      if (selectedIndex != -1) {

                                      } else {

                                      }
                                    },
                                  );
                                },
                                label: 'Halal Food',
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                        child: Text(
                          "All Items",
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Expanded(
                        child: GridView.builder(
                          itemCount: 20,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                                //crossAxisCount: getCrossAxisCount(context),
                                //crossAxisCount: crossAxisCount,
                            mainAxisSpacing: 10.h,
                            crossAxisSpacing: 4.w,
                            childAspectRatio: 0.76,
                          ),
                          itemBuilder: (context, index) {
                            return ItemCard(itemName:"Sushi Roll", time: '20 min', ratings: '⭐ 4.5', price: "\$5.50", image:"assets/grilledsteak.png",);
                          },
                        ),
                      ),
                      OrderCartWidget(
                        title: "Your Order",
                        itemCount: 2,
                        price: 50.50,
                        onCancel: () {

                        },
                        onOrder: () {

                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
