import 'dart:convert';
import 'package:shaudan_b2b/cores/services/login_storage.dart';
import 'package:shaudan_b2b/cores/services/network_api_service.dart';
import 'package:shaudan_b2b/features/auth/data/models/account_model.dart';
import 'package:shaudan_b2b/features/auth/data/models/retailer_model.dart';
import 'package:shaudan_b2b/res/app_url/app_url.dart';

class RetailerRepository {
  final NetworkApiSerive _api = NetworkApiSerive();

  Future<RetailerModel> createRetailer({
    required String userId,
  }) async {
    try {
      final response = await _api.postApi(
        jsonEncode(
          {
            "user": userId,
          },
        ), // jsonEncode()
        AppUrl.createRetailer, // url
      );
      RetailerModel retailerModel = RetailerModel.fromJson(response);
      return retailerModel;
    } //try ()
    catch (e) {
      rethrow;
    } // catch
  } // createAccount()

  Future<void> loginAccount({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _api
          .postApi(
        jsonEncode(
          {
            "email": email,
            "password": password,
          },
        ), // jsonEncode()
        'auth/login', // url
      )
          .then((value) async {
        AccountModel accountModel = AccountModel.fromJson(value);
        await LoginPref.saveToken(
          accountModel.accesstoken!,
        ).then((value) {
          print("token saved");
        });
      });

      print("hereeee->>>>");
    } //try ()
    catch (e) {
      rethrow;
    } // catch
  } // createAccount()
}// UserRepository

