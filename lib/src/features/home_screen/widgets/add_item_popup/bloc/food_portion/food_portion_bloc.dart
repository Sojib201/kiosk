import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../data/models/settings_mode.dart';
import 'food_portion_event.dart';
import 'food_portion_state.dart';

class FoodPortionSizeBloc extends Bloc<FoodPortionSizeEvent, FoodPortionSizeState> {
  ItemList? itemList;
  String foodFinalPrice = "";

  FoodPortionSizeBloc() : super(Initial()) {
    on<GetInitEvent>((event, emit) {
      itemList = event.itemList;

      itemList!.foodPortions!.isNotEmpty ? foodFinalPrice = itemList!.foodPortions![0].portionPrice.toString() : foodFinalPrice = itemList!.unitPrice.toString();

      emit(InitState(item: itemList!, selectedIndex: 0, finalFoodPrice: foodFinalPrice));
    });

    on<SelectPortionEvent>((event, emit) {
      itemList!.foodPortions!.isNotEmpty ? foodFinalPrice = itemList!.foodPortions![event.selectIndex].portionPrice.toString() : foodFinalPrice = itemList!.unitPrice.toString();

      emit(InitState(item: itemList!, selectedIndex: event.selectIndex, finalFoodPrice: foodFinalPrice));
    });
  }
}
