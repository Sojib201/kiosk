import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:kiosk/src/core/constants/hive_constants.dart';
import 'package:kiosk/src/features/item_screen/app_drawer/bloc/appdware_bloc.dart';
import 'package:kiosk/src/features/item_screen/bloc/item_screen_bloc.dart';
import 'package:kiosk/src/features/log_in_screen/bloc/login_bloc.dart';
import 'package:kiosk/src/features/log_in_screen/login_screen.dart';
import 'package:kiosk/src/features/registration_screen/bloc/registration_bloc.dart';



Future<void> main() async {

  await Hive.initFlutter();
  await OpenBoxes().openBox();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:[
        BlocProvider(
          create: (context) => RegistrationBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => AppdwareBloc(),
        ),
        BlocProvider(
          create: (context) => ItemScreenBloc(),
        ),
      ],
      child: ScreenUtilInit(
      
       // designSize: const Size(360, 690),
        designSize: const Size(800, 1280),
        //designSize: _getDesignSize(),
        //designSize: isTablet() ? const Size(800, 1280) : const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Kiosk',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            useMaterial3: true,
          ),
          //home: const HomePage(),
          //home: const FoodKioskScreen(),
          home: const LoginScreen(),
        ),
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
// bool isTablet() {
//   final deviceWidth = WidgetsBinding.instance.window.physicalSize.width /
//       WidgetsBinding.instance.window.devicePixelRatio;
//   return deviceWidth > 600;
// }
