import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shaudan_b2b/features/wholesaler/update_product/controller/update_product_controller.dart';
import 'package:shaudan_b2b/features/wholesaler/upload_product/controller/upload_Controller.dart';
import 'package:shaudan_b2b/res/colors/AppColors.dart';
import 'package:shaudan_b2b/res/localizations/app_Strings.dart';
import 'package:shaudan_b2b/utils/utils.dart';

class UpdateProduct extends StatelessWidget {
  const UpdateProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final UpdateProductController updateProductController =
        Get.put(UpdateProductController());
    return Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.uploadProduct.tr),
          centerTitle: true,
        ),
        bottomSheet: InkWell(
          onTap: () {
            // UpdateProductController.uploadImages();
            updateProductController.UploadProductPress();
          },
          child: Container(
            height: size.height * 0.08,
            width: double.infinity,
            color: AppColors.primaryColor,
            child: Center(
              child: Text(
                AppStrings.uploadProduct.tr,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        body: Form(
          key: updateProductController.formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GetBuilder<UpdateProductController>(
                    init: UpdateProductController(),
                    initState: (_) {},
                    builder: (_) {
                      return Visibility(
                        visible: _.oldImages.isNotEmpty,
                        child:
                            const UploadFiledTitle(title: "Product old Images"),
                      );
                    },
                  ),
                  ImageListView2(size: size),
                  const UploadFiledTitle(title: "Product New Images"),
                  ImageListView(size: size),
                  const UploadFiledTitle(title: "Product Name"),
                  UploadTextFiled(
                      textInputType: TextInputType.name,
                      textEditingController:
                          updateProductController.productNameController.value,
                      validator: updateProductController.validator),
                  const UploadFiledTitle(title: "Product Quantity"),
                  UploadTextFiled(
                      textInputType: TextInputType.number,
                      textEditingController: updateProductController
                          .productQuantityController.value,
                      validator: updateProductController.validator),
                  const UploadFiledTitle(title: "Product Price"),
                  UploadTextFiled(
                      textInputType: TextInputType.number,
                      textEditingController:
                          updateProductController.productPriceController.value,
                      validator: updateProductController.validator),
                  const UploadFiledTitle(title: "Product Category"),
                  // Drop down list
                  // Select Category as hint
                  Obx(() => DropdownButtonFormField<String>(
                        validator: (value) {
                          if (value == '') {
                            return 'Please select category';
                          }
                          return null;
                        },
                        value: updateProductController.selectedCategory.value,
                        items: [
                          const DropdownMenuItem<String>(
                            value: '',
                            child: Text('Select Category'), // Hint
                          ),
                          ...updateProductController.category.map((e) {
                            return DropdownMenuItem<String>(
                              value: e,
                              child: Text(e),
                            );
                          }).toList(),
                        ],
                        onChanged: (newValue) {
                          updateProductController.selectedCategory.value =
                              newValue!;
                          updateProductController.update();
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      )),
                  const SizedBox(height: 20),
                  // Text('Selected Item: $selectedValue'),
                  TagsList(size: size),
                  const UploadFiledTitle(title: "Product Tags"),
                  Row(
                    children: [
                      Flexible(
                          child: TextFormField(
                        validator: (value) {
                          if (updateProductController.tags.isEmpty) {
                            return 'Zero tags Added';
                          }
                          return null;
                        },
                        controller:
                            updateProductController.productTagsController.value,
                      )),
                      TagUpdateButton(
                          updateController: updateProductController),
                    ],
                  ),
                  const UploadFiledTitle(title: "Product Description"),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                    controller: updateProductController
                        .productDescriptionController.value,
                    maxLines: 3,
                    maxLength: 1000,
                  ),
                  Utils.hSpace(),
                  Utils.hSpace(),
                  Utils.hSpace(),
                  Utils.hSpace(),
                  Utils.hSpace(),
                  Utils.hSpace(),
                ],
              ),
            ),
          ),
        ));
  }
}

