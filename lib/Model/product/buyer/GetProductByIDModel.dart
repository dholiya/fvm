class GetProductByIDModel {
  int? status;
  GetProductByIDModelData? data;

  GetProductByIDModel({this.status, this.data});

  GetProductByIDModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new GetProductByIDModelData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class GetProductByIDModelData {
  List<String>? images;
  List<String>? tag;
  List<String>? favoriteBy;

  String? sId;
  String? name;
  String? shortDescription;
  String? longDescription;
  double? basePrice;
  String? category;
  String? locationId;
  String? bidEndDate;
  double? currentHighestBid;
  String? sellerId;
  int? bids;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? buyerEmail;
  String? buyerId;

  GetProductByIDModelData(
      {this.images,
        this.tag,
        this.favoriteBy,

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
        this.iV,
        this.buyerId,
      this.buyerEmail});

  GetProductByIDModelData.fromJson(Map<String, dynamic> json) {
    images = json['images'].cast<String>();
    tag = json['tag'].cast<String>();
    favoriteBy = json['favorite_by'].cast<String>();

    sId = json['_id'];
    name = json['name'];
    shortDescription = json['short_description'];
    longDescription = json['long_description'];
    basePrice = double.parse(json['base_price'].toString());
    category = json['category'];
    locationId = json['location_id'];
    bidEndDate = json['bid_end_date'];
    currentHighestBid = double.parse(json['current_highest_bid'].toString());
    sellerId = json['seller_id'];
    bids = int.parse(json['bids'].toString());
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    buyerId = json['buyer_id'];
    buyerEmail = json['buyer_email'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['images'] = this.images;
    data['tag'] = this.tag;
    data['favorite_by'] = this.favoriteBy;
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
    data['buyer_id'] = this.buyerId;
    data['buyer_email'] = this.buyerEmail;
    return data;
  }
}
