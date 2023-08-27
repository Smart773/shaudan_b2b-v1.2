import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shaudan_b2b/features/auth/view/signup/wholesaler_form.dart';
import 'package:shaudan_b2b/features/retailer/home/view/Home/rertailer_home.dart';
import 'package:shaudan_b2b/features/retailer/home/view/product/product_detail.dart';
import 'package:shaudan_b2b/features/retailer/home/view/rertailer_main/railer_main.dart';
import 'package:shaudan_b2b/features/wholesaler/home/view/wholesaler_main/wholesaler_main.dart';
import 'package:shaudan_b2b/res/routes/routes_name.dart';

import '../../features/auth/view/auth_screen.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(name: RoutesName.auth, page: () => const AuthScreen()),
        GetPage(
            name: RoutesName.retailerMain,
            page: () => const RetailerMainScreen()),
        GetPage(
            name: RoutesName.wholesalerMain,
            page: () => const WholeSalerMainScreen()),
        GetPage(
            name: RoutesName.retailerHome, page: () => const RetailerHome()),
        GetPage(
          name: RoutesName.retailerProductDetail,
          page: () {
            return ProductDetail();
          },
        ),
        // GetPage(name: RoutesName.loginView, page: () => const LoginView()),
        // GetPage(name: RoutesName.homeView, page: () => const HomeView()),
      ];
}
