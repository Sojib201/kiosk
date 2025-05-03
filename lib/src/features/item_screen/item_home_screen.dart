import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kiosk/src/core/constants/const_string.dart';
import 'package:kiosk/src/core/constants/hive_constants.dart';
import 'package:kiosk/src/core/utils/color_utils.dart';
import 'package:kiosk/src/data/datasources/local/local_data_source.dart';
import 'package:kiosk/src/data/models/settings_mode.dart';
import 'package:kiosk/src/features/item_screen/bloc/item_screen_bloc.dart';
import 'package:kiosk/src/features/item_screen/widgets/home_banner_slider.dart';
import 'package:kiosk/src/features/item_screen/widgets/item_card.dart';
import 'package:kiosk/src/features/item_screen/widgets/order_cart_widget.dart';
import 'package:kiosk/src/features/item_screen/widgets/side_bar_item.dart';
import 'package:kiosk/src/features/item_screen/widgets/tag_widget.dart';
import 'package:kiosk/src/features/log_in_screen/login_screen.dart';

import 'app_drawer/AppDrawer.dart';
import 'app_drawer/bloc/appdware_bloc.dart';



class FoodKioskScreen extends StatefulWidget {
   const FoodKioskScreen({super.key});


  @override
  State<FoodKioskScreen> createState() => _FoodKioskScreenState();
}

