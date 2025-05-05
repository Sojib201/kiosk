import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiosk/src/core/utils/color_utils.dart';
import 'package:kiosk/src/data/models/settings_mode.dart';
import 'package:kiosk/src/features/item_screen/bloc/item_screen_bloc/item_show_bloc/item_show_bloc.dart';
import 'package:kiosk/src/features/item_screen/widgets/category_item_widget.dart';

import '../../bloc/item_screen_bloc/item_show_bloc/item_show_event.dart';


class CategoryWidget extends StatefulWidget {
  AllSettings allSettings;
  CategoryWidget({
    super.key,
    required this.allSettings,
  });

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<CategoryList> categoryList = [];
    if (widget.allSettings.category != null) {
      for (int i = 0; i < widget.allSettings.category!.length; i++) {
        if (widget.allSettings.category![i].categoryList != null) {
          categoryList.addAll(widget.allSettings.category![i].categoryList!);
        }
      }
    }
    return Container(
      decoration: BoxDecoration(
        color: ColorUtils.secondaryColor,
        borderRadius: BorderRadius.circular(14.r),),

      width: (MediaQuery.of(context).size.width * 0.15).w,
      padding:  EdgeInsets.symmetric(vertical: 10.h),
      child: ListView.builder(

        itemCount:  categoryList.length,
        itemBuilder: (context, index) {
          final category = categoryList[index];
          return Padding(
            padding:  EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
            child: CategoryItemWidget(
              isSelected: index == selectedIndex,
              // onTap: () {
              //   print('maruf:${categoryList[index].categoryName}');
              //   setState(()
              //   {
              //     selectedIndex = index;
              //     String? selectedCategory =   categoryList[index].categoryName;
              //
              //      if (selectedCategory != null) {
              //     context.read<ItemShowBloc>().add(
              //       CategorySearchingEvent(
              //         allSettings: widget.allSettings,
              //         searchItem:selectedCategory.toString()
              //       ),
              //     );}
              //     }
              //
              //   );
              // },

              onTap: () {
                setState(() {
                  if (selectedIndex == index) {
                    // Deselect category
                    selectedIndex = -1;
                    context.read<ItemShowBloc>().add(
                      CategorySearchingEvent(
                        allSettings: widget.allSettings,
                        searchItem: '', // empty triggers all items
                      ),
                    );
                  } else {
                    // Select new category
                    selectedIndex = index;
                    String? selectedCategory = categoryList[index].categoryName;

                    if (selectedCategory != null) {
                      context.read<ItemShowBloc>().add(
                        CategorySearchingEvent(
                          allSettings: widget.allSettings,
                          searchItem: selectedCategory,
                        ),
                      );
                    }
                  }
                });
              },

              categoryName: category.categoryName ?? '',
              imageUrl: category.imageUrl.toString() ,
            ),
          );
        },
      ),
    );
  }
}
