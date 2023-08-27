import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// UserType? selectedUserType = UserType.retailer;
enum UserType { retailer, wholesaler }

class SignupController extends GetxController {
  static SignupController get to => Get.find();
  final selectedUserType = UserType.retailer.obs;
  RxBool isAgreed = false.obs;
  Uint8List? imageBytes;
  RxBool isImageSelected = false.obs;

  //pickprofilepic
  Future<void> pickProfilePic() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
      if (result != null) {
        print(result.files.first.name);

        //if Web(),
        if (kIsWeb) {
          imageBytes = result.files.first.bytes;
        } else {
          File file = File(result.files.first.path!);
          imageBytes = file.readAsBytesSync();
        }
        print(result.files.first.bytes);
        isImageSelected.value = true;
        update();
      } else {
        // User canceled the picker
      }
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
  }
}
