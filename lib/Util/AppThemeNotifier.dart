/*
* File : App Theme Notifier (Listener)
* Version : 1.0.0
* */

import 'package:flutter/material.dart';

class AppThemeMode extends ChangeNotifier {

  int _themeMode = 1;

  AppThemeMode() {
    init();
  }

  init() async {
  }

  themeMode() => _themeMode;

  Future<void> updateTheme(int themeMode) async {
    this._themeMode = themeMode;
  }
}