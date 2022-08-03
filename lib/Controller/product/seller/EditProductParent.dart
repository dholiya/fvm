import 'dart:convert';
import 'package:fvm/Controller/product/seller/EditProductController.dart';
import 'package:fvm/Controller/product/seller/SellerProductController.dart';
import 'package:fvm/Model/CommonModel.dart';
import 'package:fvm/Model/product/buyer/ProductsModel.dart';
import 'package:fvm/Model/product/seller/SellerProductsModel.dart';
import 'package:fvm/Util/ApiList.dart';
import 'package:fvm/Util/AppString.dart';
import 'package:fvm/Util/Headers.dart';
import 'package:fvm/Util/Util.dart';
import 'package:http/http.dart' as http;

class EditProductParent {
  EditProductController contract;
  EditProductParent(this.contract);

  Future<void> loadData(bodyData, productID) async {
    try {
      Util.checkInternet().then((value) async {
        if (value) {
          var response = await http.patch(Uri.parse(Api.updateProduct + productID),
              body: bodyData, headers: Headers.instance.getHeaderAuthNXWWW());
          var data = json.decode(response.body);
          if (data['status'] != 200 ) {
            contract.onLoadEditError(CommonModel.fromJson(data));
            return;
          }
          contract.onLoadEditCompleted(CommonModel.fromJson(data));
        } else {
          contract.onLoadEditConnection(AppString.noInternetConnection);
        }
      });
    } catch (e) {
      contract.onLoadEditError(CommonModel.fromJson(
          {"status": 500, "msg": AppString.somethingWrong}));
    }
  }
}
