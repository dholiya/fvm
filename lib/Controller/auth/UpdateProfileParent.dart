import 'dart:convert';
import 'package:fvm/Controller/auth/UpdateProfileController.dart';
import 'package:fvm/Controller/auth/VerifyOTPController.dart';
import 'package:fvm/Controller/auth/LoginController.dart';
import 'package:fvm/Model/CommonModel.dart';
import 'package:fvm/Model/auth/LoginModel.dart';
import 'package:fvm/Util/ApiList.dart';
import 'package:fvm/Util/AppString.dart';
import 'package:fvm/Util/Headers.dart';
import 'package:fvm/Util/Util.dart';
import 'package:http/http.dart' as http;

class UpdateProfileParent {
  UpdateProfileController contract;

  UpdateProfileParent(this.contract);

  Future<void> loadData(bodyData, userID) async {
    Util.consoleLog("check=" + bodyData.toString());
    Util.checkInternet().then((value) async {
      if (value) {
        var request = http.Request('PATCH', Uri.parse(Api.updateProfile+userID));
        request.bodyFields = bodyData;
        request.headers.addAll(Headers.instance.getHeaderAuthNXWWW());
        var response = await request.send();
        await response.stream.bytesToString().then((value) {
          var data = json.decode(value);
          Util.consoleLog(data.toString());
          if (data['status'] != 200) {
            contract.onLoadUpdateError(CommonModel.fromJson(data));
            return;
          }
          contract.onLoadUpdateCompleted(LoginModel.fromJson(data));
        });
      } else {
        contract.onLoadUpdateConnection(AppString.noInternetConnection);
      }
    });
  }
}
