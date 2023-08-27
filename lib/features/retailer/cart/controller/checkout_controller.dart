import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaudan_b2b/features/auth/controllers/login/login_controller.dart';
import 'package:shaudan_b2b/features/retailer/cart/controller/cart_controller.dart';
import 'package:shaudan_b2b/features/retailer/cart/data/repositories/checkout_repositories.dart';
import 'package:shaudan_b2b/res/colors/AppColors.dart';
import 'package:shaudan_b2b/utils/utils.dart';

import '../data/models/cart_model.dart';

class CheckoutController extends GetxController {
  static CheckoutController instance = Get.find();
  List<CartModel> cartList = Get.find<CartController>().selectedProducts;

  int totalItemAmount = 0;
  int deleveryCharges = 0;
  int discount = 0;
  int totalAmount = 0;
  var user = Get.find<LoginController>().user.value;
  @override
  void onInit() {
    super.onInit();
    totalItemAmount = Get.find<CartController>().amount.value;
    deleveryCharges = 0;
    discount = 0;
    totalAmount = totalItemAmount + deleveryCharges - discount;
  }

  void placeOrder() async {
    Utils.showLoaing();
    await CheckOutRepository().placeOrder().then((value) {
      Utils.hideLoading();
      // pop untill retailer
      Get.offAllNamed('/retailer');
      // pop Up saying order placed successfully diloag
      // with icon and message
      // custom dialog box with back white and green icon and message
      Utils.showCustomDialogBox(
        title: 'Order Placed Successfully',
        message: 'Your order has been placed successfully',
        buttonText: 'Ok',
        icon: Icons.check_circle,
        buttonAction: () {
          Get.back();
        },
      );
    }).catchError((e) {
      Utils.hideLoading();
    });
  }
}
