import 'dart:convert';
import 'package:fvm/Controller/auth/RegisterController.dart';
import 'package:fvm/Controller/product/buyer/AddFavoriteController.dart';
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

class AddFavoriteParent {
  AddFavoriteController contract;
  AddFavoriteParent(this.contract);
  Future<void> loadData(bodyData) async {
    try {
      Util.checkInternet().then((value) async {
        if (value) {
          var request = http.Request('POST', Api.addFavorite);
          Util.consoleLog("==="+bodyData.toString());

          request.bodyFields = bodyData;

          request.headers.addAll(Headers.instance.getHeaderAuthNXWWW());

          var streamResponse = await request.send();
          final response = await http.Response.fromStream(streamResponse);
          
          var data = json.decode(response.body);

          if (data['status'] != 200 ) {
            contract.onLoadFavError(CommonModel.fromJson(data));
            return;
          }
          contract.onLoadFavCompleted(CommonModel.fromJson(data));
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
