import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kiosk/src/data/models/settings_mode.dart';

part 'category_event.dart';

part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  bool isFood = true;
  bool isCat = true;

  CategoryBloc() : super(CategoryInitial()) {
    on<CategoryLoadedEvent>((event, emit) {
      emit(CategoryLoading());

      // isFood = event.isFood ?? isFood;
      // isCat = event.isCat ?? isCat;
      //
      // log("isFood: $isFood, isCat: $isCat");
      List<CategoryList> categoryList = [];
      if (event.allSettings.category != null) {
        for (int i = 0; i < event.allSettings.category!.length; i++) {
          if (event.allSettings.category![i].categoryList != null) {
            categoryList.addAll(event.allSettings.category![i].categoryList!);
          }
        }
      }
      emit(CategoryLoaded(
        categoryElement: categoryList,

      ));

      // if (isCat && isFood) {
      //   categoryList = event.allSettings.category![0].categoryList!;
      // }
      //
      //
      // if (isCat && !isFood)
      //   {
      //     categoryList.addAll(event.allSettings.category?[1].categoryList ?? []);
      //   }

      //   if (isCat && isFood) {
      //     emit(CategoryLoaded(
      //       categoryElement: event.allSettings.category![0].categoryList!,
      //       isCat: true,
      //     ));
      //   } else if (isCat && !isFood) {
      //     emit(CategoryLoaded(
      //       categoryElement: event.allSettings.category?[1].categoryList ?? [],
      //       isCat: true,
      //     ));
      //   }
      //   else {
      //     emit(CategoryInitial());
      //   }
      // });
    });
  }
}
