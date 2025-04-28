import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiosk/src/core/constants/const_string.dart';
import 'package:kiosk/src/core/constants/hive_constants.dart';import 'package:kiosk/src/core/utils/color_utils.dart';
import 'package:kiosk/src/data/datasources/local/local_data_source.dart';
import 'package:kiosk/src/features/log_in_screen/login_screen.dart';

import 'bloc/appdware_bloc.dart';




// ignore: must_be_immutable
class AppDrawer extends StatefulWidget {
  final GlobalKey<ScaffoldState> drawerKey ;
  String title;
  AppDrawer({required this.title, required this.drawerKey});
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {

  @override
  void initState() {
    super.initState();
    context.read<AppdwareBloc>().add(LoaddedUserInfoEvent());
  }

  // void _getInfo() async {
  //   // Get device id
  //   String? result = await PlatformDeviceId.getDeviceId;
  //   setState(() {
  //     deviceId = result!;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: Drawer(
        elevation: 10,
        child: Container(
          color: ColorUtils.color1,
          child: BlocBuilder<AppdwareBloc, AppdwareState>(
            builder: (context, state) {
              if (state is AppdwareLoadedState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(top: 80.h,left: 40.w,right: 40.w,bottom: 40.h),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors:[ColorUtils.backGroundColor,ColorUtils.greenColor.withOpacity(0.8)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.only(
                         bottomLeft: Radius.circular(65.r),
                          bottomRight: Radius.circular(65.r),
                        ),

                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 65.0,
                              backgroundColor: ColorUtils.color1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(ImagerUrl.logo),
                              ),
                            ),
                          ),

                          SizedBox(height: 10),

                          Text(
                            state.userInfo.restaurantInfo!.companyName!,
                            style:  TextStyle(fontSize: 22.sp, color: ColorUtils.color1,fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5.0),

                          Text(
                            'User Name: ${state.userInfo.userInfo!.firstName! + state.userInfo.userInfo!.lastName!}',
                            style:  TextStyle(fontSize: 17.sp, color: ColorUtils.color1),
                          ),


                        ],
                      ),
                    ),

                    Expanded(
                      child: SingleChildScrollView(
                        padding:  EdgeInsets.all(30.w),
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children:[

                            ListTile(
                                leading: const Icon(
                                  Icons.sync,
                                  color: Colors.black,
                                ),
                                title: const Text(
                                  'sync',
                                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                                ),
                                trailing: Icon(Icons.arrow_forward_ios, size: 16, color: ColorUtils.black),
                                onTap: () async { widget.drawerKey.currentState?.closeDrawer();

                                }),
                            ListTile(
                                leading: const Icon(
                                  Icons.exit_to_app,
                                  color: Colors.black,
                                ),
                                title: const Text(
                                  'logout',
                                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                                ),
                                trailing: Icon(Icons.arrow_forward_ios, size: 16, color: ColorUtils.black),
                                onTap: () async { widget.drawerKey.currentState?.closeDrawer();
                                  await HiveOperation().addData(false, HiveBoxKeys.isLogIn);
                                 await HiveBoxes.allSettings.clear();
                                 await HiveBoxes.basicBox.clear();
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                                }),

                            SizedBox(height: 30.h,),

                            Padding(
                              padding:  EdgeInsets.only(left: 15.w),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  "App Version-$appVersion",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18.sp,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),

                  ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 80.h,left: 40.w,right: 40.w,bottom: 40.h),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors:[ColorUtils.secondaryColor,ColorUtils.greyColor.withOpacity(0.88)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(65.r),
                        bottomRight: Radius.circular(65.r),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                spreadRadius: 2,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 65.0,
                            backgroundColor: ColorUtils.primaryColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(ImagerUrl.logo),
                            ),
                          ),
                        ),

                        SizedBox(height: 10),

                        Text(
                          "restaurantName.toUpperCase()",
                          style:  TextStyle(fontSize: 16.0, color: ColorUtils.primaryColor),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          'Company Name: ',
                          style:  TextStyle(fontSize: 16.0, color: ColorUtils.primaryColor),
                        ),
                        // alignment: const Alignment(0.0, 0.0),
                        const SizedBox(height: 5.0),
                        Text(
                          'Branch Name: ',
                          style: TextStyle(fontSize: 16.0, color:ColorUtils.primaryColor),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          '${"Till Name"}: ',
                          style: TextStyle(fontSize: 16.0, color: ColorUtils.primaryColor),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      padding:  EdgeInsets.all(30.w),
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children:[
                          ListTile(
                              leading: const Icon(
                                Icons.home,
                                color: Colors.white,
                              ),
                              title: const Text(
                                'home',
                                style: TextStyle(fontSize: 16.0, color: Color(0xFFFFFFFF)),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios, size: 16, color: ColorUtils.black),
                              onTap: () async {
                                widget.drawerKey.currentState?.closeDrawer();
                              }),

                          ListTile(
                              leading: const Icon(
                                Icons.sync,
                                color: Colors.white,
                              ),
                              title: const Text(
                                'sync',
                                style: TextStyle(fontSize: 16.0, color: Color(0xFFFFFFFF)),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios, size: 16, color: ColorUtils.black),
                              onTap: () async {
                                widget.drawerKey.currentState?.closeDrawer();
                              }),
                          ListTile(
                              leading: const Icon(
                                Icons.exit_to_app,
                                color: Colors.white,
                              ),
                              title: const Text(
                                'logout',
                                style: TextStyle(fontSize: 16.0, color: Color(0xFFFFFFFF)),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios, size: 16, color: ColorUtils.black),
                              onTap: () async { widget.drawerKey.currentState?.closeDrawer();}),
                          // const Divider(
                          //   height: 5.0,
                          // ),
                          Center(child: Text("App Version-$appVersion",style: TextStyle(color: Colors.black),))
                        ],
                      ),
                    ),
                  ),

                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
