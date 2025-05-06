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
import 'package:kiosk/src/features/item_screen/widgets/catagory/category_widget.dart';
import 'package:kiosk/src/features/item_screen/widgets/home_banner_slider.dart';
import 'package:kiosk/src/features/item_screen/widgets/item_card.dart';
import 'package:kiosk/src/features/item_screen/widgets/order_cart_widget.dart';
import 'package:kiosk/src/features/item_screen/widgets/tag_widget.dart';
import 'app_drawer/AppDrawer.dart';
import 'bloc/item_screen_bloc/item_screen_bloc.dart';
import 'bloc/item_screen_bloc/item_show_bloc/item_show_bloc.dart';
import 'bloc/item_screen_bloc/item_show_bloc/item_show_event.dart';
import 'bloc/item_screen_bloc/item_show_bloc/item_show_state.dart';

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

    context.read<ItemScreenBloc>().add(
          GetAllResturantData(false),
        );
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
        child: BlocBuilder<ItemScreenBloc, ItemScreenState>(
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
                                  if(query.trim().isEmpty){
                                    context.read<ItemShowBloc>().add(
                                        SearchingEvent(
                                           // allSettings: allSettings!,
                                          itemList: itemList,
                                            searchQuery: ""));
                                  }
                                  else {
                                    context.read<ItemShowBloc>().add(
                                      SearchingEvent(
                                        // allSettings: allSettings!,
                                        itemList: itemList,
                                        searchQuery: query,
                                      ),
                                    );
                                  }

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
                                      _searchingController.addListener(() {
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
                                      });
                                      context.read<ItemShowBloc>().add(
                                          SearchingEvent(
                                              // allSettings: allSettings!,
                                              itemList: itemList,
                                              searchQuery: ""));
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
                                    ),
                                  ),
                                  hintText: "Search",
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

                                              final selectedTags = selectedIndex.map((i) {
                                                return allSettings!.tagsList![i].tagName.toString();
                                              }).toList();
                                            context.read<ItemShowBloc>().add(
                                              TagSearchingEvent(
                                                  // allSettings:allSettings!,
                                                  itemList: itemList,
                                                  selectedTags: selectedTags

                                              ),
                                            );

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
                                    if(state is ItemfromCategory){
                                      if (state.items.isEmpty) {

                                        return const Center(
                                            child: Text('No Items Found'));
                                      } else {
                                        itemList=state.items;
                                        return Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 6.w),
                                              child: Text(
                                                state.title,
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
                                                  ItemList itemmodel = state.items[index];
                                                  return ItemCard(
                                                    onTap: () {},
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
                                                    imageUrl: itemmodel
                                                        .imageUrl!.isEmpty
                                                        ? ""
                                                        : itemmodel.foodId!,
                                                  );
                                                },
                                              ),
                                            )
                                          ],
                                        );
                                      }
                                    }
                                    if (state is ItemSearchResult) {
                                      if (state.filteredItems.isEmpty) {
                                        return const Center(
                                            child: Text('No Items Found'));
                                      } else {
                                        itemList=state.filteredItems;
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 6.w),
                                              child: Text(
                                                state.title,
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
                                                    state.filteredItems.length,
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 4,
                                                  mainAxisSpacing: 10.h,
                                                  crossAxisSpacing: 4.w,
                                                  childAspectRatio: 0.76,
                                                ),
                                                itemBuilder: (context, index) {
                                                  ItemList itemmodel = state
                                                      .filteredItems[index];
                                                  return ItemCard(
                                                    onTap: () {},
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
                                                    imageUrl: itemmodel
                                                            .imageUrl!.isEmpty
                                                        ? ""
                                                        : itemmodel.foodId!,
                                                  );
                                                },
                                              ),
                                            )
                                          ],
                                        );
                                      }
                                    }
                                    if(state is ItemTagSearchResult){
                                      if (state.filteredItems.isEmpty) {
                                        return const Center(
                                            child: Text('No Items Found'));
                                      } else {
                                        itemList=state.filteredItems;
                                        return Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 6.w),
                                              child: Text(
                                                state.title,
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
                                                state.filteredItems.length,
                                                gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 4,
                                                  mainAxisSpacing: 10.h,
                                                  crossAxisSpacing: 4.w,
                                                  childAspectRatio: 0.76,
                                                ),
                                                itemBuilder: (context, index) {
                                                  ItemList itemmodel = state
                                                      .filteredItems[index];
                                                  return ItemCard(
                                                    onTap: () {},
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
                                                    imageUrl: itemmodel
                                                        .imageUrl!.isEmpty
                                                        ? ""
                                                        : itemmodel.foodId!,
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
                                                onTap: () {},
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
                              OrderCartWidget(
                                title: "Your Order",
                                itemCount: 2,
                                price: 50.50,
                                onCancel: () {},
                                onOrder: () {},
                              ),
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
