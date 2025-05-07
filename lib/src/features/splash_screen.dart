import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiosk/src/features/registration_screen/device_registration_screen.dart';
import '../core/constants/const_string.dart';
import '../core/constants/hive_constants.dart';
import '../data/datasources/local/local_data_source.dart';
import 'home_screen/kiosk_home_screen.dart';
import 'log_in_screen/login_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  bool lastBluetoothDeviceConnected = false;
  bool lastWifiDeviceConnected = false;
  String lastWifiDeviceIp = "";
  String lastBluetoothDeviceName = "";
  String lastBluetoothDeviceAddress = "";


  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();


    Timer(const Duration(seconds: 3), () async {
      if (await HiveOperation().getrestData(HiveBoxKeys.isDeviceSetUP) == true) {
        if (await HiveOperation().getData(HiveBoxKeys.isLogIn) == true) {
          log(await HiveOperation().getData(HiveBoxKeys.isLogIn).toString(), name: 'ruesssssssssssssss');
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const KioskHomeScreen()), (route) => false);
        } else {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false);
        }
      } else {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const RegistrationScreen()), (route) => false);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Image.asset(
            ImagerUrl.logo,
            width: 700.w,
            height: 700.h,
          ),
        ),
      ),
    );
  }

}
