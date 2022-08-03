import 'package:fvm/Model/CommonModel.dart';
import 'package:fvm/Model/product/buyer/FavoriteModel.dart';
import 'package:fvm/Model/product/buyer/GetProductByIDModel.dart';
import 'package:fvm/Model/product/buyer/ProductsModel.dart';

abstract class GetProductByIDController {
  void onLoadGetByIDCompleted(ProductsModelData items);
  void onLoadGetByIDError(CommonModel items);
  void onLoadGetByIDConnection(var connection) {}
}

