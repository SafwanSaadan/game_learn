import 'package:get/get.dart';

import 'controller/middleware/OnBoardingMiddleware.dart';
import 'core/constant/AppRoutes.dart';
import 'view/screens/Category/numbers_Screen.dart';
import 'view/screens/Game/Calculation_game_Screen.dart';
import 'view/screens/Game/DragDropGame_Screen.dart';
import 'view/screens/Search_Screen.dart';
import 'view/screens/Start_Screen.dart';
import 'view/screens/onBoarding_Screen.dart';

// Map<String, Widget Function(BuildContext)> routes = {
//   AppRoutes.login: (context) => LoginScreen(),
// };

List<GetPage<dynamic>>? getPages = [
  GetPage(
      name: AppRoutes.onBoarding,
      page: () => const OnBoardingScreen(),
      middlewares: [OnBoardingMiddleware()]),
  // GetPage(name: AppRoutes.login, page: () => LoginScreen()),
  // GetPage(name: AppRoutes.signup, page: () => SignUp()),
  GetPage(name: AppRoutes.start, page: () => StartScreen()),
  GetPage(name: AppRoutes.dragDropGame, page: () => const DragDropGameScreen()),
  GetPage(name: AppRoutes.calcGame, page: () => const CalculationGameScreen()),
  GetPage(name: AppRoutes.search, page: () => const SearchScreen()),
  GetPage(name: AppRoutes.learn1, page: () => const LearnScreen1()),
  GetPage(name: AppRoutes.letters, page: () => const LearnScreen1()),
  GetPage(name: AppRoutes.numbers, page: () => const LearnScreen1()),
  GetPage(name: AppRoutes.colors, page: () => const LearnScreen1()),
  GetPage(name: AppRoutes.animals, page: () => const LearnScreen1()),
];
