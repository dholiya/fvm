import 'package:flutter/material.dart';
import 'package:fvm/Util/AppTheme.dart';
import 'package:fvm/View/auth/Login.dart';
import 'package:fvm/main.dart';
import '../../Util/Util.dart';
import '../../Util/AppImages.dart';

class RegisterScreen extends StatefulWidget {
  static const name = '/register';

  @override
  _RegisterScreen createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final userController = TextEditingController();
  final passwordConfirmController = TextEditingController();
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
                      child: Center(
                        child: Text("Welcome",
                            style: AppTheme.getTextStyle(
                                color: customAppTheme.black,
                                themeData.textTheme.headline4,
                                fontWeight: 800)),
                      ),
                      flex: 3),
                  Image.asset(
                    AppImages.register,
                    height: 150,
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
                              userController,
                              'Username',
                              TextInputType.emailAddress,
                              Icons.person_rounded,
                              Icons.ac_unit),
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
                          userInput(
                              passwordConfirmController,
                              'Confirm password',
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
                                  'Register',
                                  style: AppTheme.getTextStyle(
                                      color: customAppTheme.white,
                                      themeData.textTheme.headline6,
                                      fontWeight: 700),
                                ),
                              ),
                            ),
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
                          'Already have an account? ',
                          style: TextStyle(
                              color: customAppTheme.textlight,
                              fontStyle: FontStyle.italic),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: Text(
                            'Login',
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
