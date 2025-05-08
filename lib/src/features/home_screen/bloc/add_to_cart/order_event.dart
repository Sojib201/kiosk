part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class AddOrderItem extends OrderEvent {
  final Map<String, dynamic> item;

  const AddOrderItem(this.item);

  @override
  List<Object> get props => [item];
}
class RefreshEvent extends OrderEvent {


  const RefreshEvent();

  @override
  List<Object> get props => [];
}

class CalulationEvent extends OrderEvent {
  const CalulationEvent();
}

// class ItemEditEvent extends OrderEvent {
//   List<OrderItem> orderedItems;
//   ItemEditEvent({required this.orderedItems});

//   @override
//   List<Object> get props => [orderedItems];
// }
