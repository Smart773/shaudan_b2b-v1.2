import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shaudan_b2b/res/colors/AppColors.dart';

class AccountHeaderWidget extends StatelessWidget {
  const AccountHeaderWidget({
    super.key,
    required this.size,
    required this.storeName,
    required this.title,
    required this.phoneNo,
    this.img = "",
  });

  final Size size;
  final String storeName;
  final String title;
  final String phoneNo;
  final String? img;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30.0,
            vertical: 8.0,
          ),
          child: img == ""
              ? CircleAvatar(
                  radius: size.width >= 650 ? 55 : 35,
                  backgroundColor: AppColors.whiteColor,
                  child: Icon(
                    LineIcons.userNinja,
                    size: size.width >= 650 ? 55 : 35,
                  ),
                )
              : CircleAvatar(
                  radius: size.width >= 650 ? 55 : 35,
                  backgroundColor: AppColors.whiteColor,
                  backgroundImage: NetworkImage(img!),
                ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$storeName Store',
                style: TextStyle(
                  fontSize: size.width >= 650 ? 35 : 25,
                  letterSpacing: 3.5,
                  fontWeight: FontWeight.bold,
                  color: AppColors.grey3Color,
                ),
              ),
              Text(
                '$title ',
                style: const TextStyle(
                    fontSize: 15,
                    letterSpacing: 2.5,
                    color: AppColors.grey4Color),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                phoneNo,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.grey4Color,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
