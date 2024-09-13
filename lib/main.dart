import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/constant/AppThemeData.dart';
import 'routes.dart';
import 'view/screens/Search_Screen.dart';

late final SharedPreferences? sharedPref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  // await initServices();
  // لتقيد عرض التطبيق بشكل ثابت في وضع الشاشة العمودي فقط
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SearchScreen(),
        // initialRoute: AppRoutes.onBoarding,
        theme: AppThemeData(),
        getPages: getPages,
      ),
    );
  }
}
