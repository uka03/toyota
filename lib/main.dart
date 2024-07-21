import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toyota/pages/auth/provider/auth_provider.dart';
import 'package:toyota/pages/booking/provider/booking_provider.dart';
import 'package:toyota/pages/car/provider/car_provider.dart';
import 'package:toyota/pages/home/provider/home_provider.dart';
import 'package:toyota/pages/profile/provider/profile_provider.dart';
import 'package:toyota/routes/routes.dart';
import 'package:toyota/shared/provider/navigator_provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:toyota/utils/custom_animation.dart';

void main() {
  configLoading();
  runApp(const MyApp());
}

void configLoading() {
  EasyLoading.instance
    ..maskType = EasyLoadingMaskType.custom
    ..displayDuration = const Duration(milliseconds: 2000)
    ..loadingStyle = EasyLoadingStyle.light
    ..indicatorSize = 40
    ..textColor = Colors.white
    ..backgroundColor = Colors.transparent
    ..indicatorColor = Colors.white
    ..maskColor = Colors.transparent
    ..userInteractions = false
    ..dismissOnTap = false
    ..animationStyle = EasyLoadingAnimationStyle.custom
    ..customAnimation = CustomAnimation();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => NavigatorProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => CarProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Toyota - TavanBogd',
        initialRoute: "/login",
        theme: ThemeData(
          useMaterial3: true,
        ),
        routes: routes,
        builder: EasyLoading.init(),
      ),
    );
  }
}
