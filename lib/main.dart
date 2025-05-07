import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:kiosk/src/core/constants/hive_constants.dart';
import 'package:kiosk/src/features/home_screen/app_drawer/bloc/appdware_bloc.dart';
import 'package:kiosk/src/features/home_screen/bloc/item_screen_bloc/cart_bloc/cart_event.dart';
import 'package:kiosk/src/features/home_screen/bloc/item_screen_bloc/item_screen_bloc.dart';
import 'package:kiosk/src/features/home_screen/bloc/item_screen_bloc/item_show_bloc/item_show_bloc.dart';
import 'package:kiosk/src/features/home_screen/widgets/add_item_popup/bloc/food_portion/food_portion_bloc.dart';
import 'package:kiosk/src/features/home_screen/widgets/add_item_popup/bloc/qty_inc_dec/qty_inc_dec_bloc.dart';
import 'package:kiosk/src/features/home_screen/widgets/catagory/bloc/category_bloc.dart';
import 'package:kiosk/src/features/log_in_screen/bloc/login_bloc.dart';
import 'package:kiosk/src/features/registration_screen/bloc/registration_bloc.dart';
import 'package:kiosk/src/features/splash_screen.dart';



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
        BlocProvider(
          create: (context) => CategoryBloc(),
        ),
        BlocProvider(
          create: (context) => ItemShowBloc(),
        ),
        BlocProvider(
          create: (context) => FoodPortionSizeBloc(),
        ),
        BlocProvider(
          create: (context) => QtyIncDecBloc(),
        ),
        BlocProvider(
          create: (context)=>CartBloc(),
        )
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
           //home: const KioskHomeScreen(),
          //home: LoginScreen()
          home: SplashScreen(),
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
