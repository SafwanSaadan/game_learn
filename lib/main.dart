// import 'package:flutter/material.dart';

// import 'view/screens/DragDropGame.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Drag Drop Game',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const DragDropGame(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/constant/AppThemeData.dart';
import 'routes.dart';
import 'view/screens/Game/Memory_Game_Screen.dart';
import 'view/screens/Start_Screen.dart';

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
        home: StartScreen(),
        // initialRoute: AppRoutes.onBoarding,
        theme: AppThemeData(),
        getPages: getPages,
      ),
    );
  }
}
