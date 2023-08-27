import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxInt selectedIndex = 0.obs;
  // final TabController
  late Rx<TabController> tabController;

  @override
  void onInit() {
    super.onInit();
    initController();
  }

  initController() {
    tabController = TabController(length: 3, vsync: this).obs;
  }
}
