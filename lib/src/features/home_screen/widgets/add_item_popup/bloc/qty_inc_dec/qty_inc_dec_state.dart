import 'package:equatable/equatable.dart';

abstract class QtyIncDecState extends Equatable {
  const QtyIncDecState();

  @override
  List<Object?> get props => [];
}

class QtyIncDecStateInitial extends QtyIncDecState {}

class QtyIncDecStateResult extends QtyIncDecState {
  final int qty;
  const QtyIncDecStateResult({required this.qty});

  @override
  List<Object?> get props => [qty];
}


