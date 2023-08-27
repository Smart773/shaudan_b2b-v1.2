import 'dart:convert';
import 'package:shaudan_b2b/cores/services/login_storage.dart';
import 'package:shaudan_b2b/cores/services/network_api_service.dart';
import 'package:shaudan_b2b/features/retailer/cart/data/models/cart_model.dart';

class CartRepository {
  final NetworkApiSerive _api = NetworkApiSerive();

  Future<void> addToCart({
    required String productId,
  }) async {
    try {
      final userId = await LoginPref.getUserId();
      print('cart/$userId');
      final response = await _api.postApi(
        jsonEncode(
          {
            "user": userId,
            "product": productId,
          },
        ), // jsonEncode()
        'cart/add', // url
      );
    } //try ()
    catch (e) {
      rethrow;
    } // catch
  }

  Future<List<CartModel>> getCart() async {
    try {
      final userId = await LoginPref.getUserId();
      print('cart/$userId');
      final response = await _api.getApi(
        'cart/$userId', // url
      );
      return (response as List<dynamic>)
          .map((e) => CartModel.fromJson(e))
          .toList();
    } //try ()
    catch (e) {
      rethrow;
    } // catch
  }

  Future<int> getAmount() async {
    try {
      final userId = await LoginPref.getUserId();
      final response = await _api.getApi(
        'cart/get_total_amount_selected/$userId', // url
      );
      return response as int;
    } //try ()
    catch (e) {
      rethrow;
    } // catch
  }

  Future<void> updateqty({
    required int qty,
    required String id,
  }) async {
    try {
      final response = await _api.patchApi(
        {"quantity": qty},
        'cart/update_quantity/$id', // url
      );
    } //try ()
    catch (e) {
      rethrow;
    } // catch
  }

  Future<void> updateSelected({
    required bool selected,
    required String id,
  }) async {
    try {
      final response = await _api.patchApi(
        {"isProductSelectedBool": selected},
        'cart/update_isProductSelectedBool/$id', // url
      );
    } //try ()
    catch (e) {
      rethrow;
    } // catch
  }

  Future<void> deleteSeletecd() async {
    try {
      final userId = await LoginPref.getUserId();
      final response = await _api.deleteApi(
        'cart/delete_selected_items/$userId', // url
      );
    } //try ()
    catch (e) {
      rethrow;
    } // catch
  }
}// CartRepository

