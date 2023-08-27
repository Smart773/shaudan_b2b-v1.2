import 'package:shaudan_b2b/features/retailer/home/data/models/images_model.dart';

class ProductModel {
  int? rating;
  String? sId;
  String? title;
  String? category;
  int? price;
  int? quantity;
  String? description;
  List<Images>? images;
  String? wholeSaler;
  List<String>? tags;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ProductModel(
      {this.rating,
      this.sId,
      this.title,
      this.category,
      this.price,
      this.quantity,
      this.description,
      this.images,
      this.wholeSaler,
      this.tags,
      this.createdAt,
      this.updatedAt,
      this.iV});

  ProductModel.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    sId = json['_id'];
    title = json['title'];
    category = json['category'];
    price = json['price'];
    quantity = json['quantity'];
    description = json['description'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    wholeSaler = json['WholeSaler'];
    tags = json['tags'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rating'] = rating;
    data['_id'] = sId;
    data['title'] = title;
    data['category'] = category;
    data['price'] = price;
    data['quantity'] = quantity;
    data['description'] = description;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    data['WholeSaler'] = wholeSaler;
    data['tags'] = tags;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
