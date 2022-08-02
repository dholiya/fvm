
import 'package:flutter/material.dart';
import 'package:fvm/Controller/auth/RegisterController.dart';
import 'package:fvm/Controller/auth/RegistrationParent.dart';
import 'package:fvm/Model/CommonModel.dart';
import 'package:fvm/Model/auth/RegisterModel.dart';
import 'package:fvm/Util/AppTheme.dart';
import 'package:fvm/View/auth/Login.dart';
import '../../Util/Util.dart';
import '../../Util/AppImages.dart';

class RegisterScreen extends StatefulWidget {
  static const name = '/register';

  @override
  _RegisterScreen createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen>
    implements RegisterController {
  final emailController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final passwordController = TextEditingController();
  late CustomAppTheme customAppTheme;
  late BuildContext buildContext;
  late ThemeData themeData;
  int? select = 5;

  RegistrationParent? _parent;

  _RegisterScreen() {
    _parent = RegistrationParent(this);
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    customAppTheme = CustomAppTheme();
    buildContext = context;
    return Scaffold(
      backgroundColor: customAppTheme.white,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Center(
                      child: Text("Welcome",
                          style: AppTheme.getTextStyle(
                              color: customAppTheme.primary,
                              themeData.textTheme.headline4,
                              fontWeight: 800)),
                    ),
                    Image.asset(
                      AppImages.register,
                      height: MediaQuery.of(context).size.height * 0.2,
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
                                firstnameController,
                                'First name',
                                TextInputType.name,
                                Icons.person_rounded,
                                Icons.ac_unit),
                            userInput(
                                lastnameController,
                                'Last name',
                                TextInputType.name,
                                Icons.person,
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
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 20),
                              child: Row(
                                children: <Widget>[
                                  addRadioButton(0, 'Male'),
                                  addRadioButton(1, 'Female'),
                                ],
                              ),
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                var firstName =
                                    firstnameController.text.toString().trim();
                                var lastName =
                                    lastnameController.text.toString().trim();
                                var gender = select == 0 ? "Male" : "Female";
                                var dob = "1000-02-02T00:00:00";
                                var isSeller = "false";
                                var email =
                                    emailController.text.toString().trim();
                                var password =
                                    passwordController.text.toString().trim();
                                var cPassword = passwordConfirmController.text
                                    .toString()
                                    .trim();

                                if(!validation(firstName, lastName, gender, email,
                                    password, cPassword)) return;

                                _parent?.loadData({
                                  'first_name': firstName,
                                  'last_name': lastName,
                                  'gender': gender,
                                  'dob': dob,
                                  'is_seller': isSeller,
                                  'email': email,
                                  'password': password
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

  addRadioButton(int btnValue, String title) {
    return Expanded(
      flex: 1,
      child: RadioListTile(
        value: btnValue,
        contentPadding: EdgeInsets.all(0),
        title: Text(title),
        groupValue: select,
        onChanged: (val) {
          setState(() {
            select = val as int?;
          });
        },
      ),
    );
  }

  Widget userInput(TextEditingController controller, String hintTitle,
      TextInputType keyboardType, IconData iconData, IconData ac_unit) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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


  bool validation(String firstName, String lastName, String gender,
      String email, String password, String cPassword) {
    if (firstName.isEmpty) {
      Util.createSnackBar("Enter first name", context,
          customAppTheme.primaryVariant, customAppTheme.white);
      return false;
    } else if (lastName.isEmpty) {
      Util.createSnackBar("Enter last name", context,
          customAppTheme.primaryVariant, customAppTheme.white);
      return false;
    } else if (select == 5) {
      Util.createSnackBar("Enter gender", context,
          customAppTheme.primaryVariant, customAppTheme.white);
      return false;
    } else if (email.isEmpty) {
      Util.createSnackBar("Enter email", context,
          customAppTheme.primaryVariant, customAppTheme.white);
      return false;
    }else if(password.isEmpty){
      Util.createSnackBar("Enter password", context,
          customAppTheme.primaryVariant, customAppTheme.white);
      return false;
    }else if(cPassword.isEmpty){
      Util.createSnackBar("Enter confirm password", context,
          customAppTheme.primaryVariant, customAppTheme.white);
      return false;
    }else if(password!=cPassword){
      Util.createSnackBar("Password and confirm password must be same", context,
          customAppTheme.primaryVariant, customAppTheme.white);
      return false;
    }else{
      return true;
    }
  }

  @override
  void onLoadCompleted(RegisterModel items) {
    Navigator.of(context).pushNamedAndRemoveUntil(
        LoginScreen.name, (Route<dynamic> route) => false);
  }

  @override
  void onLoadConnection(connection) {
    Util.createSnackBar(
        connection, context, customAppTheme.colorError, customAppTheme.white);
  }

  @override
  void onLoadError(CommonModel items) {
    Util.createSnackBar(
        items.msg, context, customAppTheme.colorError, customAppTheme.white);
  }

}
