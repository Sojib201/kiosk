import 'dart:developer';



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiosk/src/core/constants/hive_constants.dart';
import 'package:kiosk/src/core/shared/common/common_function.dart';
import 'package:kiosk/src/data/datasources/local/local_data_source.dart';
import 'package:kiosk/src/data/datasources/remote/remote_data_source.dart';
import 'package:kiosk/src/features/registration_screen/bloc/registration_event.dart';
import 'package:kiosk/src/features/registration_screen/bloc/registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationInitial()) {
    on<RegistrationPerform>((event, emit) async {
      emit(RegistrationLoading());
      if (await CommonFunction().hasInternetConnection()) {
        await GetDataFromApi().getDMpath(event.cid);
        try {
          Map<String, dynamic> data = await GetDataFromApi().deviceSetUp({
            "cid": event.cid,
            "branch_id": event.branchId,
            // "user_id": event.userID,
            "device_id": event.deviceId,
            "device_name": event.deviceName,
            "device_type": event.deviceType,
            "os_version": event.osVersion,
            "app_version": event.appVersion,
            "ip_address": event.ipAddress,
            "mac_address": event.macAddress,
            "device_token": event.deviceToken
          });
          if (data['status'] == "Success") {
            await HiveOperation().addrestData(event.cid, HiveBoxKeys.cid);
            await HiveOperation().addrestData(event.branchId, HiveBoxKeys.branchID);
            await HiveOperation().addrestData(event.deviceId, HiveBoxKeys.deviceId);
            await HiveOperation().addrestData(true, HiveBoxKeys.isDeviceSetUP);
            emit(RegistrationSuccess());
          } else {
            if(data['message'].toString()=="Device already exists")
            {
              log("device exists and data saved to hive",name: "device exists");
              await HiveOperation().addrestData(event.cid, HiveBoxKeys.cid);
              await HiveOperation().addrestData(event.branchId, HiveBoxKeys.branchID);
              await HiveOperation().addrestData(event.deviceId, HiveBoxKeys.deviceId);
              await HiveOperation().addrestData(true, HiveBoxKeys.isDeviceSetUP);
            }

            emit(RegistrationFailure(data['message']));
          }
        } catch (e) {
          emit(RegistrationFailure("Registration Failed"));
        }
      } else {
        CommonFunction().showmessgae("No internet connection", false);
        emit(RegistrationFailure("No internet connection"));
      }
    });
  }
}
