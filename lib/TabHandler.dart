import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fvm/Model/auth/LoginModel.dart';
import 'package:fvm/SplashScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:fvm/Util/AppString.dart';
import 'package:fvm/Util/SpUtil.dart';
import 'package:fvm/View/sellermode/AddProduct.dart';
import 'package:fvm/View/sellermode/YourProduct.dart';
import 'package:fvm/Widget/bottombar/fancy_bottom_navigation.dart';
import 'Util/AppTheme.dart';
import 'Util/Util.dart';
import 'View/buyer/FavoritePage.dart';
import 'View/buyer/HomePage.dart';
import 'View/buyer/ProfilePage.dart';
import 'View/drawer.dart';

class TabHandler extends StatefulWidget {
  static String name = '/tabhandler';

  @override
  _TabHandlerState createState() => _TabHandlerState();
}

class _TabHandlerState extends State<TabHandler> {
  late CustomAppTheme customAppTheme;
  int currentPage = 0;
  GlobalKey bottomNavigationKey = GlobalKey();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    Util.loginData = SpUtil.getUserData();
  }

    @override
  Widget build(BuildContext context) {
    customAppTheme = CustomAppTheme();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        shadowColor: customAppTheme.blackTrans00,
        title: Text(SplashScreen.isSeller?currentPage==0? AppString.listYourProduct: currentPage==1?AppString.yourProduct:AppString.profile:AppString.AppName),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child: _getPage(currentPage),
        ),
      ),
      bottomNavigationBar: FancyBottomNavigation(
        textColor: customAppTheme.primary,
        tabs: [
          SplashScreen.isSeller
              ? TabData(
              iconData: Icons.line_style_rounded,
              title: AppString.addProduct,
              onclick: () {
                final FancyBottomNavigationState fState =
                bottomNavigationKey.currentState
                as FancyBottomNavigationState;
                fState.setPage(2);
              })
              : TabData(
              iconData: Icons.home_rounded,
              title: AppString.home,
              onclick: () {
                final FancyBottomNavigationState fState =
                bottomNavigationKey.currentState
                as FancyBottomNavigationState;
                fState.setPage(2);
              }),
          SplashScreen.isSeller
              ? TabData(
              iconData: Icons.view_list,
              title: AppString.yourProduct,
              onclick: () {
                final FancyBottomNavigationState fState =
                bottomNavigationKey.currentState
                as FancyBottomNavigationState;
                fState.setPage(2);
              })
              : TabData(
            iconData: Icons.star_rounded,
            title: AppString.favorite,
            // onclick: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => SecondPage()))
          ),
          TabData(iconData: Icons.person_rounded, title: AppString.profile)
        ],
        initialSelection: 0,
        key: bottomNavigationKey,
        onTabChangedListener: (position) {
          setState(() {
            currentPage = position;
          });
        },
      ),
      drawer: Container(
        child: CustomDrawer(
            currentPage: currentPage,
            onSelectedItem: (onSelectedItem) {
              setState(() {
                currentPage = onSelectedItem;
                scaffoldKey.currentState?.openEndDrawer();
                _getPage(onSelectedItem);
                final FancyBottomNavigationState fState = bottomNavigationKey
                    .currentState as FancyBottomNavigationState;
                fState.setPage(currentPage);
              });
            }),
      ),
    );
  }

  _getPage(int page) {
    switch (page) {
      case 0:
        return SplashScreen.isSeller?AddProduct():HomePage();
      case 1:
        return SplashScreen.isSeller?YourProduct():FavoritePage();
      default:
        return ProfilePage();
    }
  }
}