///Widgets Starts Here
class UploadTextFiled extends StatelessWidget {
  const UploadTextFiled({
    super.key,
    required this.textInputType,
    required this.textEditingController,
    required this.validator,
  });

  final TextInputType textInputType;
  final TextEditingController textEditingController;
  final Function(String value) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      controller: textEditingController,
      validator: (value) {
        return validator(value!);
      },
      inputFormatters: [
        if (textInputType == TextInputType.number)
          FilteringTextInputFormatter.digitsOnly,
      ],
    );
  }
}

class UploadFiledTitle extends StatelessWidget {
  const UploadFiledTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        color: AppColors.primaryColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class TagUpdateButton extends StatelessWidget {
  const TagUpdateButton({
    super.key,
    required this.updateController,
  });

  final UpdateProductController updateController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primaryColor,
        ),
        child: IconButton(
          onPressed: () {
            if (updateController.productTagsController.value.text.isEmpty) {
              return;
            }
            updateController.tags
                .add(updateController.productTagsController.value.text);
            updateController.productTagsController.value.clear();
            updateController.update();
          },
          icon: const Icon(
            Icons.send,
            color: AppColors.whiteColor,
          ),
        ),
      ),
    );
  }
}

class TagsList extends StatelessWidget {
  const TagsList({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpdateProductController>(
      init: UpdateProductController(),
      initState: (_) {},
      builder: (_) {
        return Visibility(
          visible: _.tags.isNotEmpty,
          child: SizedBox(
            height: size.height * 0.1,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        height: 25,
                        //width size depend on text size
                        width: _.tags[index].length * 15.0,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.primaryColor, width: 2),
                          color: AppColors.primaryColor50,
                        ),
                        child: Center(
                          child: Text(
                            _.tags[index],
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 25,
                        //width size depend on text size
                        width: 30,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.primaryColor, width: 2),
                          color: AppColors.primaryColor50,
                        ),
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              _.tags.removeAt(index);
                              _.update();
                            },
                            child: const Icon(
                              Icons.close,
                              color: AppColors.primaryColor,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: _.tags.length,
            ),
          ),
        );
      },
    );
  }
}

class ImageListView extends StatelessWidget {
  const ImageListView({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpdateProductController>(
      init: UpdateProductController(),
      initState: (_) {},
      builder: (_) {
        return InkWell(
          onTap: () {
            _.pickListOfImagesforProduct();
          },
          child: _.isImageSelected.value
              ? SizedBox(
                  height: size.height * 0.2,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: _.images.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        // stack is used to show delete icon on image
                        child: Stack(
                          children: [
                            Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.primaryColor, width: 2),
                                color: AppColors.primaryColor50,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipPath(
                                clipper: ShapeBorderClipper(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Image.memory(
                                  _.images[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: InkWell(
                                onTap: () {
                                  _.images.removeAt(index);
                                  if (_.images.isEmpty) {
                                    _.isImageSelected.value = false;
                                  }
                                  _.update();
                                },
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              : EmptyImagePlaceHolder(size: size),
        );
      },
    );
  }
}

class ImageListView2 extends StatelessWidget {
  const ImageListView2({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpdateProductController>(
      init: UpdateProductController(),
      initState: (_) {},
      builder: (_) {
        return Visibility(
          visible: _.oldImages.isNotEmpty,
          child: InkWell(
            onTap: () {},
            child: SizedBox(
              height: size.height * 0.2,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: _.oldImages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    // stack is used to show delete icon on image
                    child: Stack(
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.primaryColor, width: 2),
                            color: AppColors.primaryColor50,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipPath(
                            clipper: ShapeBorderClipper(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Image.network(
                              _.oldImages[index].url!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              _.oldImages.removeAt(index);

                              _.update();
                            },
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class EmptyImagePlaceHolder extends StatelessWidget {
  const EmptyImagePlaceHolder({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.2,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryColor, width: 2),
        color: AppColors.primaryColor50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_a_photo,
            size: 50,
            color: AppColors.primaryColor,
          ),
          Text(
            "Add Product Images",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      )),
    );
  }
}
