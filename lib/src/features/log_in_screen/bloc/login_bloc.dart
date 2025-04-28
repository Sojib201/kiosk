import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui' as img;


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;

import 'package:kiosk/src/core/constants/hive_constants.dart';
import 'package:kiosk/src/core/shared/common/common_function.dart';
import 'package:kiosk/src/data/datasources/local/local_data_source.dart';
import 'package:kiosk/src/data/datasources/remote/remote_data_source.dart';
import 'package:kiosk/src/data/models/user_model.dart';

import 'login_event.dart';
import 'login_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginPerform>((event, emit) async {
      emit(LoginLoading());
      if (await CommonFunction().hasInternetConnection()) {
        await GetDataFromApi().getDMpath(event.cid);

        User data = await GetDataFromApi().logIn({
          "cid": event.cid,
          "user_id": event.userId,
          "user_pass": event.password,
          "app_version": "2024",
          "device_id": HiveOperation().getData(HiveBoxKeys.deviceId) == null || HiveOperation().getData(HiveBoxKeys.deviceId) == "" ? await CommonFunction().getId() : HiveOperation().getData(HiveBoxKeys.deviceId),
        });

        if (data.status == "Success") {
          await HiveOperation().addData(data.restaurantInfo!.currencySymbol!, HiveBoxKeys.currency);
          log("login successfull");
          log(data.restaurantInfo!.logoUrl.toString(), name: "imageUrl");

          ///image from Network
          try{
            var response = await http.get(Uri.parse(data.restaurantInfo!.logoUrl.toString()));
            Uint8List bytesNetwork = response.bodyBytes;

            img.Image? originalImage = img.decodeImage(bytesNetwork);
            if (originalImage != null) {
              // Resize image (e.g., to 100x100)
              img.Image resizedImage = img.copyResize(originalImage, width: 200, height: 200);

              // Encode back to Uint8List
              Uint8List resizedBytes = Uint8List.fromList(img.encodePng(resizedImage));

              data.restaurantInfo!.resImageBytes = resizedBytes;
            }

          }
          catch(e){
                log("image can't converted into uint8List url is ${data.restaurantInfo!.logoUrl.toString()}");
          }


          //userInfo = data;
          await HiveOperation().addData(userToJson(data), HiveBoxKeys.userInfo);
          await HiveOperation().addrestData(data.restaurantInfo!.cid!, HiveBoxKeys.cid);
          await HiveOperation().addrestData(data.userInfo!.branchId!, HiveBoxKeys.branchID);
          await HiveOperation().addData(true, HiveBoxKeys.isLogIn);
          await HiveOperation().addrestData(true, HiveBoxKeys.isDeviceSetUP);
          await HiveOperation().addrestData( await CommonFunction().getId() ?? '', HiveBoxKeys.deviceId);
          print('aaaa');



          emit(LoginSuccess());
        } else {
          CommonFunction().showmessgae(data.message.toString(), false);
          emit(LoginFailure(data.message.toString()));
        }


      } else {
        CommonFunction().showmessgae("No internet connection", false);
        emit(LoginFailure("No internet connection"));
      }
    });
  }
}

