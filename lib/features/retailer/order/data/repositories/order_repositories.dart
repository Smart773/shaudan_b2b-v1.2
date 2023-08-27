import 'dart:convert';
import 'package:shaudan_b2b/cores/services/login_storage.dart';
import 'package:shaudan_b2b/cores/services/network_api_service.dart';
import 'package:shaudan_b2b/features/retailer/cart/data/models/cart_model.dart';
import 'package:shaudan_b2b/features/retailer/order/data/models/order_model.dart';

class OrderRepository {
  final NetworkApiSerive _api = NetworkApiSerive();

  Future<List<OrderModel>> getOrder() async {
    try {
      final userId = await LoginPref.getUserId();
      final response = await _api.getApi(
        'order/getOrderByUser/$userId', // url
      );
      return List<OrderModel>.from(response.map((x) => OrderModel.fromJson(x)));
    } //try ()
    catch (e) {
      rethrow;
    }
  }
}// CartRepository

