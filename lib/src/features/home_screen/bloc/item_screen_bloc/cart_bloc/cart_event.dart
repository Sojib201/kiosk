// cart_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItem {
  final String title;
  final double price;
  final int quantity;

  CartItem({required this.title, required this.price, this.quantity = 1});
}

abstract class CartEvent {}

class AddToCart extends CartEvent {
  final CartItem item;

  AddToCart(this.item);
}

class ClearCart extends CartEvent {}

class CartState {
  final List<CartItem> items;

  CartState(this.items);

  double get totalPrice =>
      items.fold(0, (sum, item) => sum + (item.price * item.quantity));

  int get totalCount =>
      items.fold(0, (sum, item) => sum + item.quantity);
}

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState([])) {
    on<AddToCart>((event, emit) {
      final updatedItems = List<CartItem>.from(state.items)..add(event.item);
      emit(CartState(updatedItems));
    });

    on<ClearCart>((event, emit) => emit(CartState([])));
  }
}
