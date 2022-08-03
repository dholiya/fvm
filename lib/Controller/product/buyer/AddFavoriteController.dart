
import 'package:fvm/Model/CommonModel.dart';
import 'package:fvm/Model/auth/LoginModel.dart';
import 'package:fvm/Model/auth/RegisterModel.dart';

abstract class AddFavoriteController {
  void onLoadFavCompleted(CommonModel items);
  void onLoadFavError(CommonModel items);
  void onLoadFavConnection(var connection) {}
}

