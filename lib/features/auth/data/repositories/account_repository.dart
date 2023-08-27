import 'dart:convert';

import 'package:shaudan_b2b/cores/services/login_storage.dart';
import 'package:shaudan_b2b/cores/services/network_api_service.dart';
import 'package:shaudan_b2b/features/auth/data/models/account_model.dart';
import 'package:shaudan_b2b/res/app_url/app_url.dart';

class AccountRepository {
  final NetworkApiSerive _api = NetworkApiSerive();

  Future<AccountModel> signUpAccount({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _api.postApi(
        jsonEncode(
          {
            "email": email,
            "password": password,
          },
        ), // jsonEncode()
        AppUrl.signUp, // url
      );
      AccountModel accountMode = AccountModel.fromJson(response);
      await LoginPref.saveToken(
        accountMode.accesstoken!,
      ).then((value) {
        print("token saved");
      });
      // UserModel userModel = UserModel.fromJson(response);
      return accountMode;
      // return userModel;
    } //try ()
    catch (e) {
      rethrow;
    } // catch
  } // createAccount()

  Future<AccountModel> loginAccount({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _api.postApi(
        jsonEncode(
          {
            "email": email,
            "password": password,
          },
        ), // jsonEncode()
        'auth/login', // url
      );
      AccountModel accountMode = AccountModel.fromJson(response);
      await LoginPref.saveToken(
        accountMode.accesstoken!,
      ).then((value) {
        print("token saved");
      });
      await LoginPref.saveAccountId(
        accountMode.accountId!,
      ).then((value) {
        print("userId saved");
      });
      return accountMode;
    } //try ()
    catch (e) {
      rethrow;
    } // catch
  } // createAccount()
}// UserRepository

