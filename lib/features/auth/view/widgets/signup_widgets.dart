import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shaudan_b2b/features/auth/controllers/signup/signup_controller.dart';
import 'package:shaudan_b2b/res/colors/AppColors.dart';

class RadioBox extends StatelessWidget {
  const RadioBox({
    super.key,
    required this.title,
    required this.userType,
    required this.selectedUser,
    required this.onPress,
  });

  final UserType? userType;
  final UserType? selectedUser;
  final Function(Object? p1) onPress;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPress(userType);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: selectedUser == userType
              ? AppColors.primaryColor50
              : AppColors.grayColor10,
          border: Border.all(
              color: selectedUser == userType
                  ? AppColors.primaryColor
                  : AppColors.greyColor,
              width: 1.0),
        ),
        child: Row(children: [
          SizedBox(
            height: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Radio(
                  value: userType,
                  groupValue: selectedUser,
                  onChanged: (value) {
                    onPress(value);
                  },
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title),
            ],
          ),
        ]),
      ),
    );
  }
}

class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    required this.size,
    required this.imageBytes,
  });

  final Size size;
  final Uint8List? imageBytes;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size.width > 400 ? 50.0 : 35,
      backgroundColor: Theme.of(context).primaryColor,
      backgroundImage: imageBytes != null
          ? MemoryImage(imageBytes!)
          : Image.network(
              'https://images.unsplash.com/photo-1516617442634-75371039cb3a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cGljc2FydCUyMGJhY2tncm91bmR8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60',
            ).image,
      child: Align(
        alignment: Alignment.bottomRight,
        child: CircleAvatar(
          radius: size.width > 400 ? 15.0 : 10.0,
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(
            LineIcons.edit,
            color: Colors.white,
            size: 15,
          ),
        ),
      ),
    );
  }
}
