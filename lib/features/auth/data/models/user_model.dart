import 'package:shaudan_b2b/features/auth/data/models/address_model.dart';
import 'package:shaudan_b2b/features/auth/data/models/contact_model.dart';

class UserModel {
  String? sId;
  String? name;
  int? age;
  Account? account;
  Address? address;
  Contact? contact;
  String? dOB;
  String? role;
  String? createdAt;
  String? updatedAt;
  int? iV;

  UserModel(
      {this.sId,
      this.name,
      this.age,
      this.account,
      this.address,
      this.contact,
      this.dOB,
      this.role,
      this.createdAt,
      this.updatedAt,
      this.iV});

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    age = json['age'];
    account =
        json['account'] != null ? Account.fromJson(json['account']) : null;
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    contact =
        json['contact'] != null ? Contact.fromJson(json['contact']) : null;
    dOB = json['DOB'];
    role = json['role'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['age'] = age;
    if (account != null) {
      data['account'] = account!.toJson();
    }
    if (address != null) {
      data['address'] = address!.toJson();
    }
    if (contact != null) {
      data['contact'] = contact!.toJson();
    }
    data['DOB'] = dOB;
    data['role'] = role;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Account {
  String? sId;
  String? email;

  Account({this.sId, this.email});

  Account.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['email'] = email;
    return data;
  }
}
