import 'dart:convert';
import 'package:shaudan_b2b/cores/services/login_storage.dart';
import 'package:shaudan_b2b/cores/services/network_api_service.dart';
import 'package:shaudan_b2b/features/retailer/cart/data/models/cart_model.dart';
import 'package:shaudan_b2b/features/retailer/order/data/models/order_model.dart';
import 'package:shaudan_b2b/features/wholesaler/home/data/models/dashboard_model.dart';

class OrderRepository {
  final NetworkApiSerive _api = NetworkApiSerive();

  Future<List<OrderModel>> getOrderByUser() async {
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

  Future<List<OrderModel>> getOrderByWholesaler() async {
    try {
      final userId = await LoginPref.getUserId();
      final response = await _api.getApi(
        'order/getOrderByWholesaler/$userId', // url
      );
      return List<OrderModel>.from(response.map((x) => OrderModel.fromJson(x)));
    } //try ()
    catch (e) {
      rethrow;
    }
  }

  Future<List<OrderModel>> getOrderByUserIdAndStatus(
      {required String status}) async {
    try {
      final userId = await LoginPref.getUserId();
      final response = await _api.getApi(
        'order/getOrderByUserAndStatus/$userId/$status', // url
      );
      return List<OrderModel>.from(response.map((x) => OrderModel.fromJson(x)));
    } //try ()
    catch (e) {
      rethrow;
    }
  }

  Future<List<OrderModel>> getOrderByWholeSalerIdAndStatus({required String status}) async {
    try {
      final userId = await LoginPref.getUserId();
      final response = await _api.getApi(
        'order/getOrderByWholesalerAndStatus/$userId/$status', // url
      );
      return List<OrderModel>.from(response.map((x) => OrderModel.fromJson(x)));
    } //try ()
    catch (e) {
      rethrow;
    }
  }


  Future<DashboardModel> getOrderDetailByWholesaler() async {
    try {
      final userId = await LoginPref.getUserId();
      final response = await _api.getApi(
        'order/getOrderDetailByWholesaler/$userId', // url
      );
      // return List<OrderModel>.from(response.map((x) => OrderModel.fromJson(x)));
      return DashboardModel.fromJson(response);
    } //try ()
    catch (e) {
      rethrow;
    }
  }

  Future<void> updateOrderStatus(String orderId, String status) async {
    try {
      await _api.patchApi(
        {
          "orderStatus": status,
        },
        'order/updateOrderStatus/$orderId', // url
      );
    } //try ()
    catch (e) {
      rethrow;
    }
  }
}// CartRepository

