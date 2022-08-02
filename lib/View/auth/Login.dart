import 'dart:convert';

import 'package:blobs/blobs.dart';
import 'package:flutter/material.dart';
import 'package:fvm/Controller/auth/LoginController.dart';
import 'package:fvm/Controller/auth/LoginParent.dart';
import 'package:fvm/Model/CommonModel.dart';
import 'package:fvm/Model/auth/LoginModel.dart';
import 'package:fvm/Util/AppString.dart';
import 'package:fvm/Util/AppTheme.dart';
import 'package:fvm/Util/Headers.dart';
import 'package:fvm/Util/SpUtil.dart';
import 'package:fvm/View/auth/Forgot.dart';
import 'package:fvm/View/auth/Register.dart';
import 'package:fvm/main.dart';

import '../../TabHandler.dart';
import '../../Util/Util.dart';
import '../../Util/AppImages.dart';

class LoginScreen extends StatefulWidget {
  static const name = '/login';

  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> implements LoginController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late CustomAppTheme customAppTheme;
  late ThemeData themeData;
  LoginParent? _parent;

  _LoginScreen() {
    _parent = LoginParent(this);
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    customAppTheme = CustomAppTheme();
    return Scaffold(
      backgroundColor: customAppTheme.white,
      body: SafeArea(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Text("Welcome Back",
                      style: AppTheme.getTextStyle(
                          color: customAppTheme.primary,
                          themeData.textTheme.headline4,
                          fontWeight: 800)),
                ),
                SizedBox(height: 50),
                Image.asset(
                  AppImages.login,
                  fit: BoxFit.fill,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        userInput(
                            emailController,
                            'Email',
                            TextInputType.emailAddress,
                            Icons.email_rounded,
                            Icons.ac_unit),
                        userInput(
                            passwordController,
                            'Password',
                            TextInputType.visiblePassword,
                            Icons.lock_rounded,
                            Icons.visibility_off_rounded),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            var email =  emailController.text.toString().trim();
                            var pswrd =  passwordController.text.toString().trim();
                            if(email.isEmpty && pswrd.isEmpty) {
                              Util.createSnackBar(
                                  AppString.valiData,
                                  context,
                                  customAppTheme.primaryVariant,
                                  customAppTheme.white);
                              return;
                            }else if(email.isEmpty) {
                              Util.createSnackBar(
                                  "Please enter email",
                                  context,
                                  customAppTheme.primaryVariant,
                                  customAppTheme.white);
                              return;
                            }else if(pswrd.isEmpty){
                              Util.createSnackBar(
                                  "Please enter password",
                                  context,
                                  customAppTheme.primaryVariant,
                                  customAppTheme.white);
                              return;
                            }
                            _parent?.loadData({
                              'email': emailController.text.toString(),
                              'password': passwordController.text.toString()
                            });

                          },

                          child: Container(
                            padding: EdgeInsets.all(15),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: customAppTheme.primary,
                              ),
                              child: Text(
                                'Login',
                                style: AppTheme.getTextStyle(
                                    color: customAppTheme.white,
                                    themeData.textTheme.headline6,
                                    fontWeight: 700),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotScreen()));
                          },

                          child: Container(
                              padding: EdgeInsets.all(15),
                              alignment: Alignment.centerRight,
                              child: Text('Forgot password?', style:AppTheme.getTextStyle(
                                  themeData.textTheme.bodyText1,
                                  color: themeData.colorScheme.primary,
                                fontWeight: 700
                                  ))),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(150),
                        topRight: Radius.circular(150)),
                    color: customAppTheme.primaryBackground,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account yet ? ',
                        style: TextStyle(
                            color: customAppTheme.textlight,
                            fontStyle: FontStyle.italic),
                      ),
                      TextButton(
                        onPressed: () {

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterScreen()));

                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: customAppTheme.primary),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget userInput(TextEditingController controller, String hintTitle,
      TextInputType keyboardType, IconData iconData, IconData ac_unit) {
    return Container(
      padding: EdgeInsets.all(15),
      child: TextFormField(
        controller: controller,
        textInputAction: TextInputAction.next,
        autofocus: false,
        obscureText:
            keyboardType == TextInputType.visiblePassword ? true : false,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          filled: true,
          // suffixIcon:
          // // ac_unit != Icons.ac_unit
          // //     ?
          // GestureDetector(
          //         onTap: () {
          //           setState(() {
          //             ac_unit == Icons.visibility_off_outlined;
          //           });
          //         },
          //         child: Icon(
          //           ac_unit,
          //           color: customAppTheme.primarylite,
          //         ),
          //       ),
          //     // : Container(width: 0, height: 0),
          prefixIcon: GestureDetector(
            onTap: () {},
            child: Icon(
              iconData,
              color: customAppTheme.primary,
            ),
          ),
          fillColor: customAppTheme.primaryBackground,
          hintText: hintTitle,
          hintStyle: TextStyle(color: customAppTheme.blackTrans88),
          contentPadding: EdgeInsets.all(14),
          focusedBorder: Util.noBorder8(),
          enabledBorder: Util.noBorder8(),
        ),
      ),
    );
  }

  @override
  Future<void> onLoadCompleted(LoginModel items) async {
    items.accessToken = "Bearer "+items.accessToken.toString();
   await SpUtil.setUserData(items);
   Headers.instance.loginToken = items.accessToken;
  Util.consoleLog("login = "+Headers.instance.loginToken);
   SpUtil.setLogin(true);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TabHandler()));

  }

  @override
  void onLoadConnection(connection) {
    Util.createSnackBar(
        connection,
        context,
        customAppTheme.colorError,
        customAppTheme.white);
  }

  @override
  void onLoadError(CommonModel items) {
    Util.createSnackBar(
        items.msg,
        context,
        customAppTheme.colorError,
        customAppTheme.white);
  }


}
