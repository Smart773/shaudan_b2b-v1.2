import 'package:shaudan_b2b/cores/services/network_api_service.dart';
import 'package:shaudan_b2b/features/retailer/home/data/models/product_model.dart';
import 'package:shaudan_b2b/res/app_url/app_url.dart';

class ProductRepository {
  final NetworkApiSerive _api = NetworkApiSerive();

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

  // Future<UserModel> createProduct({
  //   required String email,
  //   required String password,
  //   required String name,
  //   required String role,
  //   String storeName = "",
  //   String phone = "",
  //   String address = "",
  //   String avatar = "",
  // }) async {
  //   try {
  //     final response = await _api.postApi(
  //       jsonEncode(
  //         {
  //           "email": email,
  //           "password": password,
  //           "name": name,
  //           "role": role,
  //           "storeName": storeName,
  //           "phone": phone,
  //           "address": address,
  //           "avatar": avatar,
  //         },
  //       ), // jsonEncode()
  //       '/user/createAccount', // url
  //     );
  //     UserModel userModel = UserModel.fromJson(response);
  //     return userModel;
  //   } //try ()
  //   catch (e) {
  //     rethrow;
  //   } // catch
  // } // createAccount()
}// UserRepository

