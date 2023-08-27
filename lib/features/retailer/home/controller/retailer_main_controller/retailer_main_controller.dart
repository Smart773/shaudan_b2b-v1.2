import 'package:get/get.dart';

class RetailerMainController extends GetxController {
  static RetailerMainController get to => Get.find();
  RxInt selectedIndex = 0.obs;
  RxInt lastSelected = 0.obs;
  RxBool isCartSelected = false.obs;

  
}
