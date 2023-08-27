class Contact {
  String? sId;
  String? phoneNumber;
  List<String>? socialMedia;
  int? iV;

  Contact({this.sId, this.phoneNumber, this.socialMedia, this.iV});

  Contact.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    phoneNumber = json['phoneNumber'];
    socialMedia = json['socialMedia'].cast<String>();
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['phoneNumber'] = phoneNumber;
    data['socialMedia'] = socialMedia;
    data['__v'] = iV;
    return data;
  }
}
