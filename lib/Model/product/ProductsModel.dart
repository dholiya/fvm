class ProductsModel {
  int? status;
  List<ProductsModelData>? data;

  ProductsModel({this.status, this.data});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ProductsModelData>[];
      json['data'].forEach((v) {
        data!.add(new ProductsModelData.fromJson(v));
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

class ProductsModelData {
  List<String>? images;
  List<String>? tag;
  String? sId;
  String? name;
  String? shortDescription;
  String? longDescription;
  int? basePrice;
  String? category;
  String? locationId;
  String? bidEndDate;
  int? currentHighestBid;
  String? sellerId;
  String? bids;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ProductsModelData(
      {this.images,
        this.tag,
        this.sId,
        this.name,
        this.shortDescription,
        this.longDescription,
        this.basePrice,
        this.category,
        this.locationId,
        this.bidEndDate,
        this.currentHighestBid,
        this.sellerId,
        this.bids,
        this.createdAt,
        this.updatedAt,
        this.iV});

  ProductsModelData.fromJson(Map<String, dynamic> json) {
    images = json['images'].cast<String>();
    tag = json['tag'].cast<String>();
    sId = json['_id'];
    name = json['name'];
    shortDescription = json['short_description'];
    longDescription = json['long_description'];
    basePrice = json['base_price'];
    category = json['category'];
    locationId = json['location_id'];
    bidEndDate = json['bid_end_date'];
    currentHighestBid = json['current_highest_bid'];
    sellerId = json['seller_id'];
    bids = json['bids'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['images'] = this.images;
    data['tag'] = this.tag;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['short_description'] = this.shortDescription;
    data['long_description'] = this.longDescription;
    data['base_price'] = this.basePrice;
    data['category'] = this.category;
    data['location_id'] = this.locationId;
    data['bid_end_date'] = this.bidEndDate;
    data['current_highest_bid'] = this.currentHighestBid;
    data['seller_id'] = this.sellerId;
    data['bids'] = this.bids;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
