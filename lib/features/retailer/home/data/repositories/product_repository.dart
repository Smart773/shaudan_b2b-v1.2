import 'package:shaudan_b2b/cores/services/login_storage.dart';
import 'package:shaudan_b2b/cores/services/network_api_service.dart';
import 'package:shaudan_b2b/features/retailer/home/data/models/product_model.dart';
import 'package:shaudan_b2b/res/app_url/app_url.dart';

class ProductRepository {
  final NetworkApiSerive _api = NetworkApiSerive();

// haan tari aankhay kitni khubsurat hain
// ager yeah bayan karnay ko mujah lafiz mil jayay toh kea khak khuubsurat hain

  Future<List<ProductModel>> fetchAllProduct() async {
    try {
      final response = await _api.getApi(
        AppUrl.getAllProducts, // url
      );
      return (response as List<dynamic>)
          .map((e) => ProductModel.fromJson(e))
          .toList();
    } //try ()
    catch (e) {
      rethrow;
    } // catch
  } // FetchAllProduct()
  Future<List<ProductModel>> fetchProductBySearch({
    required String search,
  }) async {
    try {
      final response = await _api.getApi(
        "${AppUrl.getProductBySearch}/$search", // url
      );
      return (response as List<dynamic>)
          .map((e) => ProductModel.fromJson(e))
          .toList();
    } //try ()
    catch (e) {
      rethrow;
    } // catch
  } // FetchAllProduct()

  Future<List<ProductModel>> fetchAllProductByWholeSaler() async {
    // get user id from shared pref
    final userId = await LoginPref.getUserId();
    try {
      final response = await _api.getApi(
        "${AppUrl.getAllProductsByWholeSaler}/$userId", // url
      );
      return (response as List<dynamic>)
          .map((e) => ProductModel.fromJson(e))
          .toList();
    } //try ()
    catch (e) {
      rethrow;
    } // catch
  } // FetchAllProduct()

  Future<ProductModel> fetchProductById(String id) async {
    try {
      final response = await _api.getApi(
        'products/$id', // url
      );
      return ProductModel.fromJson(response);
    } //try ()
    catch (e) {
      rethrow;
    } // catch
  } // FetchAllProduct()
}// UserRepository
