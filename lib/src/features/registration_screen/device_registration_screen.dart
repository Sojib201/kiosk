// ignore_for_file: deprecated_member_use

import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kiosk/src/features/log_in_screen/login_screen.dart';
import '../../core/shared/common/common_function.dart';
import '../../core/utils/color_utils.dart';
import 'bloc/registration_bloc.dart';
import 'bloc/registration_event.dart';
import 'bloc/registration_state.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool isLoading = false;
  TextEditingController cidController = TextEditingController();
  TextEditingController branchIdController = TextEditingController();
  // TextEditingController userIdController = TextEditingController();

  bool visiblePassword = true;

  String deviceId = '';
  String DeviceId = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _getDeviceInfo();
    // getDeviceAndroidInfo();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cidController.dispose();
    branchIdController.dispose();
  }

  bool isMasterDevice = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorUtils.primaryColor,
        resizeToAvoidBottomInset: true,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [

                Text(
                  'Device Registration',
                  style: TextStyle(fontSize: 45.sp,fontWeight: FontWeight.bold, color: Colors.deepOrange),
                ),
                SizedBox(height: 50.h),

                SizedBox(height: 30.h),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    onSubmitted: (value) {},
                    controller: cidController,
                    autofocus: true,
                    decoration: InputDecoration(
                      fillColor: ColorUtils.primaryColor,
                      enabled: true,
                      focusColor: ColorUtils.secondaryColor,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(),
                        borderRadius: BorderRadius.circular(28.r),
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(20, 10, 10, 30),
                      hintText: 'CID',
                      hintStyle: TextStyle(
                        color: ColorUtils.secondaryColor.withOpacity(0.7),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28.r),
                        borderSide: BorderSide(color: Colors.deepOrange, width: 4.w),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28.r),
                        borderSide: BorderSide(color: ColorUtils.secondaryColor, width: 2.w),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextField(
                    onSubmitted: (value) {},
                    controller: branchIdController,
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      fillColor: ColorUtils.primaryColor,
                      enabled: true,
                      focusColor: ColorUtils.secondaryColor,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28.r),
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(20, 10, 10, 30),
                      hintText: 'Branch ID',
                      hintStyle: TextStyle(
                        color: ColorUtils.secondaryColor.withOpacity(0.7),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28.r),
                        borderSide: BorderSide(color: Colors.deepOrange, width: 4.w),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28.r),
                        borderSide: BorderSide(color: ColorUtils.secondaryColor, width: 2.w),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 50.h,
                ),
                BlocConsumer<RegistrationBloc, RegistrationState>(
                  listener: (context, state) {
                    if (state is RegistrationSuccess) {
                      CommonFunction().showmessgae("Registration Success", true);
                     // context.pushReplace(const LoginScreen());
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return LoginScreen();
                      },));
                    } else if (state is RegistrationFailure) {
                      Fluttertoast.showToast(msg: state.errorMessage, backgroundColor: Colors.red);
                    }
                  },
                  builder: (context, state) {
                    if (state is RegistrationLoading) {
                      return const CircularProgressIndicator();
                    }
                    return InkWell(
                      onTap: () async {
                        log(await CommonFunction().getId() ?? '', name: "Device ID");
                        log(isMasterDevice ? "MASTER" : "CLIENT");
                        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
                        if (cidController.text != "" && branchIdController.text != "") {
                          context.read<RegistrationBloc>().add(
                                RegistrationPerform(
                                  cid: cidController.text,
                                  branchId: branchIdController.text,
                                  deviceId: await CommonFunction().getId() ?? '',
                                  // deviceId:  await CommonFunction().getDeviceAndroidInfo(),
                                  // userID: userIdController.text,
                                  deviceName: (await deviceInfo.androidInfo).brand.toString() + (await deviceInfo.androidInfo).model.toString(),
                                  appVersion: appVersion,
                                  deviceToken: (await deviceInfo.androidInfo).device.toString(),
                                  deviceType: "",
                                  ipAddress: "",
                                  macAddress: "",
                                  osVersion: "",
                                ),
                              );
                        } else {
                          CommonFunction().showmessgae("Please all Required Filled", false);
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3,
                        height: 65.h,
                        decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.circular(28.r),
                        ),
                        child: Center(
                          child: Text(
                            'Device Setup',
                            style: TextStyle(letterSpacing: 2.sp, fontSize: 27.sp, fontWeight: FontWeight.w500, color: ColorUtils.primaryColor),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 40.h,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {
                      //context.pushReplace(const LoginScreen());
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return LoginScreen();
                      },));
                    },
                    child: Text(
                      'Alreayd Registered ? Login',
                      style: TextStyle(
                        fontSize: 28.sp,
                        color: ColorUtils.secondaryColor,
                        decoration: TextDecoration.underline,
                        decorationColor: ColorUtils.secondaryColor,
                        decorationThickness: 2,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
