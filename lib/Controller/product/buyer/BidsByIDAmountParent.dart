import 'dart:convert';
import 'package:fvm/Controller/product/buyer/BidsByIDAmountController.dart';
import 'package:fvm/Controller/product/buyer/PlacebidController.dart';
import 'package:fvm/Model/CommonModel.dart';
import 'package:fvm/Model/product/buyer/BidsByIDAmountModel.dart';
import 'package:fvm/Util/ApiList.dart';
import 'package:fvm/Util/AppString.dart';
import 'package:fvm/Util/Headers.dart';
import 'package:fvm/Util/Util.dart';
import 'package:http/http.dart' as http;

class BidsByIDAmountParent {
  BidsByIDAmountController contract;

  BidsByIDAmountParent(this.contract);

  Future<void> loadData(bodyData) async {
    try {
      Util.checkInternet().then((value) async {
        if (value) {
          var request = http.Request('GET', Api.getByIDAmountBid);
          request.bodyFields = bodyData;
          request.headers.addAll(Headers.instance.getHeaderAuthNXWWW());

          var streamResponse = await request.send();
          final response = await http.Response.fromStream(streamResponse);

          var data = json.decode(response.body);
          if (data['status'] != 200 ) {
            contract.onLoadBitAmountError(CommonModel.fromJson(data));
            return;
          }
          contract.onLoadBitAmountCompleted(BidsByIDAmountModel.fromJson(data));
        } else {
          contract.onLoadBitAmountConnection(AppString.noInternetConnection);
        }
      });
    } catch (e) {
      contract.onLoadBitAmountError(CommonModel.fromJson(
          {"status": 500, "msg": AppString.somethingWrong}));
    }
  }
}
