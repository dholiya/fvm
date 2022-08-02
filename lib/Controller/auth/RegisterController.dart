
import 'package:fvm/Model/CommonModel.dart';
import 'package:fvm/Model/auth/RegisterModel.dart';

abstract class RegisterController {
  void onLoadCompleted(RegisterModel items);
  void onLoadError(CommonModel items);
  void onLoadConnection(var connection) {}
}

