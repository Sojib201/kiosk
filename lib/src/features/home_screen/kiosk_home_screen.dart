import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kiosk/src/core/constants/const_string.dart';
import 'package:kiosk/src/core/constants/hive_constants.dart';
import 'package:kiosk/src/core/utils/color_utils.dart';
import 'package:kiosk/src/data/models/settings_mode.dart';
import 'package:kiosk/src/features/home_screen/widgets/add_item_popup/bloc/qty_inc_dec/qty_inc_dec_bloc.dart';
import 'package:kiosk/src/features/home_screen/widgets/add_item_popup/bloc/qty_inc_dec/qty_inc_dec_event.dart';
import 'package:kiosk/src/features/home_screen/widgets/add_item_popup/selected_item_popup.dart';
import 'package:kiosk/src/features/home_screen/widgets/busket_widget.dart';
import 'package:kiosk/src/features/home_screen/widgets/catagory/category_widget.dart';
import 'package:kiosk/src/features/home_screen/widgets/home_banner_slider.dart';
import 'package:kiosk/src/features/home_screen/widgets/item_card.dart';
import 'package:kiosk/src/features/home_screen/widgets/order_cart_widget.dart';
import 'package:kiosk/src/features/home_screen/widgets/tag_widget.dart';
import '../../core/shared/firebase/firebase_api.dart';
import '../../data/models/order_model.dart';
import 'app_drawer/AppDrawer.dart';
import 'bloc/add_to_cart/order_bloc.dart';
import 'bloc/item_screen_bloc/cart_bloc/cart_event.dart';
import 'bloc/item_screen_bloc/item_screen_bloc.dart';
import 'bloc/item_screen_bloc/item_show_bloc/item_show_bloc.dart';
import 'bloc/item_screen_bloc/item_show_bloc/item_show_event.dart';
import 'bloc/item_screen_bloc/item_show_bloc/item_show_state.dart';




OrderSingleton orderModel = OrderSingleton();

class KioskHomeScreen extends StatefulWidget {
  const KioskHomeScreen({super.key});

  @override
  State<KioskHomeScreen> createState() => _KioskHomeScreenState();
}

