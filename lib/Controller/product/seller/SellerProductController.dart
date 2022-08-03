
import 'package:fvm/Model/CommonModel.dart';
import 'package:fvm/Model/product/seller/SellerProductsModel.dart';

abstract class SellerProductController {
  void onLoadCompleted(SellerProductsModel items);
  void onLoadError(CommonModel items);
  void onLoadConnection(var connection) {}
}

