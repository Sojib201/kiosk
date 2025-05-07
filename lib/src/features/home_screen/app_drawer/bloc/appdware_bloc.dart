import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kiosk/src/core/constants/hive_constants.dart';
import 'package:kiosk/src/data/datasources/local/local_data_source.dart';
import 'package:kiosk/src/data/models/user_model.dart';

part 'appdware_event.dart';
part 'appdware_state.dart';

class AppdwareBloc extends Bloc<AppdwareEvent, AppdwareState> {
  AppdwareBloc() : super(AppdwareInitial()) {
    on<LoaddedUserInfoEvent>((event, emit) async {
      User loginInfo = userFromJson(await HiveOperation().getData(HiveBoxKeys.userInfo));
      emit(AppdwareLoadedState(userInfo: loginInfo));
      // TODO: implement event handler
    });
  }
}
