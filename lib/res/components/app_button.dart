import 'package:flutter/material.dart';
import 'package:shaudan_b2b/res/colors/AppColors.dart';

class AppButtonElevated extends StatelessWidget {
  const AppButtonElevated({
    super.key,
    required this.title,
    required this.onPress,
    this.height = 52,
    this.width = 50,
    this.isLoading = false,
  });
  final String title;
  final Function onPress;
  final bool isLoading;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width, height),
      ),
      onPressed: isLoading
          ? () {}
          : () {
              onPress();
            },
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColors.whiteColor,
              ),
            )
          : Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
}

class AppButtonOutlined extends StatelessWidget {
  const AppButtonOutlined({
    super.key,
    required this.title,
    required this.onPress,
    this.height = 52,
    this.width = 50,
    this.isLoading = false,
  });
  final String title;
  final Function onPress;
  final double height;
  final double width;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: Size(width, height),
      ),
      onPressed: isLoading
          ? () {}
          : () {
              onPress();
            },
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            )
          : Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
    );
  }
}
