import 'package:shaudan_b2b/features/retailer/home/data/models/product_model.dart';

class OrderModel {
  String? sId;
  List<OrderItem>? orderItem;
  String? ordername;
  String? shippingAddress;
  String? billingAddress;
  String? retailerUserId;
  String? wholesalerUserId;
  String? contact;
  int? totalAmmount;
  String? paymentMethod;
  int? deliveryCharges;
  String? orderStatus;
  int? iV;
  String? createdAt;
  String? updatedAt;
  String? id;

  OrderModel(
      {this.sId,
      this.orderItem,
      this.ordername,
      this.shippingAddress,
      this.billingAddress,
      this.retailerUserId,
      this.wholesalerUserId,
      this.contact,
      this.totalAmmount,
      this.paymentMethod,
      this.deliveryCharges,
      this.orderStatus,
      this.iV,
      this.createdAt,
      this.updatedAt,
      this.id});

  OrderModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['orderItem'] != null) {
      orderItem = <OrderItem>[];
      json['orderItem'].forEach((v) {
        orderItem!.add(OrderItem.fromJson(v));
      });
    }
    ordername = json['ordername'];
    shippingAddress = json['shippingAddress'];
    billingAddress = json['billingAddress'];
    retailerUserId = json['retailerUserId'];
    wholesalerUserId = json['wholesalerUserId'];
    contact = json['contact'];
    totalAmmount = json['totalAmmount'];
    paymentMethod = json['paymentMethod'];
    deliveryCharges = json['deliveryCharges'];
    orderStatus = json['orderStatus'];
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (orderItem != null) {
      data['orderItem'] = orderItem!.map((v) => v.toJson()).toList();
    }
    data['ordername'] = ordername;
    data['shippingAddress'] = shippingAddress;
    data['billingAddress'] = billingAddress;
    data['retailerUserId'] = retailerUserId;
    data['wholesalerUserId'] = wholesalerUserId;
    data['contact'] = contact;
    data['totalAmmount'] = totalAmmount;
    data['paymentMethod'] = paymentMethod;
    data['deliveryCharges'] = deliveryCharges;
    data['orderStatus'] = orderStatus;
    data['__v'] = iV;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['id'] = id;
    return data;
  }
}

class OrderItem {
  String? sId;
  int? quantity;
  ProductModel? product;
  int? iV;

  OrderItem({this.sId, this.quantity, this.product, this.iV});

  OrderItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    quantity = json['quantity'];
    product =
        json['Product'] != null ? ProductModel.fromJson(json['Product']) : null;
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['quantity'] = quantity;
    if (product != null) {
      data['Product'] = product!.toJson();
    }
    data['__v'] = iV;
    return data;
  }
}

// class Product {
//   String? sId;
//   String? title;
//   String? category;
//   int? price;
//   List<Images>? images;
//   List<String>? tags;
//   String? wholeSaler;

//   Product(
//       {this.sId,
//       this.title,
//       this.category,
//       this.price,
//       this.images,
//       this.tags,
//       this.wholeSaler});

//   Product.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     title = json['title'];
//     category = json['category'];
//     price = json['price'];
//     if (json['images'] != null) {
//       images = <Images>[];
//       json['images'].forEach((v) {
//         images!.add(new Images.fromJson(v));
//       });
//     }
//     tags = json['tags'].cast<String>();
//     wholeSaler = json['WholeSaler'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['title'] = this.title;
//     data['category'] = this.category;
//     data['price'] = this.price;
//     if (this.images != null) {
//       data['images'] = this.images!.map((v) => v.toJson()).toList();
//     }
//     data['tags'] = this.tags;
//     data['WholeSaler'] = this.wholeSaler;
//     return data;
//   }
// }

