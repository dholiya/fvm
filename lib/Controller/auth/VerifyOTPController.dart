
import 'package:fvm/Model/CommonModel.dart';
import 'package:fvm/Model/auth/LoginModel.dart';
import 'package:fvm/Model/auth/RegisterModel.dart';

abstract class VerifyOTPController {
  void onLoadCompleted(CommonModel items);
  void onLoadError(CommonModel items);
  void onLoadConnection(var connection) {}
}

