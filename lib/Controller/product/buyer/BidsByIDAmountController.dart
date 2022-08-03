
import 'package:fvm/Model/CommonModel.dart';
import 'package:fvm/Model/auth/LoginModel.dart';
import 'package:fvm/Model/auth/RegisterModel.dart';
import 'package:fvm/Model/product/buyer/BidsByIDAmountModel.dart';

abstract class BidsByIDAmountController {
  void onLoadBitAmountCompleted(BidsByIDAmountModel items);
  void onLoadBitAmountError(CommonModel items);
  void onLoadBitAmountConnection(var connection) {}
}

