import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaudan_b2b/features/auth/controllers/signup/retailer_controller.dart';
import 'package:shaudan_b2b/res/components/app_button.dart';
import 'package:shaudan_b2b/res/localizations/app_Strings.dart';
import 'package:shaudan_b2b/utils/utils.dart';

class Retailer extends StatelessWidget {
  const Retailer({super.key});

  @override
  Widget build(BuildContext context) {
    final RetailerController retailerController = Get.put(RetailerController());
    return Form(
      key: retailerController.key.value,
      child: Column(
        children: [
          Utils.hSpace(),
          //Name
          CustomTextRetailerField(
            onSaved: (value) {
              retailerController.name.value = value!;
            },
            validatorLabel: AppStrings.name.tr,
            labelText: AppStrings.name.tr,
            hint: AppStrings.nameHint.tr,
          ),
          Utils.hSpace(),
          // Store Name
          CustomTextRetailerField(
            validatorLabel: AppStrings.storeName.tr,
            onSaved: (value) {
              retailerController.shopName.value = value!;
            },
            labelText: AppStrings.storeName.tr,
            hint: AppStrings.storeNameHint.tr,
          ),

          Utils.hSpace(),
          // Email(),
          CustomTextRetailerField(
            onSaved: (value) {
              retailerController.email.value = value!;
            },
            validatorLabel: AppStrings.email.tr,
            labelText: AppStrings.email.tr,
            hint: AppStrings.emailHint.tr,
          ),
          Utils.hSpace(),

          CustomTextRetailerField(
            onSaved: (value) {
              retailerController.password.value = value!;
            },
            labelText: AppStrings.password.tr,
            hint: AppStrings.passwordHint.tr,
            validatorLabel: AppStrings.password.tr,
            isPassword: true,
          ),
          Utils.hSpace(),
          CustomTextRetailerField(
            onSaved: (value) {
              retailerController.confirmPassword.value = value!;
            },
            labelText: AppStrings.confirmPassword.tr,
            hint: AppStrings.confirmPasswordHint.tr,
            validatorLabel: AppStrings.confirmPassword.tr,
            isPassword: true,
          ),
          Utils.hSpace(),
          Utils.hSpace(),
          Obx(() => AppButtonElevated(
                isLoading: retailerController.isloading.value,
                title: '${AppStrings.signUp.tr}  (${AppStrings.retailer.tr})',
                onPress: () {
                  retailerController.retailerSignUp();
                },
                width: double.infinity,
              )),
        ],
      ),
    );
  }
}

class CustomTextRetailerField extends StatelessWidget {
  const CustomTextRetailerField({
    super.key,
    required this.validatorLabel,
    required this.labelText,
    required this.hint,
    required this.onSaved,
    this.isPassword = false,
    this.isobscureText = false,
  });

  final String labelText;
  final String hint;
  final bool isobscureText;
  final String? validatorLabel;
  final bool isPassword;
  final Function(String?)? onSaved;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RetailerController>(
      init: RetailerController(),
      initState: (_) {},
      builder: (_) {
        return TextFormField(
          onSaved: onSaved,
          obscureText: isPassword && _.isobscureText.value,
          // controller: _passwordController,
          // icon at the end of the textfield
          validator: (value) {
            return _.validator(value, validatorLabel!);
          },
          decoration: InputDecoration(
            suffixIcon: Visibility(
              visible: isPassword,
              child: IconButton(
                onPressed: () {
                  _.toggleObs();
                },
                icon: Icon(_.isobscureText.value
                    ? Icons.visibility_off
                    : Icons.visibility),
              ),
            ),
            labelText: labelText,
            hintText: hint,
            border: const OutlineInputBorder(),
          ),
        );
      },
    );
  }
}
