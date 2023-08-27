import 'package:get/get.dart';
import 'package:shaudan_b2b/features/retailer/cart/data/repositories/cart_repositories.dart';
import 'package:shaudan_b2b/features/retailer/home/controller/home_controller/home_controller.dart';
import 'package:shaudan_b2b/utils/utils.dart';

import '../../data/models/product_model.dart';

class ProductController extends GetxController {
  static ProductController instance = Get.find();
  Rx<ProductModel> product =
      HomeController.productDetail.obs; // ProductModel().obs;

  void addToCart() async {
    final cartRepository = CartRepository();
    // loading dialog
    Utils.showLoaing();
    await cartRepository
        .addToCart(
          productId: product.value.sId!,
        )
        .then((value) => {
              Utils.hideLoading(),
              Get.snackbar("Success", "Product added to cart"),
            })
        .onError((error, stackTrace) => {
              Utils.hideLoading(),
              Utils.snackBar("Error", error.toString()),
            });
  }
}
