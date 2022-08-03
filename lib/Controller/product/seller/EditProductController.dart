
import 'package:fvm/Model/CommonModel.dart';

abstract class EditProductController {
  void onLoadEditCompleted(CommonModel items);
  void onLoadEditError(CommonModel items);
  void onLoadEditConnection(var connection) {}
}

