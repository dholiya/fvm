import 'dart:convert';
import 'package:fvm/Controller/auth/RegisterController.dart';
import 'package:fvm/Controller/product/buyer/FavoriteController.dart';
import 'package:fvm/Controller/product/buyer/ProductController.dart';
import 'package:fvm/Controller/product/buyer/RemoveFavoriteController.dart';
import 'package:fvm/Model/CommonModel.dart';
import 'package:fvm/Model/auth/RegisterModel.dart';
import 'package:fvm/Model/product/buyer/FavoriteModel.dart';
import 'package:fvm/Model/product/buyer/ProductsModel.dart';
import 'package:fvm/Util/ApiList.dart';
import 'package:fvm/Util/AppString.dart';
import 'package:fvm/Util/Headers.dart';
import 'package:fvm/Util/Util.dart';
import 'package:http/http.dart' as http;

class RemoveFavoriteParent {
  RemoveFavoriteController contract;
  RemoveFavoriteParent(this.contract);
  Future<void> loadData(productID) async {
    try {
      Util.checkInternet().then((value) async {
        if (value) {
          var response = await http.delete(Uri.parse(Api.deleteFavorite+productID), headers: Headers.instance.getHeaderAuthOnly());
          var data = json.decode(response.body);
          Util.consoleLog(data.toString());
          if (data['status'] != 200) {
            contract.onLoadRemoveFavError(CommonModel.fromJson(data));
            return;
          }
          contract.onLoadRemoveFavCompleted(CommonModel.fromJson(data));
        }
        else {
          contract.onLoadRemoveFavConnection(AppString.noInternetConnection);
        }
      });
    }catch(e){
      contract.onLoadRemoveFavError(CommonModel.fromJson({"status":500,"msg": AppString.somethingWrong}));
    }

  }
}
