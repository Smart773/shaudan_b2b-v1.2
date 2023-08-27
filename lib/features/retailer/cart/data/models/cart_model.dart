import 'package:shaudan_b2b/features/retailer/home/data/models/product_model.dart';

class CartModel {
  String? sId;
  String? user;
  ProductModel? product;
  int? quantity;
  bool? isProductSelectedBool;
  int? iV;

  CartModel(
      {this.sId,
      this.user,
      this.product,
      this.quantity,
      this.isProductSelectedBool,
      this.iV});

  CartModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    product =
        json['product'] != null ? ProductModel.fromJson(json['product']) : null;
    quantity = json['quantity'];
    isProductSelectedBool = json['isProductSelectedBool'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['user'] = user;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    data['quantity'] = quantity;
    data['isProductSelectedBool'] = isProductSelectedBool;
    data['__v'] = iV;
    return data;
  }
}
