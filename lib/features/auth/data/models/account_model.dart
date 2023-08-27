class AccountModel {
  String? accesstoken;
  String? accountId;

  AccountModel({this.accesstoken, this.accountId});

  AccountModel.fromJson(Map<String, dynamic> json) {
    accesstoken = json['accesstoken'];
    accountId = json['account_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accesstoken'] = accesstoken;
    data['account_id'] = accountId;
    return data;
  }
}
