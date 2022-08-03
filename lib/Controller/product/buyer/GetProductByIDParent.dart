import 'dart:convert';
import 'package:fvm/Controller/auth/RegisterController.dart';
import 'package:fvm/Controller/product/buyer/FavoriteController.dart';
import 'package:fvm/Controller/product/buyer/GetProductByIDController.dart';
import 'package:fvm/Controller/product/buyer/ProductController.dart';
import 'package:fvm/Model/CommonModel.dart';
import 'package:fvm/Model/auth/RegisterModel.dart';
import 'package:fvm/Model/product/buyer/FavoriteModel.dart';
import 'package:fvm/Model/product/buyer/GetProductByIDModel.dart';
import 'package:fvm/Model/product/buyer/ProductsModel.dart';
import 'package:fvm/Util/ApiList.dart';
import 'package:fvm/Util/AppString.dart';
import 'package:fvm/Util/Headers.dart';
import 'package:fvm/Util/Util.dart';
import 'package:http/http.dart' as http;

class GetProductByIDParent {
  GetProductByIDController contract;
  GetProductByIDParent(this.contract);
  Future<void> loadData(productID) async {
    try {
      Util.checkInternet().then((value) async {
        if (value) {
          var response = await http.get(Uri.parse(Api.getProductByID+productID), headers: Headers.instance.getHeaderAuthOnly());
          var data = json.decode(response.body);
          if (data['status'] != 200 ) {
            contract.onLoadGetByIDError(CommonModel.fromJson(data));
            return;
          }
          contract.onLoadGetByIDCompleted(ProductsModelData.fromJson(data['data']));
        }
        else {
          contract.onLoadGetByIDConnection(AppString.noInternetConnection);
        }
      });
    }catch(e){
      contract.onLoadGetByIDError(CommonModel.fromJson({"status":500,"msg": AppString.somethingWrong}));
    }

  }
}
