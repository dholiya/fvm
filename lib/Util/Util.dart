import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

import 'AppTheme.dart';

class Util {
  static Color primary = Color(0xff00539c);
  static Color primaryLite = Color(0xcc00539c);
  static Color primaryVariant = Color(0xffffac63);
  static Color primaryVariantLite = Color(0xccffac63);

  static Color primaryDark = Color(0xffe51b4f);
  static Color primaryLight = Color(0xffea6789);

  static LinearGradient gradientColor = LinearGradient(
    colors: [
      primary,
      primaryLite,
    ],
    stops: [
      0.0,
      1.0,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static LinearGradient gradientColorProgress = LinearGradient(
    colors: [
      primaryLight,
      primaryDark,
    ],
    stops: [
      0.0,
      1.0,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static LinearGradient gradientColorDisable = LinearGradient(
    colors: [Color(0xffb0b0b0), Color(0xffc0c0c0)],
    stops: [
      0.0,
      1.0,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static String stringElipsisCountry(String name) {
    return name.length < 4 ? name : name.substring(0, 3);
  }

  static void createSnackBar(String message, BuildContext scaffoldContext,
      Color backgroundColor, Color textColor) {
    final snackBar = new SnackBar(
        duration: const Duration(milliseconds: 2000),
        content: new Text(message,
            style: TextStyle(color: textColor, fontWeight: FontWeight.w700)),
        backgroundColor: backgroundColor);
    // ignore: deprecated_member_use
    ScaffoldMessenger.of(scaffoldContext).showSnackBar(snackBar);
    //
    // Scaffold.of(scaffoldContext).showSnackBar(snackBar);
    // ScaffoldMessenger.of(scaffoldContext).showSnackBar(snackBar);
  }

  static void createSnackBarGlobal(String message, ScaffoldState scaffoldState,
      Color backgroundColor, Color textColor) {
    final snackBar = new SnackBar(
      duration: const Duration(milliseconds: 1500),
      content: new Text(message,
          style: TextStyle(color: textColor, fontWeight: FontWeight.w600)),
      backgroundColor: backgroundColor,
    );
    // ignore: deprecated_member_use
    scaffoldState.showSnackBar(snackBar);
    // ScaffoldMessenger.of(scaffoldState.context).showSnackBar(snackBar);
  }

  static Future<bool> checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  static Widget ButtonDesign(
      String name, CustomAppTheme customAppTheme, ThemeData themeData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: customAppTheme.primary,
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          child: Text(
            name,
            textAlign: TextAlign.center,
            style: AppTheme.getTextStyle(themeData.textTheme.bodyText1,
                color: customAppTheme.cardBottomBar, fontWeight: 500),
          ),
        ),
      ],
    );
  }

  static Widget ButtonDesignIcon(
      IconData iconData, CustomAppTheme customAppTheme, ThemeData themeData) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        // color: customAppTheme.primary,
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      child: Icon(iconData, color: customAppTheme.primary, size: 35),
    );
  }

  static OutlineInputBorder noBorder8() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(8),
    );
  }


  /// This function is used for print API response
  static void consoleLog(String s) => log(s);

  static List<String> imgListFav = <String>[];


}
