import 'package:flutter/material.dart';
import 'package:toyota/pages/auth/login_page.dart';
import 'package:toyota/pages/auth/password_change.dart';
import 'package:toyota/pages/auth/recovery_page.dart';
import 'package:toyota/pages/auth/register_page.dart';
import 'package:toyota/pages/booking/booking_order_page.dart';
import 'package:toyota/pages/booking/booking_page.dart';
import 'package:toyota/pages/booking/car_select_page.dart';
import 'package:toyota/pages/booking/history_page.dart';
import 'package:toyota/pages/car/car_dealers.dart';
import 'package:toyota/pages/car/car_page.dart';
import 'package:toyota/pages/car/car_categories.dart';
import 'package:toyota/pages/car/car_parts.dart';
import 'package:toyota/pages/car/dealer_page.dart';
import 'package:toyota/pages/car/new_cars.dart';
import 'package:toyota/pages/detail/detail_page.dart';
import 'package:toyota/pages/menu/contact.dart';
import 'package:toyota/pages/menu/qa_page.dart';
import 'package:toyota/pages/profile/profile_edit.dart';
import 'package:toyota/shared/main_scaffold.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  MainScaffold.routeName: (context) => MainScaffold(),
  LoginPage.routeName: (context) => LoginPage(),
  RegisterPage.routeName: (context) => RegisterPage(),
  DetailPage.routeName: (context) => DetailPage(),
  PasswordChange.routeName: (context) => PasswordChange(),
  CarSelectPage.routeName: (context) => CarSelectPage(),
  BookingPage.routeName: (context) => BookingPage(),
  BookingOrderPage.routeName: (context) => BookingOrderPage(),
  HistoryPage.routeName: (context) => HistoryPage(),
  NewCars.routeName: (context) => NewCars(),
  CarPage.routeName: (context) => CarPage(),
  CarDealers.routeName: (context) => CarDealers(),
  CarCategories.routeName: (context) => CarCategories(),
  CarParts.routeName: (context) => CarParts(),
  ProfileEdit.routeName: (context) => ProfileEdit(),
  RecoveryPage.routeName: (context) => RecoveryPage(),
  DealerPage.routeName: (context) => DealerPage(),
  QaPage.routeName: (context) => QaPage(),
  Contact.routeName: (context) => Contact(),
};
