import 'dart:convert';
import 'package:shaudan_b2b/cores/services/network_api_service.dart';
import 'package:shaudan_b2b/features/auth/data/models/wholesaler_model.dart';
import 'package:shaudan_b2b/res/app_url/app_url.dart';

class WholeSalerRepository {
  final NetworkApiSerive _api = NetworkApiSerive();

  Future<WholeSalerModel> createWholeSaler({
    required String userId,
    required String storeName,
  }) async {
    try {
      final response = await _api.postApi(
        jsonEncode(
          {
            "user": userId,
            "store": {"name": storeName},
          },
        ), // jsonEncode()
        AppUrl.createWholeSaler, // url
      );
      WholeSalerModel wholeSalerModel = WholeSalerModel.fromJson(response);
      return wholeSalerModel;
    } catch (e) {
      rethrow;
    }
  }
}
