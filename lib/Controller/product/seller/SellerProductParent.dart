import 'dart:convert';
import 'package:fvm/Controller/product/seller/SellerProductController.dart';
import 'package:fvm/Model/CommonModel.dart';
import 'package:fvm/Model/product/buyer/ProductsModel.dart';
import 'package:fvm/Model/product/seller/SellerProductsModel.dart';
import 'package:fvm/Util/ApiList.dart';
import 'package:fvm/Util/AppString.dart';
import 'package:fvm/Util/Headers.dart';
import 'package:fvm/Util/Util.dart';
import 'package:http/http.dart' as http;

class SellerProductParent {
  SellerProductController contract;
  SellerProductParent(this.contract);
  Future<void> loadData() async {
    try {
      Util.checkInternet().then((value) async {
        if (value) {
          var response = await http.get(Uri.parse(Api.sellerProduct+Util.loginData!.data!.sId.toString()), headers: Headers.instance.getHeaderAuthOnly());
          var data = json.decode(response.body);
          if (data['status'] != 200 ) {
            contract.onLoadError(CommonModel.fromJson(data));
            return;
          }
          contract.onLoadCompleted(SellerProductsModel.fromJson(data));
        }
        else {
          contract.onLoadConnection(AppString.noInternetConnection);
        }
      });
    }catch(e){
      contract.onLoadError(CommonModel.fromJson({"status":500,"msg": AppString.somethingWrong}));
    }

  }
}