class _KioskHomeScreenState extends State<KioskHomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<ItemList> itemList = [];
  AllSettings? allSettings;
  TextEditingController _searchingController = TextEditingController();

  FirebaseAPIs? _firebaseAPIs;


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
  List<String> selectedTags = [];
 String selectedCategory='';


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
    context.read<ItemScreenBloc>().add(
          GetAllResturantData(false),
        );
    _firebaseAPIs = FirebaseAPIs();

    _firebaseAPIs!.getInformation();
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
        child: BlocConsumer<ItemScreenBloc, ItemScreenState>(
          listener:  (context, state) {
            if (state is OrderSubmittedSuccessState) {
              log("333333333333333333333333333388888888888888888888234324324");
              //context.read<HomeBloc>().add(GetTableStatus("B001", false));
              Fluttertoast.showToast(msg: state.message);

              Navigator.pop(context);
              orderModel.clearAllData();
              context.read<ItemScreenBloc>().add(
                GetAllResturantData(false),
              );

            }
          },
          builder: (context, state) {
            if (state is ItemDataLoadedState) {
              allSettings = state.allSettings;
              return Column(
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
                        SizedBox(
                          width: 20.w,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 24.h),
                            child: SizedBox(
                              height: 45.h,
                              child: TextField(
                                controller: _searchingController,
                                onChanged: (query) {
                                  // if(query.trim().isEmpty){
                                  //   // context.read<ItemShowBloc>().add(
                                  //   //     SearchingEvent(
                                  //   //        // allSettings: allSettings!,
                                  //   //       itemList: itemList,
                                  //   //         searchQuery: ""),
                                  //   // );
                                  //
                                  //   context.read<ItemShowBloc>().add(
                                  //     FilterItemEvent(
                                  //         allSettings: state.allSettings,
                                  //         selectedTags: selectedTags,
                                  //         selectedCategory:selectedCategory ,
                                  //         searchQuery: ""
                                  //     ),
                                  //   );
                                  // }
                                  // else {
                                    // context.read<ItemShowBloc>().add(
                                    //   SearchingEvent(
                                    //     // allSettings: allSettings!,
                                    //     itemList: itemList,
                                    //     searchQuery: query,
                                    //   ),
                                    // );
                                    context.read<ItemShowBloc>().add(
                                      FilterItemEvent(
                                          allSettings: allSettings!,
                                          selectedTags: selectedTags,
                                          selectedCategory:selectedCategory,
                                          searchQuery: _searchingController.text.trim()
                                      ),
                                    );
                                  // }

                                  // if (query.isEmpty) {
                                  //   context.read<ItemShowBloc>().add(
                                  //         CategorySearchingEvent(
                                  //             searchItem: allSettings!
                                  //                 .category!
                                  //                 .first
                                  //                 .categoryList!
                                  //                 .first
                                  //                 .categoryName
                                  //                 .toString(),
                                  //             allSettings: allSettings!),
                                  //       );
                                  // }
                                },
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    padding: EdgeInsets.only(
                                        right: 10.w, bottom: 2.h, top: 3.h),
                                    onPressed: () {
                                      _searchingController.clear();
                                      context.read<ItemShowBloc>().add(
                                        FilterItemEvent(
                                            allSettings: allSettings!,
                                            selectedTags: selectedTags,
                                            selectedCategory:selectedCategory,
                                            searchQuery: _searchingController.text.trim()
                                        ),
                                      );
                                      // _searchingController.addListener(() {
                                      //   context.read<ItemShowBloc>().add(
                                      //     FilterItemEvent(
                                      //         allSettings: allSettings!,
                                      //         selectedTags: selectedTags,
                                      //         selectedCategory:selectedCategory,
                                      //         searchQuery: _searchingController.text.trim()
                                      //     ),
                                      //   );
                                      // });
                                      // context.read<ItemShowBloc>().add(
                                      //     SearchingEvent(
                                      //         // allSettings: allSettings!,
                                      //         itemList: itemList,
                                      //         searchQuery: ""));
                                      // context.read<ItemShowBloc>().add(
                                      //       CategorySearchingEvent(
                                      //         allSettings: allSettings!,
                                      //         searchItem: allSettings!
                                      //             .category!
                                      //             .first
                                      //             .categoryList!
                                      //             .first
                                      //             .categoryName
                                      //             .toString(),
                                      //       ),
                                      //     );
                                    },
                                    icon: Icon(
                                      Icons.cancel_outlined,
                                      color: ColorUtils.secondaryColor,
                                      size: 28.h,
                                    ),
                                  ),
                                  hintText: "Search",
                                  hintStyle: TextStyle(fontSize: 19.sp),
                                  filled: true,
                                  fillColor: ColorUtils.primaryColor,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5.h, horizontal: 12.w),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.r),
                                    borderSide: BorderSide(
                                        color: ColorUtils.black, width: 0.5.w),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.r),
                                    borderSide: BorderSide(
                                        color: ColorUtils.black, width: 0.5.w),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.r),
                                    borderSide: BorderSide(
                                        color: ColorUtils.black, width: 0.5.w),
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
                            onTap: () {
                              print('fff');
                              //Scaffold.of(context).openEndDrawer();
                              _scaffoldKey.currentState?.openEndDrawer();
                            },
                            child: Icon(
                              Icons.menu,
                              size: 45.h,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        CategoryWidget(
                          selectedCategory: (selectedCategoryFromWidget) {
                            selectedCategory =selectedCategoryFromWidget;
                              context.read<ItemShowBloc>().add(
                                FilterItemEvent(
                                  allSettings: state.allSettings,
                                  selectedTags: selectedTags,
                                  selectedCategory:selectedCategory ,
                                  searchQuery: _searchingController.text.trim()
                                ),
                              );

                          },
                          allSettings: state.allSettings,

                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HomeBannerSlider(
                                imageAssets: imageAssets,
                                onTap: () {
                                  print('yyy');
                                },
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6.w),
                                child: SizedBox(
                                  height: 36.h,
                                  width: double.infinity,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        state.allSettings.tagsList!.length,
                                    itemBuilder: (context, index) {
                                      return TagWidget(
                                        isSelected:
                                            selectedIndex.contains(index),

                                        onTap: () {
                                          setState(() {
                                            if (selectedIndex.contains(index)) {
                                              selectedIndex.remove(index);
                                            } else {
                                              selectedIndex.add(index);
                                            }
                                             selectedTags = selectedIndex.map((i) {
                                              return allSettings!.tagsList![i].tagName.toString();
                                            }).toList();
                                            context.read<ItemShowBloc>().add(
                                              FilterItemEvent(
                                                  allSettings: state.allSettings,
                                                  selectedTags: selectedTags,
                                                  selectedCategory:selectedCategory ,
                                                  searchQuery: _searchingController.text.trim()
                                              ),
                                            );

                                              // final selectedTags = selectedIndex.map((i) {
                                              //   return allSettings!.tagsList![i].tagName.toString();
                                              // }).toList();
                                            // context.read<ItemShowBloc>().add(
                                            //   TagSearchingEvent(
                                            //       // allSettings:allSettings!,
                                            //       itemList: itemList,
                                            //       selectedTags: selectedTags
                                            //
                                            //   ),
                                            // );
                                            // context.read<ItemShowBloc>().add(
                                            //   FilterItemEvent(
                                            //       allSettings: state.allSettings,
                                            //       selectedTags: selectedTags,
                                            //       selectedCategory:selectedCategory ,
                                            //       searchQuery: _searchingController.text.trim()
                                            //   ),
                                            // );

                                            // if (selectedIndex.isNotEmpty) {
                                            //   final selectedTags = selectedIndex.map((i) {
                                            //     return allSettings!.tagsList![i].tagName.toString();
                                            //   }).toList();
                                            //
                                            //   context.read<ItemShowBloc>().add(
                                            //     TagSearchingEvent(
                                            //       itemList:itemList, selectedTags: selectedTags
                                            //
                                            //     ),
                                            //   );
                                            // }
                                            // else {
                                            //   context.read<ItemShowBloc>().add(
                                            //     CategorySearchingEvent(
                                            //         searchItem: allSettings!
                                            //             .category!
                                            //             .first
                                            //             .categoryList!
                                            //             .first
                                            //             .categoryName
                                            //             .toString(),
                                            //         allSettings: allSettings!),
                                            //   );
                                            // }
                                          });
                                        },
                                        label: state.allSettings
                                            .tagsList![index].tagName
                                            .toString(),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Expanded(
                                child: BlocBuilder<ItemShowBloc, ItemShowState>(
                                  builder: (context, state) {
                                    // if(state is ItemfromCategory){
                                    //   if (state.items.isEmpty) {
                                    //
                                    //     return const Center(
                                    //         child: Text('No Items Found'));
                                    //   } else {
                                    //     itemList=state.items;
                                    //     return Column(
                                    //       crossAxisAlignment:
                                    //       CrossAxisAlignment.start,
                                    //       children: [
                                    //         Padding(
                                    //           padding: EdgeInsets.symmetric(
                                    //               horizontal: 6.w),
                                    //           child: Text(
                                    //             state.title,
                                    //             style: TextStyle(
                                    //                 fontSize: 22.sp,
                                    //                 fontWeight:
                                    //                 FontWeight.w500),
                                    //           ),
                                    //         ),
                                    //         SizedBox(height: 8.h),
                                    //         Expanded(
                                    //           child: GridView.builder(
                                    //             itemCount:
                                    //             state.items.length,
                                    //             gridDelegate:
                                    //             SliverGridDelegateWithFixedCrossAxisCount(
                                    //               crossAxisCount: 4,
                                    //               mainAxisSpacing: 10.h,
                                    //               crossAxisSpacing: 4.w,
                                    //               childAspectRatio: 0.76,
                                    //             ),
                                    //             itemBuilder: (context, index) {
                                    //               ItemList itemmodel = state.items[index];
                                    //               return ItemCard(
                                    //                 onTap: () {},
                                    //                 itemName:
                                    //                 itemmodel.foodName!,
                                    //                 time: '20 min',
                                    //                 ratings: '⭐ 4.5',
                                    //                 price: itemmodel
                                    //                     .foodPortions!
                                    //                     .isNotEmpty
                                    //                     ? itemmodel
                                    //                     .foodPortions!
                                    //                     .first
                                    //                     .portionPrice!
                                    //                     .toString()
                                    //                     : itemmodel.unitPrice
                                    //                     .toString(),
                                    //                 imageUrl: itemmodel
                                    //                     .imageUrl!.isEmpty
                                    //                     ? ""
                                    //                     : itemmodel.foodId!,
                                    //               );
                                    //             },
                                    //           ),
                                    //         )
                                    //       ],
                                    //     );
                                    //   }
                                    // }
                                    // if (state is ItemSearchResult) {
                                    //   if (state.filteredItems.isEmpty) {
                                    //     return const Center(
                                    //         child: Text('No Items Found'));
                                    //   } else {
                                    //     itemList=state.filteredItems;
                                    //     return Column(
                                    //       crossAxisAlignment:
                                    //           CrossAxisAlignment.start,
                                    //       children: [
                                    //         Padding(
                                    //           padding: EdgeInsets.symmetric(
                                    //               horizontal: 6.w),
                                    //           child: Text(
                                    //             state.title,
                                    //             style: TextStyle(
                                    //                 fontSize: 22.sp,
                                    //                 fontWeight:
                                    //                     FontWeight.w500),
                                    //           ),
                                    //         ),
                                    //         SizedBox(height: 8.h),
                                    //         Expanded(
                                    //           child: GridView.builder(
                                    //             itemCount:
                                    //                 state.filteredItems.length,
                                    //             gridDelegate:
                                    //                 SliverGridDelegateWithFixedCrossAxisCount(
                                    //               crossAxisCount: 4,
                                    //               mainAxisSpacing: 10.h,
                                    //               crossAxisSpacing: 4.w,
                                    //               childAspectRatio: 0.76,
                                    //             ),
                                    //             itemBuilder: (context, index) {
                                    //               ItemList itemmodel = state
                                    //                   .filteredItems[index];
                                    //               return ItemCard(
                                    //                 onTap: () {},
                                    //                 itemName:
                                    //                     itemmodel.foodName!,
                                    //                 time: '20 min',
                                    //                 ratings: '⭐ 4.5',
                                    //                 price: itemmodel
                                    //                         .foodPortions!
                                    //                         .isNotEmpty
                                    //                     ? itemmodel
                                    //                         .foodPortions!
                                    //                         .first
                                    //                         .portionPrice!
                                    //                         .toString()
                                    //                     : itemmodel.unitPrice
                                    //                         .toString(),
                                    //                 imageUrl: itemmodel
                                    //                         .imageUrl!.isEmpty
                                    //                     ? ""
                                    //                     : itemmodel.foodId!,
                                    //               );
                                    //             },
                                    //           ),
                                    //         )
                                    //       ],
                                    //     );
                                    //   }
                                    // }
                                    // if(state is ItemTagSearchResult){
                                    //   if (state.filteredItems.isEmpty) {
                                    //     return const Center(
                                    //         child: Text('No Items Found'));
                                    //   } else {
                                    //     itemList=state.filteredItems;
                                    //     return Column(
                                    //       crossAxisAlignment:
                                    //       CrossAxisAlignment.start,
                                    //       children: [
                                    //         Padding(
                                    //           padding: EdgeInsets.symmetric(
                                    //               horizontal: 6.w),
                                    //           child: Text(
                                    //             state.title,
                                    //             style: TextStyle(
                                    //                 fontSize: 22.sp,
                                    //                 fontWeight:
                                    //                 FontWeight.w500),
                                    //           ),
                                    //         ),
                                    //         SizedBox(height: 8.h),
                                    //         Expanded(
                                    //           child: GridView.builder(
                                    //             itemCount:
                                    //             state.filteredItems.length,
                                    //             gridDelegate:
                                    //             SliverGridDelegateWithFixedCrossAxisCount(
                                    //               crossAxisCount: 4,
                                    //               mainAxisSpacing: 10.h,
                                    //               crossAxisSpacing: 4.w,
                                    //               childAspectRatio: 0.76,
                                    //             ),
                                    //             itemBuilder: (context, index) {
                                    //               ItemList itemmodel = state
                                    //                   .filteredItems[index];
                                    //               return ItemCard(
                                    //                 onTap: () {},
                                    //                 itemName:
                                    //                 itemmodel.foodName!,
                                    //                 time: '20 min',
                                    //                 ratings: '⭐ 4.5',
                                    //                 price: itemmodel
                                    //                     .foodPortions!
                                    //                     .isNotEmpty
                                    //                     ? itemmodel
                                    //                     .foodPortions!
                                    //                     .first
                                    //                     .portionPrice!
                                    //                     .toString()
                                    //                     : itemmodel.unitPrice
                                    //                     .toString(),
                                    //                 imageUrl: itemmodel
                                    //                     .imageUrl!.isEmpty
                                    //                     ? ""
                                    //                     : itemmodel.foodId!,
                                    //               );
                                    //             },
                                    //           ),
                                    //         )
                                    //       ],
                                    //     );
                                    //   }
                                    //
                                    // }
                                    if(state is FilterItemState){
                                      if (state.items.isEmpty) {
                                        return const Center(
                                            child: Text('No Items Found'));
                                      } else {
                                        // itemList=state.items;
                                        return Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 6.w),
                                              child: Text(
                                                'All Items',
                                                style: TextStyle(
                                                    fontSize: 22.sp,
                                                    fontWeight:
                                                    FontWeight.w500),
                                              ),
                                            ),
                                            SizedBox(height: 8.h),
                                            Expanded(
                                              child: GridView.builder(
                                                itemCount:
                                                state.items.length,
                                                gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 4,
                                                  mainAxisSpacing: 10.h,
                                                  crossAxisSpacing: 4.w,
                                                  childAspectRatio: 0.76,
                                                ),
                                                itemBuilder: (context, index) {
                                                  ItemList itemmodel = state
                                                      .items[index];
                                                  print('imgurl: ${itemmodel.imageUrl.toString()}');
                                                  return ItemCard(
                                                    onTap: () {

                                                      String today = DateFormat.E().format(DateTime.now()).toLowerCase();
                                                      DateTime now = DateTime.now();
                                                      DateFormat format = DateFormat("hh:mm a");
                                                      DateTime from = format.parse(itemmodel.availableTime!.availableFrom!);
                                                      DateTime to = format.parse(itemmodel.availableTime!.availableTo!);
                                                      DateTime nowTime = format.parse(format.format(now));

                                                      if (nowTime.isAfter(from) &&
                                                          nowTime.isBefore(to)) {
                                                        context.read<QtyIncDecBloc>().add(const QtyIncDecPerform(qty: 1),);

                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return SelectedItemPopup(
                                                                item:
                                                                    itemmodel);
                                                          },
                                                        );
                                                      }
                                                    },
                                                    itemName:
                                                    itemmodel.foodName!,
                                                    time: '20 min',
                                                    ratings: '⭐ 4.5',
                                                    price: itemmodel
                                                        .foodPortions!
                                                        .isNotEmpty
                                                        ? itemmodel
                                                        .foodPortions!
                                                        .first
                                                        .portionPrice!
                                                        .toString()
                                                        : itemmodel.unitPrice
                                                        .toString(),
                                                    imageUrl: itemmodel.imageUrl!.isEmpty ? "" : itemmodel.foodId!,
                                                  );
                                                },
                                              ),
                                            )
                                          ],
                                        );
                                      }

                                    }
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 6.w),
                                          child: Text(
                                            "All Items",
                                            style: TextStyle(
                                                fontSize: 22.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        SizedBox(height: 8.h),
                                        Expanded(
                                          child: GridView.builder(
                                            itemCount:
                                                allSettings!.itemList!.length,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 4,
                                              mainAxisSpacing: 10.h,
                                              crossAxisSpacing: 4.w,
                                              childAspectRatio: 0.76,
                                            ),
                                            itemBuilder: (context, index) {
                                              ItemList itemmodel =
                                                  allSettings!.itemList![index];
                                              itemList=allSettings!.itemList!;
                                              return ItemCard(
                                                onTap: () {

                                                  String today = DateFormat.E().format(DateTime.now()).toLowerCase();
                                                  DateTime now = DateTime.now();
                                                  DateFormat format = DateFormat("hh:mm a");
                                                  DateTime from = format.parse(itemmodel.availableTime!.availableFrom!);
                                                  DateTime to = format.parse(itemmodel.availableTime!.availableTo!);
                                                  DateTime nowTime = format.parse(format.format(now));


                                                  if(nowTime.isAfter(from) && nowTime.isBefore(to)){

                                                    context.read<QtyIncDecBloc>().add(
                                                      const QtyIncDecPerform(qty: 1),
                                                    );

                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return SelectedItemPopup(item:itemmodel );
                                                      },
                                                    );
                                                  }

                                                },
                                                itemName: itemmodel.foodName!,
                                                time: '20 min',
                                                ratings: '⭐ 4.5',
                                                price: itemmodel.foodPortions!
                                                        .isNotEmpty
                                                    ? itemmodel.foodPortions!
                                                        .first.portionPrice!
                                                        .toString()
                                                    : itemmodel.unitPrice
                                                        .toString(),
                                                imageUrl:
                                                    itemmodel.imageUrl!.isEmpty
                                                        ? ""
                                                        : itemmodel.foodId!,
                                              );
                                            },
                                          ),
                                        )
                                      ],

                                      // child: BlocBuilder<ItemShowBloc,ItemShowState>(
                                      //   builder: (context, state) {
                                      //     if(state is ItemSearchResult){
                                      //       if (state.filteredItems.isEmpty) {
                                      //         return const Center(child: Text('No Items Found'));
                                      //       }
                                      //       else{
                                      //         return GridView.builder(
                                      //           itemCount: state.filteredItems.length,
                                      //           gridDelegate:
                                      //           SliverGridDelegateWithFixedCrossAxisCount(
                                      //             crossAxisCount: 4,
                                      //             mainAxisSpacing: 10.h,
                                      //             crossAxisSpacing: 4.w,
                                      //             childAspectRatio: 0.76,
                                      //           ),
                                      //           itemBuilder: (context, index) {
                                      //             ItemList itemmodel =state.filteredItems[index];
                                      //             return ItemCard(
                                      //               onTap: (){},
                                      //               itemName: itemmodel.foodName!,
                                      //               time: '20 min',
                                      //               ratings: '⭐ 4.5',
                                      //               price: itemmodel.foodPortions!.isNotEmpty ? itemmodel.foodPortions!.first.portionPrice!.toString() : itemmodel.unitPrice.toString(),
                                      //               imageUrl: itemmodel.imageUrl!.isEmpty ? "" : itemmodel.foodId!,
                                      //             );
                                      //           },
                                      //         );
                                      //       }
                                      //
                                      //     }
                                      //     return GridView.builder(
                                      //       itemCount: allSettings!.itemList!.length,
                                      //       gridDelegate:
                                      //       SliverGridDelegateWithFixedCrossAxisCount(
                                      //         crossAxisCount: 4,
                                      //         mainAxisSpacing: 10.h,
                                      //         crossAxisSpacing: 4.w,
                                      //         childAspectRatio: 0.76,
                                      //       ),
                                      //       itemBuilder: (context, index) {
                                      //         ItemList itemmodel = allSettings!.itemList![index];
                                      //         return ItemCard(
                                      //           onTap: (){},
                                      //           itemName: itemmodel.foodName!,
                                      //           time: '20 min',
                                      //           ratings: '⭐ 4.5',
                                      //           price: itemmodel.foodPortions!.isNotEmpty ? itemmodel.foodPortions!.first.portionPrice!.toString() : itemmodel.unitPrice.toString(),
                                      //           imageUrl: itemmodel.imageUrl!.isEmpty ? "" : itemmodel.foodId!,
                                      //         );
                                      //       },
                                      //     );
                                      //   }, ),
                                    );
                                  },
                                ),
                              ),

                              BlocBuilder<OrderBloc, OrderState>(builder: (context,state){
                                print('state: $OrderItemShowState');

                               if(state is OrderItemShowState){
                                 print('total: ${state.total}');
                                 print('vat: ${state.vat}');
                                 print('discount: ${state.discount}');


                                 int qty=0;
                                 for (var e in orderModel.orderData.orderDetails) {
                                   qty+= e.quantity;

                                 }

                                 print('qty:${qty.toString()}');
                                  return OrderCartWidget( orderCount:qty.toString() , price: orderModel.orderData.grandTotal.toStringAsFixed(2), onCancel: (){}, onTap: (){
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {


                                        return BusketWidget(
                                          allSettings: allSettings!,
                                        );
                                      },
                                    );
                                  },);
                                }
                               return OrderCartWidget( orderCount: '0', price: '0', onCancel:(){}, onTap: (){
                                 showDialog(
                                   context: context,
                                   builder: (BuildContext context) {

                                     return BusketWidget(
                                       allSettings: allSettings!,
                                     );
                                   },
                                 );
                               });
                              }),


                              // BlocBuilder<CartBloc, CartState>(
                              //   builder: (context, state) {
                              //     if (state.items.isNotEmpty) {
                              //       return OrderCartWidget(
                              //         title: "Your Order",
                              //         orderCount: state.totalCount.toString(),
                              //         price: state.totalPrice.toString(),
                              //         onCancel: () => context.read<CartBloc>().add(ClearCart()),
                              //         onOrder: () {
                              //           // Handle order submit
                              //         },
                              //       );
                              //     }
                              //     return OrderCartWidget(title: "Your Order", orderCount: '0', price: '0', onCancel:(){}, onOrder:(){});
                              //
                              //   },
                              // ),

                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            }
            else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

enum DiscountType { percentage, fixed }
