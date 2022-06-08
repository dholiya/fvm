
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fvm/Util/Util.dart';

class AppTheme {
  AppTheme._();

  static FontWeight _getFontWeight(int weight) {
    switch (weight) {
      case 100:
        return FontWeight.w100;
      case 200:
        return FontWeight.w200;
      case 300:
        return FontWeight.w300;
      case 400:
        return FontWeight.w300;
      case 500:
        return FontWeight.w400;
      case 600:
        return FontWeight.w500;
      case 700:
        return FontWeight.w600;
      case 800:
        return FontWeight.w700;
      case 900:
        return FontWeight.w900;
    }
    return FontWeight.w400;
  }

  static TextStyle textTheme(int size) {
    switch (size) {
      case 28:
        return GoogleFonts.montserrat(
            textStyle: TextStyle(fontSize: 28, color: Color(0xff495057)));
      case 26:
        return GoogleFonts.montserrat(
            textStyle: TextStyle(fontSize: 26, color: Color(0xff495057)));
      case 24:
        return GoogleFonts.montserrat(
            textStyle: TextStyle(fontSize: 24, color: Color(0xff495057)));
      case 22:
        return GoogleFonts.montserrat(
            textStyle: TextStyle(fontSize: 22, color: Color(0xff495057)));
      case 20:
        return GoogleFonts.montserrat(
            textStyle: TextStyle(fontSize: 20, color: Color(0xff495057)));
      case 18:
        return GoogleFonts.montserrat(
            textStyle: TextStyle(fontSize: 18, color: Color(0xff495057)));
      case 16:
        return GoogleFonts.montserrat(
            textStyle: TextStyle(fontSize: 16, color: Color(0xff495057)));
      case 14:
        return GoogleFonts.montserrat(
            textStyle: TextStyle(fontSize: 14, color: Color(0xff495057)));
      case 12:
        return GoogleFonts.montserrat(
            textStyle: TextStyle(fontSize: 12, color: Color(0xff495057)));
      case 11:
        return GoogleFonts.montserrat(
            textStyle: TextStyle(fontSize: 11, color: Color(0xff495057)));
    }
    return GoogleFonts.montserrat(
        textStyle: TextStyle(fontSize: 18, color: Color(0xff495057)));
  }


  static TextStyle getTextStyle(TextStyle? textStyle,
        {int fontWeight = 500,
        bool muted = false,
        bool xMuted = false,
        double letterSpacing = 0.15,
        Color? color,
        TextDecoration decoration = TextDecoration.none,
        double? height,
        double wordSpacing = 0,
        double? fontSize}) {
    double? finalFontSize = fontSize != null ? fontSize : textStyle?.fontSize;

    Color? finalColor;
    if (color == null) {
      finalColor = xMuted
          ? textStyle?.color?.withAlpha(160)
          : (muted ? textStyle?.color?.withAlpha(200) : textStyle?.color);
    } else {
      finalColor = xMuted
          ? color.withAlpha(160)
          : (muted ? color.withAlpha(200) : color);
    }

    return GoogleFonts.montserrat(
        fontSize: finalFontSize,
        fontWeight: _getFontWeight(fontWeight),
        letterSpacing: letterSpacing,
        color: finalColor,
        decoration: decoration,
        height: height,
        wordSpacing: wordSpacing);
  }

  static NavigationBarTheme getNavigationThemeFromMode(int themeMode) {
    NavigationBarTheme navigationBarTheme = NavigationBarTheme();
    navigationBarTheme.backgroundColor = Colors.white;
    navigationBarTheme.selectedItemColor = Util.primary;
    navigationBarTheme.unselectedItemColor = Color(0xff495057);
    navigationBarTheme.selectedOverlayColor = Color(0x38604BFA);
    return navigationBarTheme;
  }
}

class CustomAppTheme {
  Color primary,
      primarylite,
      primaryBackground,
      primaryVariant,
      primaryVariantLite,
      bgLayer1,
      bgLayer2,
      bgLayer3,
      bgLayer4,
      onDisabled,
      colorInfo,
      colorWarning,
      colorSuccess,
      colorError,
      shadowColor,
      carPagedBackground,
      cardBottomBar,
      textDark,
      textsemi,
      textlight,
      textlight2,
      black,
      blackBg,
      btnDisable,
      blackTrans22,
      blackTrans00,
      blackTrans44,
      blackTrans88,
      blackTrans66,
      blackTransBB,
      whiteTextlight,
      whiteTextlight2, white;


  CustomAppTheme({
    this.primary = const Color(0xff00539c),
    this.primarylite = const Color(0xcc00539c),
    this.primaryBackground = const Color(0xffe7ebf3),
    this.primaryVariant = const Color(0xffffac63),
    this.primaryVariantLite = const Color(0xccffac63),
    this.bgLayer4 = const Color(0xffdcdee3),
    this.bgLayer3 = const Color(0xffeef2fa),
    this.bgLayer2 = const Color(0xfff8faff),
    this.bgLayer1 = const Color(0xffffffff),
    this.onDisabled = const Color(0xffffffff),
    this.colorWarning = const Color(0xffffc837),
    this.colorInfo = const Color(0xffff784b),
    this.colorSuccess = const Color(0xff34A853),
    this.colorError = const Color(0xfff0323c),
    this.black = const Color(0xff000000),
    this.shadowColor = const Color(0xff1f1f1f),
    this.blackBg = const Color(0xff1f1f1f),
    this.textDark = const Color(0xff1f1f1f),
    this.textsemi = const Color(0xff303030),
    this.textlight = const Color(0xff454545),
    this.textlight2 = const Color(0xff787878),
    this.blackTransBB = const Color(0xBB000000),
    this.blackTrans88 = const Color(0x88000000),
    this.blackTrans66 = const Color(0x66000000),
    this.blackTrans44 = const Color(0x44000000),
    this.blackTrans22 = const Color(0x22000000),
    this.blackTrans00 = const Color(0x00000000),
    this.cardBottomBar = const Color(0xfff5f5f5),
    this.carPagedBackground = const Color(0xfff9f9f9),
    this.btnDisable = const Color(0xffb0b0b0),
    this.whiteTextlight = const Color(0xffDDDDDD),
    this.whiteTextlight2 = const Color(0xfff1f1f1),
    this.white = const Color(0xffffffff),
  });
}

class NavigationBarTheme {
  late Color backgroundColor,
      selectedItemIconColor,
      selectedItemTextColor,
      selectedItemColor,
      selectedOverlayColor,
      unselectedItemIconColor,
      unselectedItemTextColor,
      unselectedItemColor;
}
