import 'dart:async';

import 'package:get/get.dart';
import 'package:shaudan_b2b/features/retailer/home/data/repositories/product_repository.dart';

import '../../data/models/product_model.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  static ProductModel productDetail = ProductModel();
  List<ProductModel> productList = <ProductModel>[];
  RxInt? hr = 45.obs;
  RxInt? min = 45.obs;
  RxInt? sec = 45.obs;

  Future<List<ProductModel>> fetchAllProduct() async {
    final productRepository = ProductRepository();
    final List<ProductModel> products =
        await productRepository.fetchAllProduct();
    return productList = products;
  }

  //timer that will run for infinate every 1 sec

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(
      oneSec,
      (Timer timer) {
        if (hr!.value == 0 && min!.value == 0 && sec!.value == 0) {
          timer.cancel();
        } else {
          if (sec!.value == 0) {
            if (min!.value == 0) {
              hr!.value--;
              min!.value = 59;
              sec!.value = 59;
            } else {
              min!.value--;
              sec!.value = 59;
            }
          } else {
            sec!.value--;
          }
        }
      },
    );
  }

  onProductTab(ProductModel p1) {
    productDetail = p1;
    Get.toNamed('/retailer/productDetail/${p1.sId}');
  }

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }
}
