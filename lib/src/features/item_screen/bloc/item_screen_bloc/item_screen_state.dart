part of 'item_screen_bloc.dart';

sealed class ItemScreenState extends Equatable {
  const ItemScreenState();

  @override
  List<Object> get props => [];
}

final class ItemScreenInitial extends ItemScreenState {}

final class ItemLoadedSearched extends ItemScreenState {
  final List<ItemList> items;
  final String currencySymbol;
  const ItemLoadedSearched(this.items, this.currencySymbol);

  @override
  List<Object> get props => [items];
}

final class OrderSubmittedSuccessState extends ItemScreenState {
  final String message;

  const OrderSubmittedSuccessState(this.message);
  @override
  List<Object> get props => [message];
}

final class ItemSearchLoading extends ItemScreenState {}

final class SubmitLoading extends ItemScreenState {}
final class CancelOrderLoading extends ItemScreenState {}
final class ErrorState extends ItemScreenState {}

// final class ItemSearchResult extends ItemScreenState {
//   final List<ItemList> filteredItems;
//   final String currencySymbol;
//   final AllSettings allSettings;
//   final User userData;
//
//   const ItemSearchResult(this.filteredItems, this.currencySymbol, this.allSettings, this.userData);
//
//   @override
//   List<Object> get props => [filteredItems];
// }

final class ItemDataLoadedState extends ItemScreenState {

  final AllSettings allSettings;
  final User userData;


  ItemDataLoadedState({required this.allSettings, required this.userData,});
}
