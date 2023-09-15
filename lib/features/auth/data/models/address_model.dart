class Address {
  String? sId;
  String? street;
  String? houseNumber;
  String? city;
  String? postalCode;
  String? state;
  String? country;
  String? addressType;
  int? iV;

  Address(
      {this.sId,
      this.street,
      this.houseNumber,
      this.city,
      this.postalCode,
      this.state,
      this.country,
      this.addressType,
      this.iV});

  //.toString
  @override
  String toString() {
    return ' street: $street, houseNumber: $houseNumber, city: $city, postalCode: $postalCode, state: $state, country: $country, ';
  }

  Address.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    street = json['street'];
    houseNumber = json['houseNumber'];
    city = json['city'];
    postalCode = json['postalCode'];
    state = json['state'];
    country = json['country'];
    addressType = json['addressType'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['street'] = street;
    data['houseNumber'] = houseNumber;
    data['city'] = city;
    data['postalCode'] = postalCode;
    data['state'] = state;
    data['country'] = country;
    data['addressType'] = addressType;
    data['__v'] = iV;
    return data;
  }
}
