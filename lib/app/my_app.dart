import 'package:get/get.dart';
import 'package:xpk/utils/imports/app_imports.dart';
class MyApp extends StatelessWidget {
   MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_ , child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: MyText.appName,
          theme: ThemeData(
            primaryColor: AppColors.primaryAppBar,
            scaffoldBackgroundColor: AppColors.scaffoldBackground,
            useMaterial3: true,
          ),
          initialRoute: AppPages.initialRoute, // Start with SplashScreen
          getPages: AppPages.routes,
        );
      }
    );
  }
}