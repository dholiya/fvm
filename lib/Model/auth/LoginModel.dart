class LoginModel {
  int? status;
  String? accessToken;
  Data? data;

  LoginModel({this.status, this.accessToken, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    accessToken = json['accessToken'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['accessToken'] = this.accessToken;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? lastName;
  String? firstName;
  String? gender;
  String? dob;
  bool? isSeller;
  String? email;
  String? password;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
      this.lastName,
      this.firstName,
      this.gender,
      this.dob,
      this.isSeller,
      this.email,
      this.password,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    lastName = json['last_name'];
    firstName = json['first_name'];
    gender = json['gender'];
    dob = json['dob'];
    isSeller = json['is_seller'];
    email = json['email'];
    password = json['password'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['last_name'] = this.lastName;
    data['first_name'] = this.firstName;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['is_seller'] = this.isSeller;
    data['email'] = this.email;
    data['password'] = this.password;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
