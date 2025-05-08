part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderItemShowState extends OrderState {
  final List<OrderDetail> items;
  String total = '0';
  String discount = '0';
  String tips = '0';
  String vat = '0';
  String subTotal = '0';
  String serviceExpense = '0';

  OrderItemShowState(this.items, {required this.total, required this.discount, required this.tips, required this.vat, required this.subTotal, required this.serviceExpense});

  @override
  List<Object> get props => [items, total, discount, tips, vat];
}

// class OrderItemEditState extends OrderState {
//   final List<OrderItem> items;
//   String total = '0';
//   String discount = '0';
//   String tips = '0';
//   String vat = '0';
//   String subTotal = '0';

//   OrderItemEditState(this.items, {required this.total, required this.discount, required this.tips, required this.vat, required this.subTotal});

//   @override
//   List<Object> get props => [items, total, discount, tips, vat];
// }

// class CalulationState extends OrderState {
//   String total = '0';
//   String discount = '0';
//   String tips = '0';
//   String vat = '0';

//   CalulationState({required this.total, required this.discount, required this.tips, required this.vat});

//   @override
//   List<Object> get props => [total, discount, tips, vat];
// }
