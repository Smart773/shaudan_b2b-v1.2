import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaudan_b2b/features/auth/controllers/auth/authController.dart';
import 'package:shaudan_b2b/features/auth/data/repositories/account_repository.dart';
import 'package:shaudan_b2b/features/auth/data/repositories/user_repository.dart';
import 'package:shaudan_b2b/features/auth/data/repositories/wholesaler_repository.dart';
import 'package:shaudan_b2b/res/localizations/app_Strings.dart';
import 'package:shaudan_b2b/utils/utils.dart';

class WholeSalerController extends GetxController {
  static WholeSalerController get to => Get.find();

  final key = GlobalKey<FormState>().obs;
  final name = "".obs;
  final shopName = "".obs;
  final email = "".obs;
  final password = "".obs;
  final confirmPassword = "".obs;
  final isobscureText = true.obs;
  final isloading = false.obs;

  toggleObs() {
    isobscureText.value = !isobscureText.value;
    update();
  }

  wholesalerSignUp() async {
    isloading.value = true;
    if (key.value.currentState!.validate()) {
      await _createAccount();
    } else {
      isloading.value = false;
      Get.snackbar("Error", "Please enter valid details");
    }
  }

  // private methods
  Future _createAccount() async {
    UserRepository userRepository = UserRepository();
    AccountRepository accountRepository = AccountRepository();
    WholeSalerRepository wholeSalerRepository = WholeSalerRepository();

    key.value.currentState!.save();
    await accountRepository
        .signUpAccount(email: email.value, password: password.value)
        .then((value) async {
      await userRepository
          .createUser(
        account: value.accountId!,
        email: email.value,
        password: password.value,
        name: name.value,
        role: "wholesaler",
        storeName: shopName.value,
      )
          .then((value) async {
        await wholeSalerRepository.createWholeSaler(
            userId: value.sId!, storeName: shopName.value);
      }).then((value) {
        key.value.currentState!.reset();
        Get.snackbar("Success", "Wholesaler  SignUp Success");
        isloading.value = false;
        AuthController.to.selectedIndex.value = 0;
      }).onError((error, stackTrace) {
        isloading.value = false;
        Utils.snackBar("Error", error.toString());
      });
    });
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
    } else if (label == AppStrings.confirmPassword.tr ||
        label == AppStrings.password.tr) {
      if (WholeSalerController.to.password.value !=
          WholeSalerController.to.confirmPassword.value) {
        return "password and confirm password should be same";
      }
    }
    return null;
  }

  //  validatorPassword
}
