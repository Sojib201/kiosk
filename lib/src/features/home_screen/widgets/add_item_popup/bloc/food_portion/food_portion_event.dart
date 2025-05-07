import 'package:equatable/equatable.dart';

import '../../../../../../data/models/settings_mode.dart';

abstract class FoodPortionSizeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetInitEvent extends FoodPortionSizeEvent {
  final ItemList itemList;

  GetInitEvent({required this.itemList});

  @override
  List<Object?> get props => [itemList];
}

class SelectPortionEvent extends FoodPortionSizeEvent {
  final int selectIndex;
  final ItemList item;

  SelectPortionEvent({required this.selectIndex, required this.item});

  @override
  List<Object?> get props => [selectIndex, item];
}
