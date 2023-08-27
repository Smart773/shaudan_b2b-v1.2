import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaudan_b2b/features/auth/controllers/login/login_controller.dart';
import 'package:shaudan_b2b/res/components/app_button.dart';
import 'package:shaudan_b2b/res/localizations/app_Strings.dart';
import 'package:shaudan_b2b/utils/utils.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = LoginController.to;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: SingleChildScrollView(
        child: Form(
          key: loginController.key.value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.loginScreenTitle.tr,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Utils.hSpace(),
              CustomTextLoginField(
                onSaved: (value) {
                  loginController.email.value = value!;
                },
                validatorLabel: AppStrings.email.tr,
                labelText: AppStrings.email.tr,
                hint: AppStrings.emailHint.tr,
              ),
              Utils.hSpace(),
              CustomTextLoginField(
                onSaved: (value) {
                  loginController.password.value = value!;
                },
                labelText: AppStrings.password.tr,
                hint: AppStrings.passwordHint.tr,
                validatorLabel: AppStrings.password.tr,
                isPassword: true,
              ),
              Utils.hSpace(),
              Obx(
                () => AppButtonElevated(
                  isLoading: loginController.isloading.value,
                  title: AppStrings.login.tr,
                  onPress: () {
                    loginController.login();
                  },
                  width: double.infinity,
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class CustomTextLoginField extends StatelessWidget {
  const CustomTextLoginField({
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
    return GetBuilder<LoginController>(
      init: LoginController(),
      initState: (_) {},
      builder: (_) {
        return TextFormField(
          onSaved: onSaved,
          obscureText: isPassword && _.isobscureText.value,
          // controller: _passwordController,
          // icon at the end of the textfield
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
