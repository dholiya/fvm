import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fvm/Controller/auth/LoginController.dart';
import 'package:fvm/Controller/auth/LoginParent.dart';
import 'package:fvm/Controller/auth/UpdateProfileController.dart';
import 'package:fvm/Controller/auth/UpdateProfileParent.dart';
import 'package:fvm/Model/CommonModel.dart';
import 'package:fvm/Model/auth/LoginModel.dart';
import 'package:fvm/Util/AppImages.dart';
import 'package:fvm/Util/AppString.dart';
import 'package:fvm/Util/AppTheme.dart';
import 'package:fvm/Util/SpUtil.dart';
import 'package:fvm/Widget/DesignsCom.dart';
import 'package:fvm/Widget/Dialogs.dart';
import '../../Util/Util.dart';

class ProfilePage extends StatefulWidget {
  static const name = '/profile';

  @override
  _ProfilePage createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage>
    implements UpdateProfileController, LoginController {
  late CustomAppTheme customAppTheme;
  late ThemeData themeData;
  UpdateProfileParent? _parent;
  LoginParent? _loginParent;

  final emailController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final passwordOldController = TextEditingController();
  final passwordController = TextEditingController();
  int? select = 5;
  bool
      editFirst = false,
      editLast = false,
      editPassword = false,
      editGender = false;
  var apiState = 0;
  int  btnState=0; // 0 = show button, 1= loading

  var errMsg = null;

  _ProfilePage() {
    _parent = UpdateProfileParent(this);
    _loginParent = LoginParent(this);
    emailController.text = Util.loginData!.data!.email!;
    firstnameController.text = Util.loginData!.data!.firstName!;
    lastnameController.text = Util.loginData!.data!.lastName!;

    select = Util.loginData!.data!.gender=="Male"?0:Util.loginData!.data!.gender=="Female"?1:5;
    apiState = 1;
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    customAppTheme = CustomAppTheme();
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child:  apiState == 0
            ? DesignsCom.ApiState0(customAppTheme)
            : apiState == 3
            ? DesignsCom.ApiState3(
            themeData, errMsg, Icons.person_rounded)
            : apiState == 1
            ? SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(bottom: 50, top: 10, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: ClipOval(child: Image.asset(AppImages.register)),
                ),
                Text(
                  Util.loginData!.data!.firstName.toString() +
                      " " +
                      Util.loginData!.data!.lastName.toString(),
                  style: AppTheme.getTextStyle(
                      color: customAppTheme.primary,
                      themeData.textTheme.bodyText1,
                      fontWeight: 700),
                ),
                SizedBox(height: 20),
                userInput(emailController, 'Email', TextInputType.emailAddress,
                    Icons.email_rounded, Icons.ac_unit, false),
                userInput(firstnameController, 'First name', TextInputType.name,
                    Icons.person_rounded, Icons.ac_unit, editFirst),
                userInput(lastnameController, 'Last name', TextInputType.name,
                    Icons.person, Icons.ac_unit, editLast),
                !editPassword?
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: customAppTheme.primary,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left:30, bottom: 5),
                        child: Text("Update Password", style: AppTheme.getTextStyle(
                            themeData.textTheme.bodyText1,
                            fontWeight: 800,
                            fontSize: 16
                        )),
                      ),
                      Expanded(child: Container()),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            editPassword = true;
                          });
                        },
                        child: Text(
                          'Edit',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: customAppTheme.primary),
                        ),
                      ),
                    ],
                  ),
                )
                    :
                Column(
                  children: [
                    userInput(
                        passwordOldController,
                        'Enter Old password',
                        TextInputType.visiblePassword,
                        Icons.lock_rounded,
                        Icons.visibility_off_rounded, editPassword),
                    userInput(
                        passwordController,
                        'Enter new Password',
                        TextInputType.visiblePassword,
                        Icons.lock_rounded,
                        Icons.visibility_off_rounded, editPassword),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: Row(
                    children: <Widget>[
                      addRadioButton(0, 'Male'),
                      addRadioButton(1, 'Female'),
                      // addRadioButton(2, 'Other'),
                    ],
                  ),
                ),
                if(editFirst == true || editPassword ==true || editLast ==true || editGender == true)
                _updateBtn(),
              ],
            ),
          ),
        ): DesignsCom.ApiState4(themeData),
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
            editGender = true;
            select = val as int?;
          });
        },
      ),
    );
  }

  Widget userInput(TextEditingController controller, String hintTitle,
      TextInputType keyboardType, IconData iconData, IconData ac_unit, bool enable) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: customAppTheme.primary,
          ),
          borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left:30, bottom: 5),
            child: Text(hintTitle, style: AppTheme.getTextStyle(
                themeData.textTheme.bodyText1,
                fontWeight: 800,
                fontSize: 16
            )),
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller,
                  textInputAction: TextInputAction.next,
                  autofocus: false,
                  enabled: enable,
                  obscureText: keyboardType == TextInputType.visiblePassword ? true : false,
                  keyboardType: keyboardType,
                  decoration: InputDecoration(
                    filled: true,
                    prefixIcon: enable?GestureDetector(
                      onTap: () {},
                      child: Icon(
                        iconData,
                        color: customAppTheme.primary,
                      ),
                    ):SizedBox(width: 0),
                    fillColor: enable? customAppTheme.white :customAppTheme.primaryBackground,
                    hintText: hintTitle,
                    hintStyle: TextStyle(color: customAppTheme.blackTrans88),
                    contentPadding: EdgeInsets.all(14),
                    focusedBorder: Util.noBorder8(),
                    enabledBorder: Util.noBorder8(),
                  ),
                ),
              ),
              if(controller == firstnameController || controller == lastnameController )
              TextButton(
                onPressed: () {
                  setState(() {
                    if (controller == firstnameController) editFirst = true;
                    else if (controller == lastnameController) editLast = true;
                  });
                },
                child: Text(
                  'Edit',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: customAppTheme.primary),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _updateBtn() {
    if (btnState == 0) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {

          _update();
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
              'Update Profile',
              style: AppTheme.getTextStyle(
                  color: customAppTheme.white,
                  themeData.textTheme.headline6,
                  fontWeight: 700),
            ),
          ),
        ),
      );
    } else if (btnState == 1) {
      return Padding(
        padding: EdgeInsets.only(top:20.0,bottom: 20.0),
        child: CircularProgressIndicator(
          backgroundColor: themeData.colorScheme.primary,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    }
    else {
      return Padding(
        padding: EdgeInsets.only(top:20.0,bottom: 20.0),
        child: Icon(Icons.check, color: themeData.colorScheme.primary,size: 34),
      );
    }
  }



  _update() {
    var firstName = firstnameController.text.toString().trim();
    var lastName = lastnameController.text.toString().trim();
    var gender = select == 0 ? "Male" : "Female";
    var oldPassword = passwordOldController.text.toString().trim();
    var password =passwordController.text.toString().trim();

    if(!validation(firstName, lastName, gender, oldPassword.toString().trim(), password)) return;

    _parent?.loadData({
      if(editFirst)'first_name': firstName,
      if(editLast)'last_name': lastName,
      if(editGender)'gender': gender,
      if(editPassword)'password': password
    },Util.loginData!.data!.sId.toString());
    setState((){
      btnState = 1;
    });
  }

  bool validation(firstName, lastName, gender, oldPassword, password) {
    if (editFirst && firstName.isEmpty) {
      Util.createSnackBar("Enter first name", context,
          customAppTheme.primaryVariant, customAppTheme.white);
      return false;
    } else if (editLast && lastName.isEmpty) {
      Util.createSnackBar("Enter last name", context,
          customAppTheme.primaryVariant, customAppTheme.white);
      return false;
    } else if ( editPassword &&  oldPassword.isEmpty) {
      Util.createSnackBar("Enter old password", context,
          customAppTheme.primaryVariant, customAppTheme.white);
      return false;
    } else if (editPassword && password.isEmpty) {
      Util.createSnackBar("Enter new password", context,
          customAppTheme.primaryVariant, customAppTheme.white);
      return false;
    } else if (editPassword && oldPassword != Util.loginData!.data!.password!.toString().trim()) {
      Util.createSnackBar("Incorrect old password", context,
          customAppTheme.primaryVariant, customAppTheme.white);
      return false;
    } else {
      return true;
    }
  }



  @override
  void onLoadUpdateCompleted(LoginModel items) {
    _loginParent?.loadData({
      'email': emailController.text.toString(),
      'password': editPassword?passwordController.text.toString():Util.loginData!.data!.password!.toString()
    });

  }

  @override
  void onLoadUpdateConnection(connection) {
    Dialogs.internetDialogRetry(themeData, context).then((value) {
      value == false
          ? SystemNavigator.pop()
          : setState(() {
        apiState = 0;
        _update();
      });
    });
    setState(() {
      apiState = 2;
    });
  }

  @override
  void onLoadUpdateError(CommonModel items) {
    setState(() {
      items.status == 300 ? apiState = 3 : apiState = 4;
      errMsg = items.msg;
    });
  }

  @override
  Future<void> onLoadCompleted(LoginModel items) async {
     await SpUtil.setUserData(items)!.then((value) {
         Util.loginData = SpUtil.getUserData();
          emailController.text = Util.loginData!.data!.email!;
          firstnameController.text = Util.loginData!.data!.firstName!;
          lastnameController.text = Util.loginData!.data!.lastName!;
          select = Util.loginData!.data!.gender=="Male"?0:Util.loginData!.data!.gender=="Female"?1:5;
     });
     setState(() {
       editFirst = false;
       editLast = false;
       editPassword = false;
       editGender = false;
     });

     setState(() {
       apiState = 1;
     });
     setState((){
       btnState = 0;
     });
  }

  @override
  void onLoadConnection(connection) {
    Dialogs.internetDialogRetry(themeData, context).then((value) {
      value == false
          ? SystemNavigator.pop()
          : setState(() {
        apiState = 0;
        _loginParent?.loadData({
          'email': emailController.text.toString(),
          'password': editPassword?passwordController.text.toString():passwordOldController.text.toString()
        });
      });
    });
    setState(() {
      apiState = 2;
    });
  }

  @override
  void onLoadError(CommonModel items) {
    setState(() {
      items.status == 300 ? apiState = 3 : apiState = 4;
      errMsg = items.msg;
    });
  }


}
