import 'package:get/get.dart';
import 'package:xpk/app/example.dart';
import 'package:xpk/utils/imports/app_imports.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: MyText.appName,
           // home: PaginationExample(),
            theme: ThemeData(
              primaryColor: AppColors.primaryAppBar,
              scaffoldBackgroundColor: AppColors.white,
              useMaterial3: true,
            ),
            initialRoute: AppPages.initialRoute,
            getPages: AppPages.routes,
          );
        });
  }
}
