import 'dart:convert';
import 'package:fvm/Controller/auth/RegisterController.dart';
import 'package:fvm/Controller/product/buyer/ProductController.dart';
import 'package:fvm/Model/CommonModel.dart';
import 'package:fvm/Model/auth/RegisterModel.dart';
import 'package:fvm/Model/product/buyer/ProductsModel.dart';
import 'package:fvm/Util/ApiList.dart';
import 'package:fvm/Util/AppString.dart';
import 'package:fvm/Util/Headers.dart';
import 'package:fvm/Util/Util.dart';
import 'package:http/http.dart' as http;

class ProductParent {
  ProductController contract;
  ProductParent(this.contract);
  Future<void> loadData() async {
    try {
      Util.checkInternet().then((value) async {
        if (value) {
          var response = await http.get(Api.getProduct, headers: Headers.instance.getHeaderAuthOnly());
          var data = json.decode(response.body);
          if (data['status'] != 200) {
            contract.onLoadError(CommonModel.fromJson(data));
            return;
          }
          contract.onLoadCompleted(ProductsModel.fromJson(data));
        }
        else {
          contract.onLoadConnection(AppString.noInternetConnection);
        }
      });
    }catch(e){
      contract.onLoadError(CommonModel.fromJson({"status":500, "msg": AppString.somethingWrong}));
    }

  }
}
