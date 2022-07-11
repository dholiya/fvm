import 'package:flutter/cupertino.dart';
import 'Util/AppThemeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Util/SpUtil.dart';
import 'main.dart';

class SplashScreen extends StatefulWidget {
  static const name = '/splashScreen';
  static bool isSeller = false;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late BuildContext buildContext;

  @override
  void initState() {
    super.initState();
    initSP();
  }

  Future<void> initSP() async {
    await SpUtil.getInstance().then((value) {
      isSellerMode();
    });
  }

////////////////////////////////////////////////////////////////
  void isSellerMode() async {
    setState(() {
      SplashScreen.isSeller = SpUtil.getIsSellerMode();
    });
    Future.delayed(const Duration(milliseconds: 3000), () {
      setState(() {
        Navigator.of(buildContext).pushReplacementNamed(MyHomePage.name);
      });
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    buildContext = context;
    return Container();
  }
}
