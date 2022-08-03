class BidsModel {
  int? status;
  List<Data>? data;

  BidsModel({this.status, this.data});

  BidsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? productId;
  String? userId;
  String? bidDate;
  double? bidAmount;
  String? email;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
        this.productId,
        this.userId,
        this.bidDate,
        this.bidAmount,
        this.email,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productId = json['product_id'];
    userId = json['user_id'];
    bidDate = json['bid_date'];
    bidAmount = json['bid_amount'];
    email = json['email'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['product_id'] = this.productId;
    data['user_id'] = this.userId;
    data['bid_date'] = this.bidDate;
    data['bid_amount'] = this.bidAmount;
    data['email'] = this.email;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
