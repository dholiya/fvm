
import 'package:fvm/Model/CommonModel.dart';
import 'package:fvm/Model/auth/LoginModel.dart';
import 'package:fvm/Model/auth/RegisterModel.dart';

abstract class PlacebidController {
  void onLoadBIDCompleted(CommonModel items);
  void onLoadBIDError(CommonModel items);
  void onLoadBIDConnection(var connection) {}
}