class _FoodKioskScreenState extends State<FoodKioskScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<ItemList> itemList = [];
  AllSettings? allSettings;
  TextEditingController _searchingController = TextEditingController();

  final List<String> imageAssets = [
    'assets/chowmin.png',
    //'assets/pizza.png',
    'assets/burger1.jpg',
    'assets/banner1.jpg',
    'assets/banner2.png',
    'assets/banner3.png',
    'assets/banner4.png',
  ];

  int selectedIndex = -1;
  int isSelected = -1;

  // int getCrossAxisCount(BuildContext context) {
  //   final deviceWidth = MediaQuery.of(context).size.width;
  //
  //   if (deviceWidth > 600) {
  //     return 4;
  //   } else {
  //     return 2;
  //   }
  // }


  @override
  void initState() {
    super.initState();

    //context.read<CategorycuisinBloc>().add(CategorycuisinloadedEvent(allSettings: widget.allSettings, isCat: true, isFood: true));
    context.read<ItemScreenBloc>().add(
      SearchItemEvent(allSettings!.category!.first.categoryList!.first.categoryName!, allSettings!.itemList ?? []),
    );
    //context.read<OrderBloc>().add(AddOrderItem({}));

    context.read<ItemScreenBloc>().add(GetAllResturantData(false),);
  }

  @override
  Widget build(BuildContext context) {

    // final bool tablet = isTablet();
    // final int crossAxisCount = tablet ? 4 : 2;
    // final double containerWidth = tablet
    //     ? (MediaQuery.of(context).size.width * 0.14).w
    //     : (MediaQuery.of(context).size.width * 0.22).w;

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: AppDrawer(
        drawerKey: _scaffoldKey,
        title: "",
      ),

      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
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
                Image.asset(
                  ImagerUrl.logo,
                  fit: BoxFit.scaleDown,
                  height: 55.h,
                ),
                SizedBox(width: 20.w,),

                Expanded(
                  child:Padding(
                    padding:  EdgeInsets.only(top: 24.h),
                    child: SizedBox(
                      height: 45.h,
                      child: TextField(
                        controller: _searchingController,
                        onChanged: (query) {
                          context.read<ItemScreenBloc>().add(SearchingEvent(query, allSettings!.itemList!));

                          if (query.isEmpty) {
                            context.read<ItemScreenBloc>().add(
                              SearchItemEvent(
                                //allSettings?.category.first.categoryList!.first.categoryName!!,
                                allSettings!.category!.first.categoryList!.first.categoryName!,
                                allSettings!.itemList ?? [],
                              ),
                            );
                          }
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            padding: EdgeInsets.only(right: 10.w, bottom: 2.h, top: 3.h),
                            onPressed: () {
                              _searchingController.clear();
                              _searchingController.addListener(() {
                                context.read<ItemScreenBloc>().add(
                                  SearchItemEvent(allSettings!.category!.first.categoryList!.first.categoryName!, allSettings!.itemList ?? []),
                                );
                              });
                              context.read<ItemScreenBloc>().add(SearchingEvent("", allSettings!.itemList!));
                              context.read<ItemScreenBloc>().add(
                                SearchItemEvent(allSettings!.category!.first.categoryList!.first.categoryName!, allSettings!.itemList ?? []),
                              );
                            },
                            icon: Icon(
                              Icons.cancel_outlined,
                              color: ColorUtils.secondaryColor,
                            ),
                          ),

                          hintText: "Search",
                          // suffixIcon: const Icon(
                          //   Icons.search,
                          // ),
                          filled: true,
                          fillColor: ColorUtils.primaryColor,
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 12.w),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.r),
                            borderSide:  BorderSide(color: ColorUtils.black, width: 0.5.w),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.r),
                            borderSide:  BorderSide(color:ColorUtils.black, width: 0.5.w),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.r),
                            borderSide:  BorderSide(color: ColorUtils.black, width: 0.5.w),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 50.w,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 24.h),
                  child: GestureDetector(
                    onTap: (){
                      print('fff');
                      //Scaffold.of(context).openEndDrawer();
                      _scaffoldKey.currentState?.openEndDrawer();
                    },
                    child: Icon(Icons.menu,size: 45.h,),
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
                  width: (MediaQuery.of(context).size.width * 0.15).w,
                  padding:  EdgeInsets.symmetric(vertical: 10.h),
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                        child: SidebarItem(
                          isSelected: index == isSelected,
                          onTap: (){
                            setState(
                                  () {
                                if (isSelected == index) {
                                  isSelected = -1;
                                } else {
                                  isSelected = index;
                                }

                                if (isSelected != -1) {

                                } else {

                                }
                              },
                            );
                          },
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
                              fontSize: 22.sp, fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Expanded(
                        child: BlocBuilder<ItemScreenBloc,ItemScreenState>(
                          // listener: (context, state) {
                          //   if (state is OrderSubmittedSuccessState) {
                          //     log("333333333333333333333333333388888888888888888888234324324");
                          //     context.read<ItemScreenBloc>().add(GetAllResturantData( false));
                          //     Fluttertoast.showToast(msg: state.message);
                          //
                          //     // context.pop(context);
                          //     Navigator.pop(context);
                          //   }
                          //   if (state is ErrorState) {
                          //     context.read<ItemScreenBloc>().add(
                          //       SearchItemEvent(allSettings!.category!.first.categoryList!.first.categoryName!, allSettings!.itemList ?? []),
                          //     );
                          //   }
                          //
                          //   // TODO: implement listener
                          // },
                          builder: (context, state) {
                          if(state is ItemSearchLoading){
                            return Center(child: CircularProgressIndicator(),);
                          }
                          if(state is ItemSearchResult){
                            if (state.filteredItems.isEmpty) {
                              return const Center(child: Text('No Items Found'));
                            }
                            else{
                              itemList = state.filteredItems;
                              return GridView.builder(
                                itemCount: state.filteredItems.length,
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
                                  ItemList item = state.filteredItems[index];
                                  return ItemCard(
                                    onTap: () {

                                    },
                                      itemName: item.foodName!,
                                      time: '20 min',
                                      ratings: '⭐ 4.5',
                                      price:  item.foodPortions!.isNotEmpty ? item.foodPortions!.first.portionPrice!.toString() : item.unitPrice.toString(),
                                      imageUrl: item.imageUrl!.isEmpty ? "" : item.foodId!,
                                    );
                                  },
                              );
                            }
                          }
                          // if(state is ItemLoadedSearched){
                          //   if (state.items.isEmpty) {
                          //   return const Center(
                          //     child: Text('No Item Found'),
                          //   );
                          // }
                          // else{
                          //     itemList = state.items;
                          //   return GridView.builder(
                          //     itemCount: state.items.length,
                          //     gridDelegate:
                          //     SliverGridDelegateWithFixedCrossAxisCount(
                          //       crossAxisCount: 4,
                          //       //crossAxisCount: getCrossAxisCount(context),
                          //       //crossAxisCount: crossAxisCount,
                          //       mainAxisSpacing: 10.h,
                          //       crossAxisSpacing: 4.w,
                          //       childAspectRatio: 0.76,
                          //     ),
                          //     itemBuilder: (context, index) {
                          //       ItemList itemmodel = state.items[index];
                          //           return ItemCard(
                          //             onTap: (){},
                          //             itemName: itemmodel.foodName!,
                          //             time: '20 min',
                          //             ratings: '⭐ 4.5',
                          //             price: itemmodel.foodPortions!.isNotEmpty ? itemmodel.foodPortions!.first.portionPrice!.toString() : itemmodel.unitPrice.toString(),
                          //             imageUrl: itemmodel.imageUrl!.isEmpty ? "" : itemmodel.foodId!,
                          //           );
                          //         },
                          //   );
                          // }
                          // }
                          print('state is: $ItemDataLoadedState');
                          if(state is ItemDataLoadedState){
                            if(state.allSettings.itemList!.isEmpty){
                              return const Center(child: Text('No Item Found'),);
                            }
                            else
                              {
                                itemList = state.allSettings.itemList!;
                                return GridView.builder(
                                  itemCount: state.allSettings.itemList!.length,
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
                                    ItemList itemmodel = state.allSettings.itemList![index];
                                    return ItemCard(
                                      onTap: (){},
                                      itemName: itemmodel.foodName!,
                                      time: '20 min',
                                      ratings: '⭐ 4.5',
                                      price: itemmodel.foodPortions!.isNotEmpty ? itemmodel.foodPortions!.first.portionPrice!.toString() : itemmodel.unitPrice.toString(),
                                      imageUrl: itemmodel.imageUrl!.isEmpty ? "" : itemmodel.foodId!,
                                    );
                                  },
                                );

                              }
                          }
                          else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }, ),
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
      ),),
    );
  }
}
