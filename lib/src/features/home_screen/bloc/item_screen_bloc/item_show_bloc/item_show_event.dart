import 'package:equatable/equatable.dart';

import '../../../../../data/models/settings_mode.dart';

abstract class ItemShowEvent extends Equatable {
  const ItemShowEvent();

  @override
  List<Object> get props => [];
}

final class SearchingEvent extends ItemShowEvent{
  // final AllSettings allSettings;
  final List<ItemList> itemList;
  final String searchQuery;
  const SearchingEvent({required this.itemList,required this.searchQuery});
}

final class TagSearchingEvent extends ItemShowEvent {
  final List<String> selectedTags;
  //final AllSettings allSettings;
  final List<ItemList> itemList;

  const TagSearchingEvent({required this.selectedTags, required this.itemList});

  @override
  List<Object> get props => [selectedTags, itemList];
}

final class CategorySearchingEvent extends ItemShowEvent {
  final AllSettings allSettings;
  //final List<ItemList> itemList;
  final String searchItem;
  const CategorySearchingEvent({ required this.searchItem, required this.allSettings});
}

final class FilterItemEvent extends ItemShowEvent{
  final AllSettings allSettings;
  final String selectedCategory;
  final List<String> selectedTags;
  final String searchQuery;
  const FilterItemEvent({required this.allSettings,required this.searchQuery, required this.selectedTags, required this.selectedCategory});

  @override
  List<Object> get props => [allSettings,selectedCategory,selectedTags,searchQuery];

}
