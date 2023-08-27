import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:shaudan_b2b/cores/services/login_storage.dart';
import 'package:shaudan_b2b/cores/services/network_api_service.dart';
import 'package:shaudan_b2b/features/auth/data/models/account_model.dart';
import 'package:shaudan_b2b/features/auth/data/models/user_model.dart';
import 'package:shaudan_b2b/features/retailer/home/data/models/images_model.dart';
import 'package:shaudan_b2b/res/app_url/app_url.dart';
import 'package:http_parser/http_parser.dart';

import '../../../retailer/home/data/models/product_model.dart';

class UploadRepository {
  final NetworkApiSerive _api = NetworkApiSerive();

  Future<Images> uploadImages({
    //list of images
    required Uint8List? images,
  }) async {
    try {
      //
      FormData formData = FormData.fromMap({
        "image": MultipartFile.fromBytes(
          images!,
          filename: "image.jpg",
          contentType: MediaType("image", "jpg"),
        ),
      });
      print(formData.fields);
      final response = await _api.postApi(formData, "upload/image");

      // UserModel userModel = UserModel.fromJson(response);
      Images imagesModel = Images.fromJson(response);
      print(imagesModel.toJson());
      return imagesModel;
      // return accountMode;
      // return userModel;
    } //try ()
    catch (e) {
      rethrow;
    } // catch
  } // createAccount()

  Future<ProductModel> uploadProduct({
    required String productName,
    required String productDescription,
    required String productPrice,
    required String productQuantity,
    required List<String> productTags,
    required List<Images> images,
    required String productCategory,
  }) async {
    try {
      //

      // "title": "product 5",
      // "category": "cold drinks",
      // "price": 160,
      // "quantity": 10,
      // "WholeSaler":"5f9e1b7b9c9b7b1e0c3b3b1c",
      // "description": "Coke 1.5 liter is a popular carbonated soft drink product offered by the Coca-Cola Company.",
      // "images":[
      //     {
      //         "url": "http://res.cloudinary.com/dz79thnth/image/upload/v1690145905/images/tjdcphn2uontbmaj8vls.jpg",
      //         "id": "images/tjdcphn2uontbmaj8vls"
      //     },
      //     {
      //         "url": "http://res.cloudinary.com/dz79thnth/image/upload/v1690145905/images/nadbpgo7i7k6ps2ymxk0.jpg",
      //         "id": "images/nadbpgo7i7k6ps2ymxk0"
      //     },
      //     {
      //         "url": "http://res.cloudinary.com/dz79thnth/image/upload/v1690145906/images/ngx8qnoprrdlkyiuu4qg.png",
      //         "id": "images/ngx8qnoprrdlkyiuu4qg"
      //     }
      // ],
      // "tags": [
      //     "tag1",
      //     "tag2"
      // ]

      final wholeSalerId = await LoginPref.getUserId();
      final response = await _api.postApi({
        "title": productName,
        "category": productCategory,
        "price": productPrice,
        "quantity": productQuantity,
        "WholeSaler": wholeSalerId,
        "description": productDescription,
        "images": images.map((e) => e.toJson()).toList(),
        "tags": productTags,
      }, "products");

      // Images imagesModel = Images.fromJson(response);
      ProductModel productModel = ProductModel.fromJson(response);
      // print(imagesModel.toJson());
      print(productModel.toJson());
      return productModel;
      // return imagesModel;
      // return accountMode;
      // return userModel;
    } //try ()
    catch (e) {
      rethrow;
    } // catch
  } // createAccount()
} // UserRepository
