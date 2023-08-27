import 'dart:io';

import 'package:get/get.dart';
import 'package:shaudan_b2b/features/auth/data/repositories/user_repository.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:shaudan_b2b/utils/utils.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();
  RxInt selectedIndex = 0.obs;

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  @override
  void onInit() async {
    super.onInit();
    // UserRepository userRepository = UserRepository();
    //  File image = (await ImagePicker.pickImage(source: ImageSource.gallery)) as File;
    // final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    // final ImagePicker picker = ImagePicker();
    // final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    // await userRepository
    //     .createAccount(
    //   email: "65644",
    //   password: "4545454",
    //   name: "usama",
    //   role: "retailer",
    // )
    //     .then((value) {
    //   Utils.snackBar("Success ", "Success account created ");
    // }).onError((error, stackTrace) {
    //   Utils.snackBar("Error1", error.toString() ?? "Error");
    //   print(error);
    // });

    // firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
    //     .ref('productImages/usmama/${DateTime.now().toString()}');
    // await ref
    //     .putFile(File(
    //   image!.path,
    // ))
    //     .then((value) async {
    //   await value.ref.getDownloadURL().then((value) {
    //     print(value);
    //   });
    //   // _listOfimageUrl!.add(value);
    // }).onError((error, stackTrace) {
    //   print(error);
    // });
    // }
    // );
  } // onInit()
}
