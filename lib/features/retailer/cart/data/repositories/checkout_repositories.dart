import 'dart:convert';
import 'package:shaudan_b2b/cores/services/login_storage.dart';
import 'package:shaudan_b2b/cores/services/network_api_service.dart';
import 'package:shaudan_b2b/features/retailer/cart/data/models/cart_model.dart';

class CheckOutRepository {
  final NetworkApiSerive _api = NetworkApiSerive();

  Future<void> placeOrder() async {
    try {
      final userId = await LoginPref.getUserId();
      final response = await _api.postApi(
        jsonEncode(
          {
            "user": userId,
          },
        ), // jsonEncode()
        'order/createOrder/', // url
      );
    } //try ()
    catch (e) {
      rethrow;
    } // catch
  }

}// CartRepository

