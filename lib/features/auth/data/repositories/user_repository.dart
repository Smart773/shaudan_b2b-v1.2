import 'dart:convert';
import 'package:shaudan_b2b/cores/services/login_storage.dart';
import 'package:shaudan_b2b/cores/services/network_api_service.dart';
import 'package:shaudan_b2b/features/auth/data/models/user_model.dart';
import 'package:shaudan_b2b/res/app_url/app_url.dart';

class UserRepository {
  final NetworkApiSerive _api = NetworkApiSerive();

  Future<UserModel> createUser({
    required String email,
    required String password,
    required String account,
    required String name,
    required String role,
    String storeName = "",
    String phone = "",
    String address = "",
    String avatar = "",
  }) async {
    try {
      final response = await _api.postApi(
        jsonEncode(
          {
            "name": name,
            "account": account,
            "address": {
              "street": "street 2",
              "houseNumber": "house 1",
              "city": "city 1",
              "postalCode": "postal 1",
              "state": "state 1",
              "country": "country 1",
              "addressType": "addressType 1"
            },
            "contact": {
              "phoneNumber": "923021234569",
              "socialMedia": "facebook"
            },
            "DOB": "1998-12-12",
            // "image":"image 1",
            "role": role
          },
        ), // jsonEncode()
        AppUrl.createUser, // url
      );
      UserModel userModel = UserModel.fromJson(response);
      return userModel;
    } //try ()
    catch (e) {
      rethrow;
    } // catch
  } // createAccount()

  Future<UserModel> getUser({
    required String userId,
  }) async {
    try {
      final response = await _api.getApi(
        // jsonEncode()
        "${AppUrl.getUser}//${userId}", // url
      );
      print("response $response");

      UserModel userModel = UserModel.fromJson(response);
      await LoginPref.saveUserId(userModel.sId!);
      return userModel;
    } //try ()
    catch (e) {
      rethrow;
    } // catch
  } // createAccount()
}// UserRepository

