
import 'package:fvm/Model/CommonModel.dart';
import 'package:fvm/Model/product/seller/SellerProductsModel.dart';

abstract class DeleteSellerProductController {
  void onLoadDeleteCompleted(CommonModel items);
  void onLoadDeleteError(CommonModel items);
  void onLoadDeleteConnection(var connection) {}
}

