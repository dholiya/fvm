import 'package:blobs/blobs.dart';
import 'package:flutter/material.dart';
import 'package:fvm/Util/AppTheme.dart';
import 'package:fvm/View/auth/Forgot.dart';
import 'package:fvm/View/auth/Register.dart';
import 'package:fvm/View/menu/HomePage.dart';
import 'package:fvm/main.dart';

import '../../Util/Util.dart';
import '../../Util/AppImages.dart';

class LoginScreen extends StatefulWidget {
  static const name = '/login';

  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late CustomAppTheme customAppTheme;
  late BuildContext buildContext;
  late ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    customAppTheme = CustomAppTheme();
    buildContext = context;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(200),
                    bottomRight: Radius.circular(200)),
                color: customAppTheme.primary,
              ),
              height: 150,
              width: 100,
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(color: customAppTheme.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                      child:
                      // Container(
                      //     alignment: Alignment.topCenter,
                      //     child: Blob.animatedRandom(
                      //       size: 300,
                      //       edgesCount: 5,
                      //       minGrowth: 4,
                      //       loop: true,
                      //       child: Center(
                      //         child: Text("\n\nWelcome Back",
                      //             style: AppTheme.getTextStyle(
                      //                 color: customAppTheme.black,
                      //                 themeData.textTheme.headline4,
                      //                 fontWeight: 800)),
                      //       ),
                      //     )),
                      Center(
                        child: Text("Welcome Back",
                            style: AppTheme.getTextStyle(
                                color: customAppTheme.primary,
                                themeData.textTheme.headline4,
                                fontWeight: 800)),
                      )
                      ,flex: 3),
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePage()));

                              print(emailController);
                              print(passwordController);
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
                  Expanded(child: Container(), flex: 1),
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
          ],
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
}
