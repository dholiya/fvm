import 'package:fvm/Model/CommonModel.dart';
import 'package:fvm/Model/product/buyer/FavoriteModel.dart';
import 'package:fvm/Model/product/buyer/ProductsModel.dart';

abstract class FavoriteController {
  void onLoadFavCompleted(FavoriteModel items);
  void onLoadFavError(CommonModel items);
  void onLoadFavConnection(var connection) {}
}

