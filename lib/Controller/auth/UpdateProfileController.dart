
import 'package:fvm/Model/CommonModel.dart';
import 'package:fvm/Model/auth/LoginModel.dart';
import 'package:fvm/Model/auth/RegisterModel.dart';

abstract class UpdateProfileController {
  void onLoadUpdateCompleted(LoginModel items);
  void onLoadUpdateError(CommonModel items);
  void onLoadUpdateConnection(var connection) {}
}

