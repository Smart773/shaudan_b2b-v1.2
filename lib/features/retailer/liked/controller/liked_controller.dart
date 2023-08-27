import 'package:get/get.dart';
import 'package:shaudan_b2b/features/retailer/home/data/models/product_model.dart';

class LikedController extends GetxController {
  static LikedController get to => Get.find();
  final likedList = <ProductModel>[].obs;

  getIndex(ProductModel productModel) {
    final index =
        likedList.indexWhere((element) => element.sId == productModel.sId);
    return index;
  }

  removeItem(ProductModel productModel) {
    likedList.removeAt(getIndex(productModel));
    update();
  }

  addItem(ProductModel productModel) {
    likedList.add(productModel);
    update();
  }

  removeAll() {
    likedList.clear();
    update();
  }

  // is current product in liked
  checkinList(ProductModel productModel) {
    if (likedList.isEmpty) {
      return false;
    }
    // check if product by id is in list or not
    final index = getIndex(productModel);

    if (index == -1) {
      return false;
    }
    if (likedList[index].sId == productModel.sId) {
      return true;
    }
    return false;
  }

  // getIndex

  onLikePressed(ProductModel productModel) {
    // add if not in list
    if (checkinList(productModel)) {
      removeItem(productModel);
    } else {
      addItem(productModel);
    }
  }

  @override
  void onInit() {
    super.onInit();
  }
}
