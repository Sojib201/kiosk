import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiosk/src/core/utils/color_utils.dart';
import 'package:kiosk/src/data/models/settings_mode.dart';
import 'package:kiosk/src/features/item_screen/bloc/item_screen_bloc.dart';
import 'package:kiosk/src/features/item_screen/widgets/category_item_widget.dart';

import 'bloc/category_bloc.dart';

class CategoryWidget extends StatefulWidget {
  AllSettings allSettings;
  CategoryWidget({
    Key? key,
    required this.allSettings,
  }) : super(key: key);

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(CategoryLoadedEvent( allSettings: widget.allSettings));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        log("Rebuilding UI with state: $state");

        if (state is CategoryLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is CategoryLoaded) {

          final categories = state.categoryElement;
          if (categories.isEmpty) {
            return const Center(child: Text("No categories available"));
          }

          return Container(
            decoration: BoxDecoration(
              color: ColorUtils.secondaryColor,
              borderRadius: BorderRadius.circular(14.r),),

            width: (MediaQuery.of(context).size.width * 0.15).w,
            padding:  EdgeInsets.symmetric(vertical: 10.h),
            child: ListView.builder(
              itemCount:  state.categoryElement.length ,
              itemBuilder: (context, index) {
                final category = categories[index];
                return Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                  child: CategoryItemWidget(
                    isSelected: index == selectedIndex,
                    onTap: () {
                      setState(()
                      {
                         selectedIndex = index;
                        // String? selectedCategory = state.categoryElement[index].categoryName ;
                        //
                        // if (selectedCategory != null) {
                        //   context.read<ItemScreenBloc>().add(SearchItemEvent(selectedCategory, widget.allSettings.itemList ?? []));
                        // }
                      }
                      );
                    },
                    categoryName: category.categoryName ?? '',
                    imageUrl: category.imageUrl.toString(),
                  ),
                );
              },
            ),
          );
        }

        return Text("Empty");
      },
    );
  }
}
