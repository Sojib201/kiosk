import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../data/models/settings_mode.dart';
import 'item_show_event.dart';
import 'item_show_state.dart';

class ItemShowBloc extends Bloc<ItemShowEvent, ItemShowState> {
  AllSettings? allSettings;
  ItemShowBloc() : super(ItemInitial()) {
    on<CategorySearchingEvent>((event, emit) async {
      emit(ItemLoadingState());
      final fullItemList = event.allSettings.itemList??[] ;
      if (fullItemList.isNotEmpty) {
        if (event.searchItem.isEmpty) {
          emit(ItemfromCategory(items: fullItemList, title: "All Items"));
        } else {
          final List<ItemList> items = event.allSettings.itemList!.where((element) =>
          element.categories!.contains(event.searchItem) || element.cuisines!.contains(event.searchItem)).toList();

          emit(ItemfromCategory(items: items, title: event.searchItem));
        }
      } else {
        emit(ItemInitial());
      }
    });

    on<TagSearchingEvent>((event, emit) async {
      emit(ItemLoadingState());
      final fullItemList = event.itemList ?? [];
      if(fullItemList.isNotEmpty){
        if(event.selectedTags.isEmpty){
          emit(ItemTagSearchResult(filteredItems: fullItemList,title:'All Items'));
        }
        final queries = event.selectedTags.map((e) => e.toLowerCase()).toList();
        final filteredItems = event.itemList.where((element) {
          final itemTags = element.tags?.map((e) => e.toLowerCase()) ?? [];
          return queries.any((query) => itemTags.contains(query));
        }).toList();
        emit(ItemTagSearchResult(filteredItems: filteredItems,title: event.selectedTags.toString()));
      }
      else {
        emit(ItemInitial());
      }

    });

    on<SearchingEvent>((event, emit) async {
      emit(ItemLoadingState());
      final fullItemList = event.itemList;
      print('itemlist:${fullItemList}');
      final query = event.searchQuery.trim().toLowerCase();
      if (query.isEmpty) {
        emit(ItemSearchResult(
          filteredItems: fullItemList,
          itemList: event.itemList,
          title: "All Items",
        ));
        return;
      }
      final filteredItems = fullItemList.where((element) {
        final nameMatch = element.foodName?.toLowerCase().contains(query) ?? false;
        return nameMatch;
      }).toList();
      emit(ItemSearchResult(
        filteredItems: filteredItems,
        itemList: event.itemList,
        title: query,
      ));
    });



     on<FilterItemEvent>((event, emit) async{
      List<ItemList> filterItemsList=[];
      emit(ItemLoadingState());
      print("category is : ${event.selectedCategory}");
      print("search is : ${event.searchQuery}");
      print("tags is : ${event.selectedTags.toString()}");

      if(event.selectedCategory.isNotEmpty || event.selectedCategory!=''){
        filterItemsList = event.allSettings.itemList!.where((element) =>
        element.categories!.contains(event.selectedCategory) || element.cuisines!.contains(event.selectedCategory)).toList();
      }
      else {
        filterItemsList=event.allSettings.itemList!;
      }
      if(event.selectedTags.isNotEmpty){
        final queries = event.selectedTags.map((e) => e.toLowerCase()).toList();
        final filterTagItemsList = filterItemsList.where((element) {
          final itemTags = element.tags?.map((e) => e.toLowerCase()) ?? [];
          return queries.any((query) => itemTags.contains(query));
        }).toList();

        filterItemsList=filterTagItemsList;

      }
   if(event.searchQuery.isNotEmpty|| event.searchQuery!=''||event.searchQuery=='null'){
     final query = event.searchQuery.trim().toLowerCase();
     final searchFilterItemList = filterItemsList.where((element) {
       final nameMatch = element.foodName?.toLowerCase().contains(query) ?? false;
       return nameMatch;
     }).toList();
     filterItemsList=searchFilterItemList;
   }
   emit(FilterItemState(items: filterItemsList));

    });


  }

}
