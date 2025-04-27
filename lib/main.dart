import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'home_page.dart';
import 'kiosk_home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(

     // designSize: const Size(360, 690),
      //designSize: const Size(800, 1280),
      //designSize: _getDesignSize(),
      designSize: isTablet() ? const Size(800, 1280) : const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        //home: const HomePage(),
        home: const FoodKioskScreen(),
      ),
    );


  }
  // Size _getDesignSize() {
  //
  //   final deviceWidth = WidgetsBinding.instance.window.physicalSize.width / WidgetsBinding.instance.window.devicePixelRatio;
  //   if (deviceWidth > 600) {
  //     return const Size(800, 1280);
  //   } else {
  //     return const Size(360, 690);
  //   }
  // }

}
bool isTablet() {
  final deviceWidth = WidgetsBinding.instance.window.physicalSize.width /
      WidgetsBinding.instance.window.devicePixelRatio;
  return deviceWidth > 600;
}
