import 'package:equatable/equatable.dart';

abstract class QtyIncDecEvent extends Equatable {
  const QtyIncDecEvent();

  @override
  List<Object?> get props => [];
}

class QtyIncDecPerform extends QtyIncDecEvent {
  final int qty;
  const QtyIncDecPerform({required this.qty});

  @override
  List<Object?> get props => [qty];
}
