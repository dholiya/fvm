import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fvm/Util/AppString.dart';
import 'package:fvm/Util/SpUtil.dart';
import 'package:fvm/View/auth/Login.dart';

import '../TabHandler.dart';
import '../SplashScreen.dart';
import '../Util/AppTheme.dart';

class CustomDrawer extends StatefulWidget {
  final Function onSelectedItem;
  final int currentPage;

  const CustomDrawer(
      {super.key, required this.currentPage, required this.onSelectedItem});

  @override
  _CustomDrawer createState() => _CustomDrawer();
}

class _CustomDrawer extends State<CustomDrawer> {
  int _selectedDestination = 0;
  late CustomAppTheme customAppTheme;
  late ThemeData themeData;
  late BuildContext buildContext;

  // final _key = GlobalKey();
  List<bool> isSelected = <bool>[];

  @override
  void initState() {
    isSelected = [true, false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    buildContext = context;
    themeData = Theme.of(context);
    customAppTheme = CustomAppTheme();
    _selectedDestination = widget.currentPage;
    return Column(
      children: [
        Expanded(
            child: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                // key: _key,
                decoration: BoxDecoration(
                  color: customAppTheme.primary,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 60,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: customAppTheme.primaryVariant,
                        child: Text("FVM",
                            style: AppTheme.getTextStyle(
                                themeData.textTheme.bodyText1,
                                color: themeData.colorScheme.onBackground,
                                fontWeight: 900)),
                      ),
                    ),
                    _toggleButton(),
                  ],
                ),
              ),
              ListTile(
                selectedColor: customAppTheme.primary,
                leading: Icon(Icons.home_rounded),
                title: Text(AppString.home,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                textColor: customAppTheme.textDark,
                onTap: () {
                  setState(() {
                    widget.onSelectedItem(0);
                    _selectedDestination == 0;
                  });
                },
                selected: _selectedDestination == 0,
              ),
              ListTile(
                selectedColor: customAppTheme.primary,
                leading: Icon(Icons.star_rounded),
                textColor: customAppTheme.textDark,
                title: Text(AppString.favorite,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                onTap: () {
                  setState(() {
                    widget.onSelectedItem(1);
                    _selectedDestination == 1;
                    log('data: $_selectedDestination');
                  });
                },
                selected: _selectedDestination == 1,
              ),
              ListTile(
                selectedColor: customAppTheme.primary,
                leading: Icon(Icons.person_rounded),
                textColor: customAppTheme.textDark,
                title: Text(AppString.profile,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                onTap: () {
                  setState(() {
                    widget.onSelectedItem(2);
                    _selectedDestination == 2;
                    log('data: $_selectedDestination');
                  });
                },
                selected: _selectedDestination == 2,
              ),
              Divider(),
              ListTile(
                selectedColor: customAppTheme.primary,
                leading: Icon(Icons.logout_rounded),
                textColor: customAppTheme.textDark,
                title: Text(AppString.logOut,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                onTap: () {
                  setState(() {
                    Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.name, (Route<dynamic> route) => false);
                  });
                },
              ),
            ],
          ),
        )),
      ],
    );
  }

  Widget _toggleButton() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(6),
          child: Text(AppString.sellerMode,
              style: TextStyle(
                  color: customAppTheme.whiteTextlight2,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
        ),
        Switch(
          value: SplashScreen.isSeller,
          onChanged: (value) {
            setState(() {
              if (SplashScreen.isSeller) {
                SpUtil.setIsSellerMode(false);
                setState(() {
                  SplashScreen.isSeller = false;
                });
                Navigator.of(buildContext).pushNamedAndRemoveUntil(
                    TabHandler.name, (Route<dynamic> route) => false);
              } else {
                SpUtil.setIsSellerMode(true);
                setState(() {
                  SplashScreen.isSeller = true;
                });
                Navigator.of(buildContext).pushNamedAndRemoveUntil(
                    TabHandler.name, (Route<dynamic> route) => false);
              }
            });
          },
          activeTrackColor: customAppTheme.btnDisable,
          activeColor: customAppTheme.primaryVariant,
        )
      ],
    );
  }
}
