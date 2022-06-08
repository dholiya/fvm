import 'package:flutter/cupertino.dart';
import 'Util/AppThemeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppThemeMode>(
        builder: (BuildContext context, AppThemeMode value, Widget child) {
          return Text("sad");
        });
  }
}
