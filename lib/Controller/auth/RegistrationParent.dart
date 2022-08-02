import 'dart:convert';
import 'package:fvm/Controller/auth/RegisterController.dart';
import 'package:fvm/Model/CommonModel.dart';
import 'package:fvm/Model/auth/RegisterModel.dart';
import 'package:fvm/Util/ApiList.dart';
import 'package:fvm/Util/AppString.dart';
import 'package:fvm/Util/Headers.dart';
import 'package:fvm/Util/Util.dart';
import 'package:http/http.dart' as http;


class RegistrationParent {
  RegisterController contract;
  RegistrationParent(this.contract);
  Future<void> loadData(bodyData) async {
    Util.checkInternet().then((value) async {
      if(value) {
        var response = await http.post(Api.registration,headers: Headers.instance.getCommonHeader(), body: bodyData);
        var data = json.decode(response.body);
        if (data['status']!= 200 || data['data']==null) {
          contract.onLoadError(CommonModel.fromJson(data));
          return;
        }
          contract.onLoadCompleted(RegisterModel.fromJson(data));
      }
      else {
        contract.onLoadConnection(AppString.noInternetConnection);
      }
    });
  }
}
