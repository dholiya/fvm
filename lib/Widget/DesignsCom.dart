import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../Util/AppString.dart';
import '../Util/AppTheme.dart';
import '../Util/Util.dart';

class DesignsCom {
  static Widget ApiState0(customAppTheme) {
    return Center(
        child: CircularProgressIndicator(
            strokeWidth: 4, color: customAppTheme.primaryVariant));
  }

  static Widget ApiState4(ThemeData themeData) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Text(AppString.somethingWrong,
            style: AppTheme.getTextStyle(themeData.textTheme.headline6,
                color: themeData.disabledColor, fontWeight: 700)),
      ),
    );
  }

  static Widget ApiState3(ThemeData themeData, msg, IconData icon) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Icon(icon, color: Colors.white, size: 250),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(msg.toString(),
                  style: AppTheme.getTextStyle(themeData.textTheme.headline6,
                      color: themeData.disabledColor, fontWeight: 700)),
            ),
          )
        ]);
  }
}
