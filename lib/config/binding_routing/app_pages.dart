import 'package:get/get.dart';
import 'package:xpk/utils/imports/app_imports.dart';

class AppPages {
  AppPages._();

  static const initialRoute = AppRoutes.splash;

  static final routes = [
    GetPage(name: AppRoutes.splash, page: () => const SplashScreen()),
    GetPage(
      name: AppRoutes.getStart, page: () => const GetStart(),
      // transition: Transition.upToDown, // Define transition here
      // transitionDuration: Duration(seconds: 2),
    ),
    GetPage(name: AppRoutes.login, page: () => LoginScreen()),
    GetPage(name: AppRoutes.signup, page: () => SignupScreen()),
    GetPage(name: AppRoutes.signupEmailOtp, page: () => SignupEmailOtp()),
    GetPage(
        name: AppRoutes.forgetPasswordScreen,
        page: () => ForgetPasswordScreen()),
    GetPage(name: AppRoutes.home, page: () => HomeScreen()),
    GetPage(name: AppRoutes.navigateScreen, page: () => NavigationScreen()),
    GetPage(name: AppRoutes.detailScreen, page: () => DetailScreen()),

  ];
}
