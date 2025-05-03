// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../data/models/settings_mode.dart';
// import 'search_event.dart';
// import 'search_state.dart';
//
// class SearchBloc extends Bloc<SearchEvent, SearchState> {
//   List<ItemList> allItems = [];
//
//   SearchBloc() : super(SearchInitial()) {
//     on<LoadItemsEvent>((event, emit) {
//       allItems = event.items;
//       emit(SearchLoaded(allItems));
//     });
//
//     on<SearchItemsEvent>((event, emit) {
//       emit(SearchLoading());
//
//       final query = event.query.toLowerCase();
//       final filteredItems = allItems.where((item) {
//         final nameMatch = item.foodName?.toLowerCase().contains(query) ?? false;
//         final categoryMatch = item.category?.any((cat) => cat.toLowerCase().contains(query)) ?? false;
//         final tagsMatch = item.tags?.any((tag) => tag.toLowerCase().contains(query)) ?? false;
//
//         return nameMatch || categoryMatch || tagsMatch;
//       }).toList();
//
//       emit(SearchLoaded(filteredItems));
//     });
//   }
// }
