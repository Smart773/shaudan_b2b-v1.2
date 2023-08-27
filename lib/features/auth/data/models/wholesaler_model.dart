class WholeSalerModel {
  String? user;
  String? store;
  String? sId;
  int? iV;

  WholeSalerModel({this.user, this.store, this.sId, this.iV});

  WholeSalerModel.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    store = json['store'];
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user;
    data['store'] = store;
    data['_id'] = sId;
    data['__v'] = iV;
    return data;
  }
}
