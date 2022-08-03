import 'dart:convert';
import 'package:fvm/Controller/auth/RegisterController.dart';
import 'package:fvm/Controller/product/buyer/FavoriteController.dart';
import 'package:fvm/Controller/product/buyer/ProductController.dart';
import 'package:fvm/Model/CommonModel.dart';
import 'package:fvm/Model/auth/RegisterModel.dart';
import 'package:fvm/Model/product/buyer/FavoriteModel.dart';
import 'package:fvm/Model/product/buyer/ProductsModel.dart';
import 'package:fvm/Util/ApiList.dart';
import 'package:fvm/Util/AppString.dart';
import 'package:fvm/Util/Headers.dart';
import 'package:fvm/Util/Util.dart';
import 'package:http/http.dart' as http;

class FavoriteParent {
  FavoriteController contract;
  FavoriteParent(this.contract);
  Future<void> loadData(userID) async {
    try {
      Util.checkInternet().then((value) async {
        if (value) {
          var response = await http.get(
              Uri.parse(Api.getFavorite+userID), headers: Headers.instance.getHeaderAuthOnly());
          var data = json.decode(response.body);
          Util.consoleLog(data.toString());
          if (data['status'] != 200) {
            contract.onLoadFavError(CommonModel.fromJson(data));
            return;
          }
          contract.onLoadFavCompleted(FavoriteModel.fromJson(data));
        }
        else {
          contract.onLoadFavConnection(AppString.noInternetConnection);
        }
      });
    }catch(e){
      contract.onLoadFavError(CommonModel.fromJson({"status":500,"msg": AppString.somethingWrong}));
    }

  }
}
