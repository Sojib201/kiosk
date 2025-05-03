part of 'item_screen_bloc.dart';

sealed class ItemScreenEvent extends Equatable {
  const ItemScreenEvent();

  @override
  List<Object> get props => [];
}

final class SearchItemEvent extends ItemScreenEvent {
  final List<ItemList> items;
  final String searchItem;
  const SearchItemEvent(this.searchItem, this.items);

  @override
  List<Object> get props => [searchItem];
}
final class OrderSubmitEvent extends ItemScreenEvent {
  final Map<String,dynamic> body;
  final bool isCancel;
  final AllSettings allSettings;
  const OrderSubmitEvent( {required this.body,required this.isCancel , required this.allSettings,});

  @override
  List<Object> get props => [body];

}


final class SearchingEvent extends ItemScreenEvent {
  final List<ItemList> itemList;
  final String searchQuery;


  const SearchingEvent(this.searchQuery, this.itemList);

  @override
  List<Object> get props => [searchQuery, itemList];
}

final class GetAllResturantData extends ItemScreenEvent {
  final bool isOnlineData;
  const GetAllResturantData( this.isOnlineData);
}



final class SearchingTag extends ItemScreenEvent {
  final List<String> selectedTags;
  final List<ItemList> itemList;

  const SearchingTag(this.selectedTags, this.itemList);

  @override
  List<Object> get props => [selectedTags, itemList];
}

