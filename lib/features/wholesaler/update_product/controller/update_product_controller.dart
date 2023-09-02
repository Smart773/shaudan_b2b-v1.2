import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shaudan_b2b/features/retailer/home/data/models/images_model.dart';
import 'package:shaudan_b2b/features/retailer/home/data/models/product_model.dart';
import 'package:shaudan_b2b/features/wholesaler/home/controller/wholesaler_main_controller/wholesaler_main_controller.dart';
import 'package:shaudan_b2b/features/wholesaler/store/controller/store_controller.dart';
import 'package:shaudan_b2b/features/wholesaler/upload_product/data/upload_repository.dart';

class UpdateProductController extends GetxController {
  static UpdateProductController get to => Get.find();
  ProductModel? productModel;
  List<Uint8List> images = [];
  List<Images> imagesFile = [];
  //
  // old/pre Images
  List<Images> oldImages = [];
  // category List
  List<String> category = [
    "Grocery",
    "Crocery",
    "Medicine",
    "Electronics",
    "Clothes",
    "Shoes",
    "Bags",
  ];
  RxString selectedCategory = "".obs;
  //List of images in File
  List<String> tags = [];
  RxBool isImageSelected = false.obs;
  Rx<TextEditingController> productNameController = TextEditingController().obs;
  Rx<TextEditingController> productDescriptionController =
      TextEditingController().obs;
  Rx<TextEditingController> productPriceController =
      TextEditingController().obs;
  Rx<TextEditingController> productQuantityController =
      TextEditingController().obs;
  Rx<TextEditingController> productTagsController = TextEditingController().obs;
  Rx<TextEditingController> productCategoryController =
      TextEditingController().obs;
  // form key
  final formKey = GlobalKey<FormState>();

  // clearAllFileds
  void clearAllFileds() {
    productNameController.value.clear();
    productDescriptionController.value.clear();
    productPriceController.value.clear();
    productQuantityController.value.clear();
    productTagsController.value.clear();
    productCategoryController.value.clear();
    imagesFile.clear();
    images.clear();
    isImageSelected.value = false;
    selectedCategory.value = "";
    tags.clear();
    update();
  }

  @override
  void onInit() {
    super.onInit();
    print("onInit");
    productModel = StoreController.productDetail;
    print(productModel!.tags!.length);
    fillData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    print("onClose");
    clearAllFileds();
  }

  //dispose
  @override
  void dispose() {
    super.dispose();
    clearAllFileds();
  }

  // fill the data from productModel to all the variables
  void fillData() {
    productNameController.value.text = productModel!.title!;
    productDescriptionController.value.text = productModel!.description!;
    productPriceController.value.text = productModel!.price.toString();
    productQuantityController.value.text = productModel!.quantity.toString();
    productCategoryController.value.text = productModel!.category!;
    selectedCategory.value = productModel!.category!;
    // tags = productModel!.tags!;
    for (int i = 0; i < productModel!.tags!.length; i++) {
      tags.add(productModel!.tags![i]);
    }
    for (int i = 0; i < productModel!.images!.length; i++) {
      oldImages.add(productModel!.images![i]);
    }
    update();
  }

  //onUploadpress
  void UploadProductPress() async {
    if (formKey.currentState!.validate()) {
      if (images.isEmpty && oldImages.isEmpty) {
        Get.snackbar("Error", "Please select images");
        return;
      }
      // loading popup covring Whole Screen
      Get.dialog(
        const Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false,
        barrierColor: Colors.white.withOpacity(0.5),
      );
      if (images.isNotEmpty) {
        await _uploadImage().catchError(
          (e) {
            Get.back();
            Get.snackbar("Error", e.toString());
          },
        );
      }
      imagesFile.addAll(oldImages);
      if (imagesFile.isNotEmpty) {
        print("here");
        await _updateProduct().then((value) {
          Get.back();
          Get.snackbar("Success", "Product Updated Successfully");
          // move to home screen
          Get.offAllNamed("/wholesaler");
        }).catchError(
          (e) {
            Get.back();
            Get.snackbar("Error", e.toString());
          },
        );
      }
    } else {
      print("not validated");
    }
  }

// validtor
  validator(String value) {
    if (value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  ////////////////picklistOfImagesforProduct////////////////////////////

//////
  void uploadImages() async {
    await _uploadImage();
  }

  void uploadProduct() async {
    await _updateProduct();
  }

  //picklistOfImagesforProduct
  Future<void> pickListOfImagesforProduct() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      );
      if (result != null) {
        print(result.files.first.name);

        //if Web(),
        if (kIsWeb) {
          images = result.files.map((e) => e.bytes!).toList();
        } else {
          images =
              result.files.map((e) => File(e.path!).readAsBytesSync()).toList();
        }
        isImageSelected.value = true;
        update();
      } else {
        // User canceled the picker
      }
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
  }

  Future<void> _uploadImage() async {
    UploadRepository uploadRepository = UploadRepository();
    // await uploadRepository.uploadImages(images: images);
    for (int i = 0; i < images.length; i++) {
      Images imagesModel =
          await uploadRepository.uploadImages(images: images[i]);

      imagesFile.add(imagesModel);
    }
    print(imagesFile);
  }

  Future<void> _updateProduct() async {
    UploadRepository uploadRepository = UploadRepository();
    await uploadRepository.updateProduct(
      productId: productModel!.sId!,
      productName: productNameController.value.text,
      productDescription: productDescriptionController.value.text,
      productPrice: productPriceController.value.text,
      productQuantity: productQuantityController.value.text,
      productTags: tags,
      images: imagesFile,
      productCategory: selectedCategory.value,
    );
  }
}
