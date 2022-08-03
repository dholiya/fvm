import 'dart:convert';
import 'package:fvm/Controller/product/buyer/PlacebidController.dart';
import 'package:fvm/Controller/product/seller/DeleteSellerProductController.dart';
import 'package:fvm/Model/CommonModel.dart';
import 'package:fvm/Util/ApiList.dart';
import 'package:fvm/Util/AppString.dart';
import 'package:fvm/Util/Headers.dart';
import 'package:fvm/Util/Util.dart';
import 'package:http/http.dart' as http;

class DeleteSellerProductParent {
  DeleteSellerProductController contract;

  DeleteSellerProductParent(this.contract);

  Future<void> loadData(productID) async {
    Util.consoleLog("sasds");
    Util.checkInternet().then((value) async {
      if(value) {
        var response = await http.delete(Uri.parse(Api.deleteProduct+productID),headers: Headers.instance.getHeaderAuthOnly());
        var data = json.decode(response.body);
        if (data['status']!= 200 ) {
          contract.onLoadDeleteError(CommonModel.fromJson(data));
          return;
        }
        contract.onLoadDeleteCompleted(CommonModel.fromJson(data));
      }
      else {
        contract.onLoadDeleteConnection(AppString.noInternetConnection);
      }
    });
  }
}
