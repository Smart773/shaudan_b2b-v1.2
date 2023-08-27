import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaudan_b2b/features/auth/controllers/signup/wholesaler_controller.dart';
import 'package:shaudan_b2b/res/components/app_button.dart';
import 'package:shaudan_b2b/res/localizations/app_Strings.dart';
import 'package:shaudan_b2b/utils/utils.dart';

class WholeSaler extends StatelessWidget {
  const WholeSaler({super.key});

  @override
  Widget build(BuildContext context) {
    final WholeSalerController wholeSalerController =
        Get.put(WholeSalerController());
    return Form(
      key: wholeSalerController.key.value,
      child: Column(
        children: [
          Utils.hSpace(),
          //Name
          CustomTextWholeSalerField(
            onSaved: (value) {
              wholeSalerController.name.value = value!;
            },
            validatorLabel: AppStrings.name.tr,
            labelText: AppStrings.name.tr,
            hint: AppStrings.nameHint.tr,
          ),
          Utils.hSpace(),
          // Store Name
          CustomTextWholeSalerField(
            onSaved: (value) {
              wholeSalerController.shopName.value = value!;
            },
            validatorLabel: AppStrings.storeName.tr,
            labelText: AppStrings.storeName.tr,
            hint: AppStrings.storeNameHint.tr,
          ),

          Utils.hSpace(),
          // Email(),
          CustomTextWholeSalerField(
            onSaved: (value) {
              wholeSalerController.email.value = value!;
            },
            validatorLabel: AppStrings.email.tr,
            labelText: AppStrings.email.tr,
            hint: AppStrings.emailHint.tr,
          ),
          Utils.hSpace(),

          CustomTextWholeSalerField(
            onSaved: (value) {
              wholeSalerController.password.value = value!;
            },
            labelText: AppStrings.password.tr,
            hint: AppStrings.passwordHint.tr,
            validatorLabel: AppStrings.password.tr,
            isPassword: true,
          ),
          Utils.hSpace(),
          CustomTextWholeSalerField(
            onSaved: (value) {
              wholeSalerController.confirmPassword.value = value!;
            },
            labelText: AppStrings.confirmPassword.tr,
            hint: AppStrings.confirmPasswordHint.tr,
            validatorLabel: AppStrings.confirmPassword.tr,
            isPassword: true,
          ),
          Utils.hSpace(),
          Utils.hSpace(),
          Obx(
            () => AppButtonElevated(
              isLoading: wholeSalerController.isloading.value,
              title: '${AppStrings.signUp.tr}  (${AppStrings.wholesaler.tr})',
              onPress: () {
                wholeSalerController.wholesalerSignUp();
              },
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTextWholeSalerField extends StatelessWidget {
  const CustomTextWholeSalerField({
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
    return GetBuilder<WholeSalerController>(
      init: WholeSalerController(),
      initState: (_) {},
      builder: (_) {
        return TextFormField(
          onSaved: onSaved,
          obscureText: isPassword && _.isobscureText.value,
          validator: (value) {
            return _.validator(value, validatorLabel);
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
