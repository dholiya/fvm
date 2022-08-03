import 'dart:convert';
import 'package:fvm/Controller/product/buyer/PlacebidController.dart';
import 'package:fvm/Model/CommonModel.dart';
import 'package:fvm/Util/ApiList.dart';
import 'package:fvm/Util/AppString.dart';
import 'package:fvm/Util/Headers.dart';
import 'package:fvm/Util/Util.dart';
import 'package:http/http.dart' as http;

class PlacebidParent {
  PlacebidController contract;

  PlacebidParent(this.contract);

  Future<void> loadData(bodyData) async {
    try {
      Util.checkInternet().then((value) async {
        if (value) {
          var request = http.Request('POST', Api.placedBID);
          request.bodyFields = bodyData;
          request.headers.addAll(Headers.instance.getHeaderAuthNXWWW());

          var streamResponse = await request.send();
          final response = await http.Response.fromStream(streamResponse);
          
          var data = json.decode(response.body);

          if (data['status'] != 200 ) {
            contract.onLoadBIDError(CommonModel.fromJson(data));
            return;
          }
          contract.onLoadBIDCompleted(CommonModel.fromJson(data));
        } else {
          contract.onLoadBIDConnection(AppString.noInternetConnection);
        }
      });
    } catch (e) {
      contract.onLoadBIDError(CommonModel.fromJson(
          {"status": 500, "msg": AppString.somethingWrong}));
    }
  }
}
