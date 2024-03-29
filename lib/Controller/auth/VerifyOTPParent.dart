import 'dart:convert';
import 'package:fvm/Controller/auth/VerifyOTPController.dart';
import 'package:fvm/Controller/auth/LoginController.dart';
import 'package:fvm/Model/CommonModel.dart';
import 'package:fvm/Model/auth/LoginModel.dart';
import 'package:fvm/Util/ApiList.dart';
import 'package:fvm/Util/AppString.dart';
import 'package:fvm/Util/Headers.dart';
import 'package:fvm/Util/Util.dart';
import 'package:http/http.dart' as http;

class VerifyOTPParent {
  VerifyOTPController contract;

  VerifyOTPParent(this.contract);

  Future<void> loadData(bodyData) async {
    Util.consoleLog(bodyData.toString());
    Util.checkInternet().then((value) async {
      if (value) {
        var request = http.Request('PATCH', Api.verifyOTP);
        request.bodyFields =bodyData;
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
