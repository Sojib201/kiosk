import 'package:equatable/equatable.dart';

import '../../../../../../data/models/settings_mode.dart';


abstract class FoodPortionSizeState extends Equatable {}

class Initial extends FoodPortionSizeState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class InitState extends FoodPortionSizeState {
  final ItemList item;
  final int selectedIndex;
  final String finalFoodPrice;

  InitState({required this.item, required this.selectedIndex, required this.finalFoodPrice});
  @override
  // TODO: implement props
  List<Object?> get props => [item, selectedIndex, finalFoodPrice];
}
