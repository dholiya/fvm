import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fvm/Controller/auth/VerifyOTPController.dart';
import 'package:fvm/Controller/auth/VerifyOTPParent.dart';
import 'package:fvm/Model/CommonModel.dart';
import 'package:fvm/Util/AppTheme.dart';
import 'package:fvm/Util/Util.dart';
import 'package:fvm/View/auth/Login.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../Util/AppImages.dart';

class OTPScreen extends StatefulWidget {
  static const name = '/otp';
  var email;

  OTPScreen(this.email);

  @override
  _OTPScreen createState() => _OTPScreen();
}

class _OTPScreen extends State<OTPScreen> implements VerifyOTPController {
  late CustomAppTheme customAppTheme;
  late BuildContext buildContext;
  late ThemeData themeData;
  var onTapRecognizer;

  final passwordController = TextEditingController();
  TextEditingController textEditingController = TextEditingController();

  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  VerifyOTPParent? _parent;

  _OTPScreen() {
    _parent = VerifyOTPParent(this);
  }

  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    customAppTheme = CustomAppTheme();
    buildContext = context;
    return Scaffold(
      backgroundColor: customAppTheme.white,
      key: scaffoldKey,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Align(
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'OTP Verification',
                        style: AppTheme.getTextStyle(
                            color: customAppTheme.primary,
                            themeData.textTheme.headline4,
                            fontWeight: 800),
                        textAlign: TextAlign.center,
                      ),
                      Image.asset(
                        AppImages.otp,
                        fit: BoxFit.fill,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: RichText(
                          text: TextSpan(
                              text: "Enter the code sent to ",
                              children: [
                                TextSpan(
                                    text: widget.email,
                                    style: TextStyle(color: Colors.black)),
                              ],
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 15)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        child: Form(
                          key: formKey,
                          child: Container(
                              child: PinCodeTextField(
                            appContext: context,
                            pastedTextStyle: TextStyle(
                              color: customAppTheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                            length: 6,
                            obscureText: false,
                            obscuringCharacter: '*',
                            animationType: AnimationType.fade,
                            validator: (v) {
                              if (v!.isEmpty) return "It's null";
                              if (v.length < 6)
                                return "I'm from validator";
                              else
                                return null;
                            },
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(5),
                              fieldHeight: 60,
                              inactiveColor: customAppTheme.primaryVariant,
                              activeColor: customAppTheme.primaryVariantLite,
                              fieldWidth: 50,
                              inactiveFillColor: customAppTheme.primaryVariant,
                              activeFillColor: hasError
                                  ? customAppTheme.primaryBackground
                                  : Colors.white,
                            ),
                            cursorColor: Colors.black,
                            animationDuration: Duration(milliseconds: 300),
                            textStyle: TextStyle(fontSize: 20, height: 1.6),
                            enableActiveFill: true,
                            controller: textEditingController,
                            errorAnimationController: errorController,
                            keyboardType: TextInputType.number,
                            boxShadows: [
                              BoxShadow(
                                offset: Offset(0, 1),
                                color: Colors.black12,
                                blurRadius: 10,
                              )
                            ],
                            onCompleted: (v) {
                              print("Completed");
                            },
                            // onTap: () {
                            //   print("Pressed");
                            // },
                            onChanged: (value) {
                              print(value);
                              setState(() {
                                currentText = value;
                              });
                            },
                            beforeTextPaste: (text) {
                              print("Allowing to paste $text");
                              return true;
                            },
                          )),
                        ),
                      ),
                      Text(
                        hasError
                            ? "*Please fill up all the cells properly"
                            : "",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                      userInput(
                          passwordController,
                          'New Password',
                          TextInputType.visiblePassword,
                          Icons.lock_rounded,
                          Icons.visibility_off_rounded),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                // formKey.currentState?.validate();
                                // conditions for validating
                                // if (currentText.length != 6 ||
                                //     currentText != "123456") {
                                //   errorController.add(ErrorAnimationType
                                //       .shake); // Triggering error shake animation
                                //   setState(() {
                                //     hasError = true;
                                //   });
                                // } else {
                                //   setState(() {
                                //     hasError = false;
                                //     scaffoldKey.currentState
                                //         ?.showSnackBar(SnackBar(
                                //       content: Text("Aye!!"),
                                //       duration: Duration(seconds: 2),
                                //     ));
                                //   });
                                // }
                                if (passwordController.text
                                    .toString()
                                    .trim()
                                    .isEmpty) {
                                  Util.createSnackBar(
                                      "Enter password",
                                      context,
                                      customAppTheme.primaryVariant,
                                      customAppTheme.white);
                                  return;
                                } else if (currentText.length == 6) {
                                  _parent?.loadData({
                                    'email': widget.email.toString(),
                                    'otp': currentText.toString(),
                                    'password': passwordController.text
                                        .toString()
                                        .trim()
                                  });
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  color: customAppTheme.primary,
                                ),
                                child: Text(
                                  'Verify',
                                  style: AppTheme.getTextStyle(
                                      color: customAppTheme.white,
                                      themeData.textTheme.headline5,
                                      fontWeight: 700),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                textEditingController.clear();
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  color: customAppTheme.primary,
                                ),
                                child: Text(
                                  'Clear',
                                  style: AppTheme.getTextStyle(
                                      color: customAppTheme.white,
                                      themeData.textTheme.headline5,
                                      fontWeight: 700),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: "Didn't receive the code? ",
                              style: TextStyle(
                                  color: customAppTheme.primary, fontSize: 16),
                              children: [
                                TextSpan(
                                    text: "RESEND",
                                    recognizer: onTapRecognizer,
                                    style: TextStyle(
                                        color: customAppTheme.primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16))
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(buildContext);
              },
            )
          ],
        ),
      ),
    );
  }


  Widget userInput(TextEditingController controller, String hintTitle,
      TextInputType keyboardType, IconData iconData, IconData ac_unit) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
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
  void onLoadCompleted(CommonModel items) {
    Util.consoleLog("1");
    if (items.status == 200){
      Util.consoleLog("2");
      Util.createSnackBar(
          items.msg, context, customAppTheme.colorError, customAppTheme.white);
      Util.consoleLog("3");
      Navigator.of(context).pushNamedAndRemoveUntil(
          LoginScreen.name, (Route<dynamic> route) => false);
    }else {
      Util.consoleLog("4");
      Util.createSnackBar(
          items.msg, context, customAppTheme.colorError, customAppTheme.white);

    }
  }

  @override
  void onLoadConnection(connection) {
    Util.createSnackBar(
        connection, context, customAppTheme.colorError, customAppTheme.white);
  }

  @override
  void onLoadError(CommonModel items) {
    Util.consoleLog("5");
    Util.createSnackBar(
        items.msg, context, customAppTheme.colorError, customAppTheme.white);
  }
}
