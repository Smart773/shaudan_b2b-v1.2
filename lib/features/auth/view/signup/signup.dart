import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaudan_b2b/features/auth/controllers/signup/signup_controller.dart';
import 'package:shaudan_b2b/features/auth/view/signup/retailer_form.dart';
import 'package:shaudan_b2b/features/auth/view/widgets/signup_widgets.dart';
import 'package:shaudan_b2b/features/auth/view/signup/wholesaler_form.dart';
import 'package:shaudan_b2b/res/localizations/app_Strings.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  final String title = 'Sign Up';
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final List<Widget> pages = <Widget>[
      const Retailer(),
      const WholeSaler(),
    ];
    final SignupController signupController = Get.put(SignupController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   children: [
              //     const Spacer(),
              //     GetBuilder<SignupController>(
              //       init: SignupController(),
              //       builder: (_) {
              //         return InkWell(
              //           onTap: () {
              //             _.pickProfilePic();
              //           },
              //           child: Avatar(size: size, imageBytes: _.imageBytes),
              //         );
              //       },
              //     ),
              //   ],
              // ),
              Text(
                AppStrings.signUpAs.tr,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Obx(() => Expanded(
                        child: RadioBox(
                          title: AppStrings.retailer.tr,
                          userType: UserType.retailer,
                          selectedUser: signupController.selectedUserType.value,
                          onPress: (value) {
                            signupController.selectedUserType.value =
                                value as UserType;
                          },
                        ),
                      )),
                  SizedBox(
                    width: size.width * 0.01,
                  ),
                  Obx(() => Expanded(
                        child: RadioBox(
                          title: AppStrings.wholesaler.tr,
                          userType: UserType.wholesaler,
                          selectedUser: signupController.selectedUserType.value,
                          onPress: (value) {
                            signupController.selectedUserType.value =
                                value as UserType;
                          },
                        ),
                      )),
                ],
              ),
              Obx(() => pages[signupController.selectedUserType.value.index]),
            ],
          ),
        ),
      ),
    );
  }
}
