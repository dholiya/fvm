import 'package:flutter/material.dart';
import 'package:fvm/SplashScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:fvm/Util/AppString.dart';
import 'package:fvm/View/auth/Forgot.dart';
import 'package:fvm/View/auth/Login.dart';
import 'package:fvm/View/auth/VerifyOTP.dart';
import 'package:fvm/View/auth/Register.dart';
import 'package:fvm/View/sellermode/AddProduct.dart';
import 'package:fvm/View/sellermode/YourProduct.dart';
import 'TabHandler.dart';
import 'Util/AppTheme.dart';
import 'View/buyer/FavoritePage.dart';
import 'View/buyer/HomePage.dart';
import 'View/buyer/ProfilePage.dart';
import 'View/drawer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

// https://medium.com/flutter-community/flutter-push-pop-push-1bb718b13c31
class MyApp extends StatelessWidget {
  late BuildContext _buildContext;
  late CustomAppTheme customAppTheme;
  late ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    customAppTheme = CustomAppTheme();
    _buildContext = context;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppString.AppName,
      theme: ThemeData(
        scaffoldBackgroundColor: customAppTheme.primaryBackground,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: customAppTheme.textDark),
          backgroundColor: customAppTheme.primaryBackground,
          titleTextStyle: AppTheme.getTextStyle(themeData.textTheme.titleLarge,
              color: customAppTheme.textDark,
              fontWeight: 800,
              letterSpacing: 0.20),
        ),
        primaryColor: customAppTheme.primary,
      ),
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        SplashScreen.name: (BuildContext context) => SplashScreen(),
        TabHandler.name: (BuildContext context) => TabHandler(),
        LoginScreen.name: (BuildContext context) => LoginScreen(),
        OTPScreen.name: (BuildContext context) => OTPScreen("test"),
        RegisterScreen.name: (BuildContext context) => RegisterScreen(),
        ForgotScreen.name: (BuildContext context) => ForgotScreen(),
        FavoritePage.name: (BuildContext context) => FavoritePage(),
        HomePage.name: (BuildContext context) => HomePage(),
        ProfilePage.name: (BuildContext context) => ProfilePage(),
        AddProduct.name: (BuildContext context) => AddProduct(),
        YourProduct.name: (BuildContext context) => YourProduct(),
      },
    );
  }
}
