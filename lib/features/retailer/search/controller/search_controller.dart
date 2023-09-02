import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaudan_b2b/features/retailer/home/data/models/product_model.dart';
import 'package:shaudan_b2b/features/retailer/home/data/repositories/product_repository.dart';

class SearchProductController extends GetxController {
  static SearchProductController get to => Get.find();
  // Rx controller for search textfiled
  Rx<TextEditingController> searchTextController = TextEditingController().obs;
  Rx<List<ProductModel>> productModelList = Rx<List<ProductModel>>([]);
  RxBool isLoading = false.obs;

  onSearch(String string) async {
    isLoading.value = true;
    await ProductRepository()
        .fetchProductBySearch(search: string)
        .then((value) {
      productModelList.value = value;
      isLoading.value = false;
    }).onError((error, stackTrace) {
      isLoading.value = false;
      Get.snackbar('Error', error.toString());
    });
  }
}
