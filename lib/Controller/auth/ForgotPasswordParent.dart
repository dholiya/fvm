import 'dart:convert';
import 'package:fvm/Controller/auth/ForgotPasswordController.dart';
import 'package:fvm/Model/CommonModel.dart';
import 'package:fvm/Util/ApiList.dart';
import 'package:fvm/Util/AppString.dart';
import 'package:fvm/Util/Headers.dart';
import 'package:fvm/Util/Util.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordParent {
  ForgotPasswordController contract;

  ForgotPasswordParent(this.contract);

  Future<void> loadData(bodyData) async {
    Util.consoleLog(bodyData.toString());
    Util.checkInternet().then((value) async {
      if (value) {

        var request = http.Request('GET', Api.sendOTP);
        request.bodyFields = bodyData;
        request.headers.addAll(Headers.instance.getCommonHeader());
        var response = await request.send();

        await response.stream.bytesToString().then((value) {
          var data = json.decode(value);
          if (data['status'] != 200) {
            contract.onLoadError(CommonModel.fromJson(data));
            return;
          }
          contract.onLoadCompleted(CommonModel.fromJson(data));
        });
      } else {
        contract.onLoadConnection(AppString.noInternetConnection);
      }
    });
  }
}
