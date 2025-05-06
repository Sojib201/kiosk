import 'package:equatable/equatable.dart';
import 'package:kiosk/src/data/models/settings_mode.dart';

import '../../../../../data/models/user_model.dart';

abstract class ItemShowState extends Equatable{

}
final class ItemInitial extends ItemShowState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

final class ItemErrorState extends ItemShowState{
  final String errorMsg;
  ItemErrorState({required this.errorMsg});
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
final class ItemLoadingState extends ItemShowState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

final class ItemShowLoadedState extends ItemShowState{
  final List<ItemList> itemList;
  final String title;
  ItemShowLoadedState({required this.title, required this.itemList});
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

final class ItemTagSearchResult extends ItemShowState{
  final List<ItemList> filteredItems;
  final String title;
  ItemTagSearchResult({ required this.filteredItems,required this.title});
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

final class ItemSearchResult extends ItemShowState {
  final List<ItemList> filteredItems;
  // final AllSettings allSettings;
  final List<ItemList> itemList;
  final String title;
   ItemSearchResult({required this.title, required this.filteredItems,  required this.itemList,});

  @override
  List<Object> get props => [filteredItems];
}

final class ItemfromCategory extends ItemShowState {
  final List<ItemList> items;
  final String title;
  ItemfromCategory({required this.items,required this.title,});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class FilterItemState extends ItemShowState {
  final List<ItemList> items;

  FilterItemState({required this.items,});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
