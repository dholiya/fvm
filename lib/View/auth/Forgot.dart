import 'package:blobs/blobs.dart';
import 'package:flutter/material.dart';
import 'package:fvm/Util/AppTheme.dart';
import 'package:fvm/View/auth/Login.dart';
import 'package:fvm/View/auth/OTP.dart';
import 'package:fvm/View/auth/Register.dart';
import 'package:fvm/main.dart';

import '../../Util/Util.dart';
import '../../Util/AppImages.dart';

class ForgotScreen extends StatefulWidget {
  static const name = '/forgot';

  @override
  _ForgotScreen createState() => _ForgotScreen();
}

class _ForgotScreen extends State<ForgotScreen> {
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
      backgroundColor: customAppTheme.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: customAppTheme.textDark),
        shadowColor: customAppTheme.blackTrans00,
        backgroundColor: customAppTheme.blackTrans00,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).viewPadding.top -
                kToolbarHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(child: Container(), flex: 1),
                Center(
                  child: Text("Forgot Password?",
                      style: AppTheme.getTextStyle(
                          color: customAppTheme.primary,
                          themeData.textTheme.headline4,
                          fontWeight: 800)),
                ),
                Expanded(child: Container(), flex: 1),
                Image.asset(
                  AppImages.forgot,
                  fit: BoxFit.contain,
                ),
                userInput(emailController, 'Email', TextInputType.emailAddress,
                    Icons.email_rounded, Icons.ac_unit),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => OTPScreen()));
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: customAppTheme.primary,
                      ),
                      child: Text(
                        'Send OTP',
                        style: AppTheme.getTextStyle(
                            color: customAppTheme.white,
                            themeData.textTheme.headline6,
                            fontWeight: 700),
                      ),
                    ),
                  ),
                ),
                Expanded(child: Container(), flex: 2),
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
}
