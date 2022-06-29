import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fvm/Util/AppTheme.dart';

import 'package:flutter/material.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

import '../../Util/AppImages.dart';

class OTPScreen extends StatefulWidget {
  static const name = '/otp';

  @override
  _OTPScreen createState() => _OTPScreen("+5193333333389");
}

class _OTPScreen extends State<OTPScreen> {
  late CustomAppTheme customAppTheme;
  late BuildContext buildContext;
  late ThemeData themeData;
  var phoneNumber;

  _OTPScreen(this.phoneNumber);

  var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController();

  // ..text = "123456";

  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

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
      backgroundColor: customAppTheme.blackTrans00,
      key: scaffoldKey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: customAppTheme.textDark),
        shadowColor: customAppTheme.blackTrans00,
        backgroundColor: customAppTheme.blackTrans00,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
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
                              text: phoneNumber,
                              style: TextStyle(color: Colors.black)),
                        ],
                        style: TextStyle(color: Colors.black54, fontSize: 15)),
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
                  hasError ? "*Please fill up all the cells properly" : "",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          formKey.currentState?.validate();
                          // conditions for validating
                          if (currentText.length != 6 ||
                              currentText != "123456") {
                            errorController.add(ErrorAnimationType
                                .shake); // Triggering error shake animation
                            setState(() {
                              hasError = true;
                            });
                          } else {
                            setState(() {
                              hasError = false;
                              scaffoldKey.currentState?.showSnackBar(SnackBar(
                                content: Text("Aye!!"),
                                duration: Duration(seconds: 2),
                              ));
                            });
                          }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OTPScreen()));
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
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
                            borderRadius: BorderRadius.all(Radius.circular(8)),
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
                Expanded(child: Container()),
                Container(
                  padding: EdgeInsets.all(10),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(text: "Didn't receive the code? ", children: [
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
    );
  }
}
