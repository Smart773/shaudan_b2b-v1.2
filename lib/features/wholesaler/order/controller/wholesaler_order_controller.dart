import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaudan_b2b/features/retailer/order/data/models/order_model.dart';
import 'package:shaudan_b2b/features/retailer/order/data/repositories/order_repositories.dart';
import 'package:shaudan_b2b/utils/utils.dart';

class WholeSalerOrderController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // Rx list of orderModel
  Rx<List<OrderModel>> orderModelList = Rx<List<OrderModel>>([]);
  // List of orderModel for pending
  Rx<List<OrderModel>> pendingOrderModelList = Rx<List<OrderModel>>([]);
  // List of orderModel for completed
  Rx<List<OrderModel>> completedOrderModelList = Rx<List<OrderModel>>([]);
  // List of orderModel for cancelled
  Rx<List<OrderModel>> cancelledOrderModelList = Rx<List<OrderModel>>([]);
  RxInt selectedIndex = 0.obs;
  late Rx<TabController> tabController;
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    initController();
  }

  initController() {
    tabController = TabController(length: 4, vsync: this).obs;
  }

  // onTabChange
  void onTabChange(int index) async {
    selectedIndex.value = index;
    switch (index) {
      case 0:
        isLoading.value = true;
        await getOrderList().then((value) {
          isLoading.value = false;
        }).onError((error, stackTrace) {
          isLoading.value = false;
          Get.snackbar('Error', error.toString());
        });
        break;
      case 1:
        isLoading.value = true;
        await getOrderByStatus('pending').then((value) {
          isLoading.value = false;
        }).onError((error, stackTrace) {
          isLoading.value = false;
          Get.snackbar('Error', error.toString());
        });
        break;
      case 2:
        isLoading.value = true;
        await getOrderByStatus('completed').then((value) {
          isLoading.value = false;
        }).onError((error, stackTrace) {
          isLoading.value = false;
          Get.snackbar('Error', error.toString());
        });
        break;
      case 3:
        isLoading.value = true;
        await getOrderByStatus('cancelled').then((value) {
          isLoading.value = false;
        }).onError((error, stackTrace) {
          isLoading.value = false;
          Get.snackbar('Error', error.toString());
        });
        break;
      default:
    }
  }

  @override
  void onReady() async {
    isLoading.value = true;
    await getOrderList().then((value) {
      isLoading.value = false;
    }).onError((error, stackTrace) {
      isLoading.value = false;
      Get.snackbar('Error', error.toString());
    });
    super.onReady();
  }

  Future<List<OrderModel>> getOrderList() async {
    orderModelList.value.clear();
    final result = await OrderRepository().getOrderByUser();
    orderModelList.value = result;
    print('${orderModelList.value.length}');
    return result;
  }

  Future<List<OrderModel>> getOrderByStatus(String status) async {
    orderModelList.value.clear();
    if (status == 'pending') {
      pendingOrderModelList.value.clear();
    } else if (status == 'completed') {
      completedOrderModelList.value.clear();
    } else if (status == 'cancelled') {
      cancelledOrderModelList.value.clear();
    }

    final result =
        await OrderRepository().getOrderByUserIdAndStatus(status: status);

    if (status == 'pending') {
      pendingOrderModelList.value = result;
      print('${pendingOrderModelList.value.length}');
    } else if (status == 'completed') {
      completedOrderModelList.value = result;
      print('${completedOrderModelList.value.length}');
    } else if (status == 'cancelled') {
      cancelledOrderModelList.value = result;
      print('${cancelledOrderModelList.value.length}');
    }
    return result;
  }

// call Futuer Updatesatatus
  Future<void> updateOrderStatus(String orderId, String status) async {
    await OrderRepository().updateOrderStatus(orderId, status);
  }

  void onCanceled(String orderId) async {
    Utils.showLoaing();
    await updateOrderStatus(orderId, 'cancelled').then((value) async {
      await getOrderByStatus('cancelled').then((value) {
        if (selectedIndex.value == 0) {
          onTabChange(0);
        } else {
          onTabChange(1);
        }
        Utils.hideLoading();
      }).onError((error, stackTrace) {
        Utils.hideLoading();
        Get.snackbar('Error', error.toString());
      });
    }).onError((error, stackTrace) {
      Utils.hideLoading();
      Get.snackbar('Error', error.toString());
    });
  }

  void onCompleted(String orderId) async {
    print('onCompleted');
  }
}
