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
import 'package:kiosk/src/features/item_screen/widgets/catagory_cuisin/bloc/category_bloc.dart';
import 'package:kiosk/src/features/item_screen/widgets/catagory_cuisin/category_widget.dart';
import 'package:kiosk/src/features/item_screen/widgets/home_banner_slider.dart';
import 'package:kiosk/src/features/item_screen/widgets/item_card.dart';
import 'package:kiosk/src/features/item_screen/widgets/order_cart_widget.dart';
import 'package:kiosk/src/features/item_screen/widgets/category_item_widget.dart';
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

  List<int> selectedIndex = [];


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

    // context.read<CategorycuisinBloc>().add(CategorycuisinloadedEvent(allSettings: widget.allSettings, isCat: true, isFood: true));
    // context.read<ItemScreenBloc>().add(
    //   SearchItemEvent(allSettings!.category!.first.categoryList!.first.categoryName!, allSettings!.itemList ?? []),
    // );
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
                        // onChanged: (query) {
                        //   context.read<ItemScreenBloc>().add(SearchingEvent(query, allSettings?.itemList??[]));
                        //   print('query:$query');
                        //
                        //   if (query.isEmpty) {
                        //     context.read<ItemScreenBloc>().add(
                        //       SearchItemEvent(
                        //         //allSettings?.category.first.categoryList!.first.categoryName!!,
                        //         allSettings?.category!.first.categoryList!.first.categoryName??'',
                        //         allSettings!.itemList ?? [],
                        //       ),
                        //     );
                        //   }
                        // },
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
                BlocBuilder<ItemScreenBloc, ItemScreenState>(
                  builder: (context, state) {
                    if(state is ItemDataLoadedState){
                      return CategoryWidget(
                        allSettings: state.allSettings,
                      );
                      }
                    return Text("Empty");
                    },
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
                      BlocBuilder<ItemScreenBloc, ItemScreenState>(
                          builder: (context, state) {
                            if(state is ItemDataLoadedState){
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6.w),
                                child: SizedBox(
                                  height: 36.h,
                                  width:double.infinity,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state.allSettings.tagsList!.length,
                                    itemBuilder: (context, index) {
                                      return TagWidget(
                                        // isSelected: index == selectedIndex,
                                        isSelected: selectedIndex.contains(index),
                                        // onTap: (){
                                        //   setState(
                                        //         () {
                                        //       if (selectedIndex == index) {
                                        //         selectedIndex = -1;
                                        //       } else {
                                        //         selectedIndex = index;
                                        //       }
                                        //
                                        //       if (selectedIndex != -1) {
                                        //
                                        //       } else {
                                        //
                                        //       }
                                        //     },
                                        //   );
                                        // },
                                        onTap: () {
                                          setState(() {
                                            if (selectedIndex.contains(index)) {
                                              selectedIndex.remove(index);
                                            } else {
                                              selectedIndex.add(index);
                                            }

                                            if (selectedIndex.isNotEmpty) {
                                              final selectedTags = selectedIndex.map((i) {
                                                return state.allSettings.tagsList![i].tagName.toString();
                                              }).toList();

                                              // context.read<ItemScreenBloc>().add(
                                              //   SearchingTag(
                                              //     selectedTags,
                                              //     state.allSettings.itemList!,
                                              //   ),
                                              // );
                                            } else {
                                              // context.read<ItemScreenBloc>().add(
                                              //   SearchItemEvent(
                                              //     state.allSettings.category!.first.categoryList!.first.categoryName!,
                                              //     state.allSettings.itemList ?? [],
                                              //   ),
                                              // );
                                            }
                                          });
                                        },
                                        label: state.allSettings.tagsList![index].tagName.toString(),
                                      );
                                    },
                                  ),
                                ),
                              );
                            }
                            return Text("Empty");

                          },
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
                            print('ItemSearchResult: ${state.filteredItems}');
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
                          if(state is ItemLoadedSearched){
                            if (state.items.isEmpty) {
                            return const Center(
                              child: Text('No Item Found'),
                            );
                          }
                          else{
                              itemList = state.items;
                            return GridView.builder(
                              itemCount: state.items.length,
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
                                ItemList itemmodel = state.items[index];
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
                          if(state is ItemDataLoadedState){
                            context.read<CategoryBloc>().add(CategoryLoadedEvent(allSettings: state.allSettings,));
                            print('Item: ${state.allSettings.itemList}');
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
