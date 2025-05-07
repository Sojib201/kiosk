import 'package:flutter_bloc/flutter_bloc.dart';
import 'qty_inc_dec_event.dart';
import 'qty_inc_dec_state.dart';

class QtyIncDecBloc extends Bloc<QtyIncDecEvent, QtyIncDecState> {
  QtyIncDecBloc() : super(const QtyIncDecStateResult(qty: 1)) {
    on<QtyIncDecPerform>((event, emit) {
      emit(QtyIncDecStateResult(qty: event.qty));
    });
  }
}
