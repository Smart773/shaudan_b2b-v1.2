import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaudan_b2b/cores/services/login_storage.dart';
import 'package:shaudan_b2b/features/auth/data/models/user_model.dart';
import 'package:shaudan_b2b/features/auth/data/repositories/account_repository.dart';
import 'package:shaudan_b2b/features/auth/data/repositories/user_repository.dart';
import 'package:shaudan_b2b/res/localizations/app_Strings.dart';
import 'package:shaudan_b2b/res/routes/routes_name.dart';
import 'package:shaudan_b2b/utils/utils.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();
  var user = UserModel().obs;

  final key = GlobalKey<FormState>().obs;
  final email = "".obs;
  final password = "".obs;
  final isobscureText = true.obs;
  final isloading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    // _checkLogin();
    print("in On Ready");
    String? id = await LoginPref.getAccountId();
    if (id != null) {
      print("in On Ready If Login");
      UserRepository().getUser(userId: id).then((value) {
        user.value = value;
        print("user value ${user.value}");
        key.value.currentState!.reset();
        Get.snackbar("Success", "Login Success");
        if (user.value.role == "retailer") {
          Get.offAllNamed(RoutesName.retailerMain);
        } else {
          Get.offAllNamed(RoutesName.wholesalerMain);
        }
        isloading.value = false;
      }).onError((error, stackTrace) {
        isloading.value = false;
        Utils.snackBar("Error", error.toString());
      });
    }
  }

  toggleObs() {
    isobscureText.value = !isobscureText.value;
    update();
  }

  login() async {
    if (key.value.currentState!.validate()) {
      isloading.value = true;
      await _loginAccount();
    } else {
      Get.snackbar("Error", "Please enter valid details");
    }
  }

  // private methods
  Future _loginAccount() async {
    UserRepository userRepository = UserRepository();
    AccountRepository accountRepository = AccountRepository();

    key.value.currentState!.save();
    await accountRepository
        .loginAccount(email: email.value, password: password.value)
        .then((value) async {
      value.accountId;
      print("account id ${value.accountId}");
      await userRepository.getUser(userId: value.accountId!).then((value) {
        user.value = value;
        print("user value ${user.value}");
        key.value.currentState!.reset();
        Get.snackbar("Success", "Login Success");
        if (user.value.role == "retailer")
          Get.offAllNamed(RoutesName.retailerMain);
        else
          Get.offAllNamed(RoutesName.wholesalerMain);
        isloading.value = false;
      }).onError((error, stackTrace) {
        isloading.value = false;
        Utils.snackBar("Error", error.toString());
      });
    });

    // await userRepository
    //     .loginAccount(
    //   email: email.value,
    //   password: password.value,
    // )
    //     .then((value) {
    //   // user.value = value;
    //   key.value.currentState!.reset();
    //   Get.snackbar("Success", "Login Success");
    //   if (user.value.role == "retailer")
    //     Get.offAllNamed(RoutesName.retailerMain);
    //   else
    //     Get.offAllNamed(RoutesName.wholesalerMain);
    //   isloading.value = false;
    // }).onError((error, stackTrace) {
    //   isloading.value = false;
    //   Utils.snackBar("Error", error.toString());
    // });
  }

  // validator
  validator(value, String? label) {
    key.value.currentState!.save();
    if (value!.isEmpty) {
      return "Please enter $label";
    } else if (label == AppStrings.email.tr && !GetUtils.isEmail(value)) {
      return "Please enter valid $label";
    } else if ((label == AppStrings.name.tr ||
            label == AppStrings.storeName.tr) &&
        !GetUtils.isAlphabetOnly(value)) {
      return "$label should be only alphabets";
    } else if (label == AppStrings.password.tr && value.length < 6) {
      return "$label should be atleast 6 characters";
    }
    return null;
  }

  // dispose
  @override
  void dispose() {
    super.dispose();
  }
}
