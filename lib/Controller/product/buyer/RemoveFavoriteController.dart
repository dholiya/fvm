import 'package:fvm/Model/CommonModel.dart';
import 'package:fvm/Model/product/buyer/FavoriteModel.dart';
import 'package:fvm/Model/product/buyer/ProductsModel.dart';

abstract class RemoveFavoriteController {
  void onLoadRemoveFavCompleted(CommonModel items);
  void onLoadRemoveFavError(CommonModel items);
  void onLoadRemoveFavConnection(var connection) {}
}

