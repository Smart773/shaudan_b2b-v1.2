import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shaudan_b2b/features/retailer/account/view/account.dart';
import 'package:shaudan_b2b/features/retailer/cart/controller/cart_controller.dart';
import 'package:shaudan_b2b/features/retailer/cart/view/cart.dart';
import 'package:shaudan_b2b/features/retailer/home/controller/retailer_main_controller/retailer_main_controller.dart';
import 'package:shaudan_b2b/features/retailer/home/view/Home/rertailer_home.dart';
import 'package:shaudan_b2b/features/retailer/liked/view/liked.dart';
import 'package:shaudan_b2b/features/retailer/notify/view/notify.dart';
import 'package:shaudan_b2b/features/retailer/order/view/retailer_order.dart';
import 'package:shaudan_b2b/res/colors/AppColors.dart';
import 'package:shaudan_b2b/res/localizations/app_Strings.dart';
import 'package:shaudan_b2b/utils/utils.dart';

class RetailerMainScreen extends StatelessWidget {
  const RetailerMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RetailerMainController retailerMainController =
        Get.put(RetailerMainController());

    final List<Widget> pages = <Widget>[
      const RetailerHome(),
      const Notify(),
      const Cart(),
      const RetailerOrder(),
      const Account(),
    ];
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth < 450) {
            return Obx(
              () => Column(
                children: [
                  Expanded(
                    child: pages[retailerMainController.selectedIndex.value],
                  ),
                  BottomNavigationBar(
                    currentIndex: retailerMainController.selectedIndex.value,
                    onTap: (int index) {
                      if (index == 2 &&
                          retailerMainController.isCartSelected.value) {
                        Get.find<CartController>().startTimer();
                      } else if (retailerMainController.selectedIndex.value ==
                          2) {
                        Get.find<CartController>().stopTimer();
                        retailerMainController.isCartSelected.value = true;
                      }

                      retailerMainController.selectedIndex.value = index;
                    },
                    items: [
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.home),
                        label: AppStrings.home.tr,
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.notifications),
                        label: AppStrings.notify.tr,
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.shopping_cart),
                        label: AppStrings.cart.tr,
                      ),
                      BottomNavigationBarItem(
                        icon:  const Icon(LineIcons.shoppingBag),
                        label: AppStrings.order.tr,
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.person),
                        label: AppStrings.account.tr,
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Obx(
              () => Row(
                children: [
                  ScrollWithIntrinsicHeight(
                    constraints: constraints,
                    child: NavigationRail(
                      minExtendedWidth: 200,
                      elevation: 2,
                      leading: const CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.primaryColor,
                        child: Icon(LineIcons.userNinja, size: 30),
                      ),
                      extended: constraints.maxWidth >= 600,
                      destinations: [
                        NavigationRailDestination(
                          icon: const Icon(Icons.home),
                          label: Text(AppStrings.home.tr),
                        ),
                        NavigationRailDestination(
                          icon: const Icon(Icons.notifications),
                          label: Text(AppStrings.notify.tr),
                        ),
                        NavigationRailDestination(
                          icon: const Icon(Icons.shopping_cart),
                          label: Text(AppStrings.cart.tr),
                        ),
                        NavigationRailDestination(
                          icon: const Icon(LineIcons.shoppingBag),
                          label: Text(AppStrings.order.tr),
                        ),
                        NavigationRailDestination(
                          icon: const Icon(Icons.person),
                          label: Text(AppStrings.account.tr),
                        ),
                      ],
                      selectedIndex: retailerMainController.selectedIndex.value,
                      onDestinationSelected: (int index) {
                        if (index == 2 &&
                            retailerMainController.isCartSelected.value) {
                          Get.find<CartController>().startTimer();
                        } else if (retailerMainController.selectedIndex.value ==
                            2) {
                          Get.find<CartController>().stopTimer();
                          retailerMainController.isCartSelected.value = true;
                        }
                        retailerMainController.selectedIndex.value = index;
                      },
                    ),
                  ),
                  Expanded(
                    child: pages[retailerMainController.selectedIndex.value],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
