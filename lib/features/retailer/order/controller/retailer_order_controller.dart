import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaudan_b2b/features/retailer/order/data/models/order_model.dart';
import 'package:shaudan_b2b/features/retailer/order/data/repositories/order_repositories.dart';

class RetailerOrderController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // Rx list of orderModel
  Rx<List<OrderModel>> orderModelList = Rx<List<OrderModel>>([]);
  RxInt selectedIndex = 0.obs;
  late Rx<TabController> tabController;
  @override
  void onInit() {
    super.onInit();
    initController();
  }

  initController() {
    tabController = TabController(length: 4, vsync: this).obs;
  }

  @override
  void onReady() async {
    await getOrderList();
    super.onReady();
  }

  Future<void> getOrderList() async {
    final result = await OrderRepository().getOrder();
    print(result);
    orderModelList.value = result;
    // orderModelList.value = result;
  }
}
