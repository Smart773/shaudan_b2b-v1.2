import 'dart:async';

import 'package:get/get.dart';
import 'package:shaudan_b2b/features/retailer/cart/data/models/cart_model.dart';
import 'package:shaudan_b2b/features/retailer/cart/view/checkout.dart';
import 'package:shaudan_b2b/utils/utils.dart';

import '../data/repositories/cart_repositories.dart';

class CartController extends GetxController {
  static CartController instance = Get.find();
  late Timer _timer;
  RxInt amount = 0.obs;
  RxBool isAllSelected = false.obs;
  RxBool isAnySelected = false.obs;
  int timerCount = 10;
  bool istimerActive = false;
  Rx<List<CartModel>> cartList = Rx<List<CartModel>>([]);
  List<CartModel> selectedProducts = [];

  void checkSelections() {
    if (cartList.value.isNotEmpty) {
      isAnySelected.value = cartList.value
          .any((element) => element.isProductSelectedBool == true);
      isAllSelected.value = cartList.value
          .every((element) => element.isProductSelectedBool == true);
    } else {
      isAnySelected.value = false;
      isAllSelected.value = false;
    }
  }

  void getTheListOfSelectedProducts() {
    selectedProducts.clear();
    for (var element in cartList.value) {
      if (element.isProductSelectedBool == true) {
        selectedProducts.add(element);
      }
    }

    print(selectedProducts);
  }

  void onCheckOutPressed() async {
    Utils.showLoaing();
    if (isAnySelected.value) {
      getTheListOfSelectedProducts();
      await getAmount().then((value) {
        amount.value = value;
      }).onError((error, stackTrace) {
        Utils.hideLoading();
        Get.snackbar("Error", error.toString());
      });
      Utils.hideLoading();
      Get.to(() => const CheckOut());
    } else {
      Utils.hideLoading();
      Get.snackbar("Error", "Please select atleast one product");
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    // TODO: implement onReady
    super.onReady();
    await getCartList();

    await getAmount().then((value) {
      amount.value = value;
    });
  }

  void onDeletePressed() async {
    if (isAnySelected.value) {
      Utils.showLoaing();
      await CartRepository().deleteSeletecd().then((value) async {
        await getAmount().then((value) async {
          amount.value = value;
          await getCartList().then((value) {
            Utils.hideLoading();
          }).onError((error, stackTrace) {
            Utils.hideLoading();
            Get.snackbar("Error", error.toString());
          });
        }).onError((error, stackTrace) {
          Utils.hideLoading();
          Get.snackbar("Error", error.toString());
        });
      }).onError((error, stackTrace) {
        Utils.hideLoading();
        Get.snackbar("Error", error.toString());
      });
    } else {
      Get.snackbar("Error", "Please select atleast one product");
    }
  }

  void onPressQty(int qty, String id) async {
    Utils.showLoaing();
    await updateQty(qty, id).then((value) async {
      await getAmount().then((value) {
        amount.value = value;
        Utils.hideLoading();
      }).onError((error, stackTrace) {
        Utils.hideLoading();
        Get.snackbar("Error", error.toString());
      });
    }).onError((error, stackTrace) {
      Utils.hideLoading();
      Get.snackbar("Error", error.toString());
    });
  }

  void onPressSelected(bool selected, String id) async {
    Utils.showLoaing();
    await updateSelected(selected, id).then((value) async {
      // wait for 1 second
      await getAmount().then((value) {
        amount.value = value;
        Utils.hideLoading();
      }).then((value) async {
        await getCartList();
      }).onError((error, stackTrace) {
        Utils.hideLoading();
        Get.snackbar("Error", error.toString());
      });
    }).onError((error, stackTrace) {
      Utils.hideLoading();
      Get.snackbar("Error", error.toString());
    });
  }

  // get cart list from repository using Stream
  Future<List<CartModel>> getCartList() async {
    try {
      final cartList = await CartRepository().getCart();
      this.cartList.value = cartList;
      checkSelections();
      return cartList;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateQty(int qty, String id) async {
    try {
      await CartRepository().updateqty(
        qty: qty,
        id: id,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateSelected(bool selected, String id) async {
    try {
      await CartRepository().updateSelected(
        selected: selected,
        id: id,
      );
    } catch (e) {
      rethrow;
    }
  }

  // get total amount of selected products
  Future<int> getAmount() async {
    try {
      final amount = await CartRepository().getAmount();
      return amount;
    } catch (e) {
      rethrow;
    }
  }
}
