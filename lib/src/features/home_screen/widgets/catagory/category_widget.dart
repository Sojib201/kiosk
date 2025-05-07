import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiosk/src/core/utils/color_utils.dart';
import 'package:kiosk/src/data/models/settings_mode.dart';
import '../category_item_widget.dart';


class CategoryWidget extends StatefulWidget {
  AllSettings allSettings;
  final Function(String) selectedCategory;

  CategoryWidget({
    super.key,
    required this.allSettings, required this.selectedCategory,
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
          print('image: ${categoryList[index].imageUrl.toString() }');
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
                  // selectedIndex = index;
                  // String? selectedCategory = categoryList[index].categoryName;
                  // widget.selectedCategory(selectedCategory??'');
                  if (selectedIndex == index) {

                    selectedIndex = -1;
                    // context.read<ItemShowBloc>().add(
                    //   CategorySearchingEvent(
                    //     allSettings: widget.allSettings,
                    //     searchItem: '', // empty triggers all items
                    //   ),
                    // );
                    widget.selectedCategory('');
                  } else {

                    // selectedIndex = index;
                    // String? selectedCategory = categoryList[index].categoryName;
                    //
                    // if (selectedCategory != null) {
                    //   context.read<ItemShowBloc>().add(
                    //     CategorySearchingEvent(
                    //       allSettings: widget.allSettings,
                    //       searchItem: selectedCategory,
                    //     ),
                    //   );
                    // }

                    selectedIndex = index;
                    String? selectedCategory = categoryList[index].categoryName;
                    widget.selectedCategory(selectedCategory??'');
                  }
                });
              },

              categoryName: category.categoryName ?? '',
              // imageUrl: category.imageUrl??'' ,
              imageUrl: category.imageUrl!.isEmpty? "": category.categoryName??'',
            ),
          );
        },
      ),
    );
  }
}
