import 'package:get/get.dart';
import 'package:shaudan_b2b/features/retailer/home/data/models/product_model.dart';
import 'package:shaudan_b2b/features/retailer/home/data/repositories/product_repository.dart';

class StoreController extends GetxController {
  static StoreController get to => Get.find();
  static ProductModel productDetail = ProductModel();
  List<ProductModel> productList = <ProductModel>[];

  @override
  void onInit() {
    super.onInit();
  }

  Future<List<ProductModel>> fetchAllProductByWholeSaler() async {
    final productRepository = ProductRepository();
    final List<ProductModel> products =
        await productRepository.fetchAllProductByWholeSaler();
    return productList = products;
  }

  onProductTab(ProductModel p1) {
    productDetail = p1;
    // Get.toNamed('/retailer/productDetail/${p1.sId}');
    Get.toNamed('/wholesaler/updateProduct/${p1.sId}');
  }
}
