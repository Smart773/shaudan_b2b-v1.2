class RetailerModel {
  String? user;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  RetailerModel({this.user, this.sId, this.createdAt, this.updatedAt, this.iV});

  RetailerModel.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
