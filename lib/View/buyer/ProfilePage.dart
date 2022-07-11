import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fvm/Util/AppImages.dart';
import 'package:fvm/Util/AppString.dart';
import 'package:fvm/Util/AppTheme.dart';

import '../../Util/Util.dart';
import '../sellermode/AddProduct.dart';

class ProfilePage extends StatefulWidget {
  static const name = '/profile';

  @override
  _ProfilePage createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  late CustomAppTheme customAppTheme;
  late ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    customAppTheme = CustomAppTheme();
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
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
              'Full Name',
              style: AppTheme.getTextStyle(
                  color: customAppTheme.primary,
                  themeData.textTheme.bodyText1,
                  fontWeight: 700),
            ),
            Container(
              padding: EdgeInsets.only(top: 50),
              alignment: Alignment.centerLeft,
              child: Text(
                AppString.email,
                style: AppTheme.getTextStyle(
                    color: customAppTheme.primary,
                    themeData.textTheme.bodyText1,
                    fontWeight: 700),
              ),
            ),
            userInput(Icons.email_rounded, "example@gmail.com"),
            GestureDetector(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddProduct()));


              },
              child: Container(
                padding: EdgeInsets.only(top: 50),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Saller temp",
                  style: AppTheme.getTextStyle(
                      color: customAppTheme.primary,
                      themeData.textTheme.bodyText1,
                      fontWeight: 700),
                ),
              ),
            ),
            // userInput(Icons.phone, "No address")
          ],
        ),
      ),
    );
  }

  Widget userInput(IconData iconData, lable) {
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: TextFormField(
        autofocus: false,
        enabled: false,
        decoration: InputDecoration(
          filled: true,
          prefixIcon: GestureDetector(
            onTap: () {},
            child: Icon(
              iconData,
              color: customAppTheme.primary,
            ),
          ),
          fillColor: customAppTheme.white,
          labelText: lable,
          labelStyle: TextStyle(color: customAppTheme.blackTransBB),
          contentPadding: EdgeInsets.all(14),
          focusedBorder: Util.noBorder8(),
          enabledBorder: Util.noBorder8(),
        ),
      ),
    );
  }
}
