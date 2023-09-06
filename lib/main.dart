import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shaudan_b2b/features/auth/controllers/login/login_controller.dart';
import 'package:shaudan_b2b/res/localizations/languages.dart';
import 'package:shaudan_b2b/res/routes/routes.dart';
import 'cores/theme/app_theme.dart';

void main() async {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Get.put(LoginController(), permanent: true);
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        },
      ),
      title: 'Shaudan B2B',
      translations: Languages(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      // locale: const Locale('ur', 'PK'),
      // fallbackLocale: const Locale('ur', 'PK'),
      // initialRoute: RoutesName.retailerMain,
      debugShowCheckedModeBanner: false,

      theme: AppTheme.appTheme,
      getPages: AppRoutes.appRoutes(),
      // home: WholeSalerMainScreen(),
    );
  }
}
