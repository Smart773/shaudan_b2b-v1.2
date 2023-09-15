import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shaudan_b2b/features/retailer/account/view/account.dart';
import 'package:shaudan_b2b/features/wholesaler/home/controller/wholesaler_main_controller/wholesaler_main_controller.dart';
import 'package:shaudan_b2b/features/wholesaler/home/view/home/dashboard.dart';
import 'package:shaudan_b2b/features/wholesaler/order/view/wholesaler_order.dart';
import 'package:shaudan_b2b/features/wholesaler/store/view/store.dart';
import 'package:shaudan_b2b/features/wholesaler/upload_product/view/upload_product.dart';
import 'package:shaudan_b2b/res/colors/AppColors.dart';
import 'package:shaudan_b2b/res/localizations/app_strings.dart';
import 'package:shaudan_b2b/utils/utils.dart';

class WholeSalerMainScreen extends StatelessWidget {
  const WholeSalerMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WholeSalerMainController wholeSalerMainController =
        Get.put(WholeSalerMainController());
    final List<Widget> pages = <Widget>[
      const WholesalerHome(),
      const Store(),
      const UploadProduct(),
      const WholeSalerOrder(),
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
                    child: pages[wholeSalerMainController.selectedIndex.value],
                  ),
                  BottomNavigationBar(
                    currentIndex: wholeSalerMainController.selectedIndex.value,
                    onTap: (int index) {
                      wholeSalerMainController.selectedIndex.value = index;
                    },
                    items: [
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.home),
                        label: AppStrings.home.tr,
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.store),
                        label: AppStrings.store.tr,
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(LineIcons.upload),
                        label: AppStrings.upload.tr,
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(LineIcons.shoppingBasket),
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
                          icon: const Icon(Icons.store),
                          label: Text(AppStrings.store.tr),
                        ),
                        NavigationRailDestination(
                          icon: const Icon(LineIcons.upload),
                          label: Text(AppStrings.uploadProduct.tr),
                        ),
                        NavigationRailDestination(
                          //Order
                          icon: const Icon(LineIcons.shoppingBasket),
                          label: Text(AppStrings.order.tr),
                        ),
                        NavigationRailDestination(
                          icon: const Icon(Icons.person),
                          label: Text(AppStrings.account.tr),
                        ),
                      ],
                      selectedIndex:
                          wholeSalerMainController.selectedIndex.value,
                      onDestinationSelected: (int index) {
                        wholeSalerMainController.selectedIndex.value = index;
                      },
                    ),
                  ),
                  Expanded(
                    child: pages[wholeSalerMainController.selectedIndex.value],
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
