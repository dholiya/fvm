import 'package:fvm/Model/CommonModel.dart';
import 'package:fvm/Model/product/ProductsModel.dart';

abstract class ProductController {
  void onLoadCompleted(ProductsModel items);
  void onLoadError(CommonModel items);
  void onLoadConnection(var connection) {}
}

