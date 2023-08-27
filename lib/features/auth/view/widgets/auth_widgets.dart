import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaudan_b2b/features/auth/controllers/auth/authController.dart';
import 'package:shaudan_b2b/res/Images/image_strings.dart';
import 'package:shaudan_b2b/res/colors/AppColors.dart';
import 'package:shaudan_b2b/res/localizations/app_Strings.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          AppImagesStrings.logoShaudan,
          height: size.width > 650 ? 50 : 30,
        ),
        //Swith Language
        const Spacer(),
        // Switch button for language
        Row(
          children: [
            Text(
              AppStrings.english.tr,
              style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: size.width > 350 ? 16 : 12,
              ),
            ),
            Switch(
              value: Get.locale.toString() == 'ur_PK' ? true : false,
              onChanged: (bool value) {
                if (value) {
                  Get.updateLocale(const Locale('ur', 'PK'));
                } else {
                  Get.updateLocale(const Locale('en', 'US'));
                }
              },
              activeColor: AppColors.whiteColor,
              inactiveThumbColor: AppColors.whiteColor,
              inactiveTrackColor: AppColors.whiteColor,
            ),
            Text(
              AppStrings.urdu.tr,
              style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: size.width > 350 ? 16 : 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class JoinMessageText extends StatelessWidget {
  const JoinMessageText({
    super.key,
    required this.size,
  });

  final Size size;
  @override
  Widget build(BuildContext context) {
    return Text(
      AppStrings.startMessage.tr,
      style: Get.locale.toString() == 'ur_PK'
          ? Theme.of(context).textTheme.displayMedium?.copyWith(
              color: AppColors.whiteColor,
              fontWeight: FontWeight.bold,
              fontSize: size.width > 880 ? 45 : 30)
          : (size.width > 880)
              ? Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: AppColors.whiteColor, fontWeight: FontWeight.bold)
              : Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: AppColors.whiteColor, fontWeight: FontWeight.bold),
    );
  }
}

class AuthLoginSignUpCard extends StatelessWidget {
  AuthLoginSignUpCard({
    super.key,
    required this.pages,
  });

  final List<Widget> pages;
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Card(
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            child: Column(
              children: [
                BottomNavigationBar(
                  currentIndex: authController.selectedIndex.value,
                  elevation: 0,
                  onTap: (int index) {
                    authController.selectedIndex.value = index;
                  },
                  items: [
                    BottomNavigationBarItem(
                      icon: const Icon(Icons.meeting_room_rounded),
                      label: AppStrings.login.tr,
                    ),
                    BottomNavigationBarItem(
                      icon: const Icon(Icons.person_add),
                      label: AppStrings.signUp.tr,
                    ),
                  ],
                ),
                Expanded(
                  child: pages.elementAt(authController.selectedIndex.value),
                ),
              ],
            ),
          ),
        ));
  }
}
