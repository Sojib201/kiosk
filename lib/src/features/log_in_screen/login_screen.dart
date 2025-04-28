// ignore_for_file: deprecated_member_use

import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiosk/src/core/shared/common/common_function.dart';
import 'package:kiosk/src/core/utils/color_utils.dart';

import 'package:kiosk/src/core/constants/hive_constants.dart';
import 'package:kiosk/src/data/datasources/local/local_data_source.dart';
import 'package:kiosk/src/data/datasources/remote/remote_data_source.dart';
import 'package:kiosk/src/features/registration_screen/device_registration_screen.dart';
import '../item_screen/item_home_screen.dart';
import 'bloc/login_bloc.dart';
import 'bloc/login_event.dart';
import 'bloc/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

const String appVersion = "20250426";

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  TextEditingController cidController = TextEditingController(text: HiveOperation().getData(HiveBoxKeys.cid) ?? "");
  TextEditingController userIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool visiblePassword = true;
  String selectedUser = '';
  List<String> branchUsers = [];
  // String? selectedUser;

  @override
  void initState() {
    super.initState();
    fetchBranchUsers();
    setdata();
  }

  setdata() {
    cidController.text = HiveOperation().getrestData(HiveBoxKeys.cid) == null || HiveOperation().getrestData(HiveBoxKeys.cid) == "" ? "" : HiveOperation().getrestData(HiveBoxKeys.cid);

    setState(() {});
  }

  Future<void> fetchBranchUsers() async {
    try {
      List<String> users = await GetDataFromApi().branchUserList();
      setState(() {
        branchUsers = users;
        if (branchUsers.isNotEmpty) {
          selectedUser = branchUsers.first;
        }
      });
    } catch (e) {
      print('Error fetching branch users: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    log("cid ${HiveOperation().getrestData(HiveBoxKeys.cid)}");
    log(((HiveOperation().getrestData(HiveBoxKeys.cid) != null).toString(), (HiveOperation().getrestData(HiveBoxKeys.cid) != "")).toString());
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorUtils.primaryColor,
        resizeToAvoidBottomInset: true,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Image.asset(
                //   ImagerUrl.logo,
                //   height: 600.h,
                //   width: 950.w,
                //   fit: BoxFit.contain,
                // ),
                // SizedBox(height: 80.h),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextField(
                    readOnly: HiveOperation().getrestData(HiveBoxKeys.cid) != "" ? true : false,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   'Select Branch User',
                    //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    // ),
                    SizedBox(height: 8),
                    branchUsers.isEmpty
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: TextField(
                              onSubmitted: (value) {},
                              controller: userIdController,
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
                                hintText: 'User ID',
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
                          )
                        : Container(
                            width: MediaQuery.of(context).size.width / 2,
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              border: Border.all(color: ColorUtils.secondaryColor,width: 2.w),
                              borderRadius: BorderRadius.circular(28.r),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: selectedUser,
                                isExpanded: true,
                                items: branchUsers.map((user) {
                                  return DropdownMenuItem<String>(
                                    value: user,
                                    child: Text(user),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedUser = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),
                  ],
                ),

                SizedBox(
                  height: 30.h,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextField(
                    onSubmitted: (value) {},
                    textInputAction: TextInputAction.done,
                    controller: passwordController,
                    autofocus: true,
                    obscureText: visiblePassword,
                    decoration: InputDecoration(
                      fillColor: ColorUtils.primaryColor,
                      enabled: true,
                      focusColor: ColorUtils.secondaryColor,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28.r),
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(20, 10, 10, 30),
                      hintText: 'Password',
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
                      suffixIcon: IconButton(
                        icon: visiblePassword
                            ? Icon(
                                Icons.visibility_off_outlined,
                                color: ColorUtils.secondaryColor.withOpacity(0.8),
                              )
                            : Icon(
                                Icons.remove_red_eye,
                                color: ColorUtils.secondaryColor.withOpacity(0.8),
                              ),
                        onPressed: () {
                          setState(() {
                            visiblePassword = !visiblePassword;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginSuccess) {
                      CommonFunction().showmessgae("LogIn Success", true);
                      //context.fadePushRemoveUntil(const HomeScreen());
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return FoodKioskScreen();
                      },));
                    } else if (state is LoginFailure) {

                    }
                  },
                  builder: (context, state) {
                    print('xxxx${state}');
                    if (state is LoginLoading) {
                      return const CircularProgressIndicator();
                    }

                    return InkWell(
                      onTap: () async {
                        if (passwordController.text != "") {
                          context.read<LoginBloc>().add(
                                LoginPerform(
                                  cid: HiveOperation().getrestData(HiveBoxKeys.cid) == null || HiveOperation().getrestData(HiveBoxKeys.cid) == "" ? cidController.text : HiveOperation().getrestData(HiveBoxKeys.cid),
                                  userId: selectedUser == "" ? userIdController.text : selectedUser,
                                  password: passwordController.text,
                                ),
                              );
                        } else {
                          CommonFunction().showmessgae("Please all Requierd Filled", false);
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3.8,
                        height: 70.h,
                        decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.circular(28.r),
                        ),
                        child: Center(
                          child: Text(
                            'Login',
                            style: TextStyle(
                                letterSpacing: 2.sp,
                                fontSize: 33.sp,
                                fontWeight: FontWeight.w500,
                                // color: passwordController.text.isEmpty
                                //     ? ColorUtils.primaryColor
                                //     : Colors.green
                                color: ColorUtils.primaryColor),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegistrationScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Device Setup',
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
