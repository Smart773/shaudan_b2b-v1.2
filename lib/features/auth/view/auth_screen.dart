import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaudan_b2b/features/auth/view/login/login.dart';
import 'package:shaudan_b2b/features/auth/view/signup/signup.dart';
import 'package:shaudan_b2b/features/auth/view/widgets/auth_widgets.dart';
import 'package:shaudan_b2b/res/Images/image_strings.dart';
import 'package:shaudan_b2b/res/colors/AppColors.dart';
import 'package:lottie/lottie.dart';
import 'package:shaudan_b2b/utils/utils.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Localization fron getx
    debugPrint(Get.locale.toString());
    final Size size = MediaQuery.of(context).size;
    final List<Widget> pages = <Widget>[
      const LoginScreen(),
      const SignUpScreen(),
    ];
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: MainAppBar(size: size)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: ScrollWithIntrinsicHeight(
          constraints: BoxConstraints(
              maxHeight: size.height - kToolbarHeight - 20 - size.height * 0.1),
          child: Row(
            children: [
              size.width > 650
                  ? Expanded(
                      flex: size.width > 1050 ? 2 : 1,
                      child: SizedBox(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image(
                            image: const AssetImage(
                                AppImagesStrings.completeHeadLogo),
                            width: size.width * 0.1,
                            height: size.height * 0.1,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          JoinMessageText(size: size),
                          Lottie.asset(AppImagesStrings.animation2,
                              width: size.width * 0.5,
                              height: size.height * 0.5),
                        ],
                      )))
                  : const SizedBox(),
              Expanded(
                child: AuthLoginSignUpCard(pages: pages),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
