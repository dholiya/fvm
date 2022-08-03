import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Util/AppString.dart';
import '../Util/AppTheme.dart';

class Dialogs {
  Dialogs();

  static int selectedSortBy = 999;
  static double minPriceSortBy = 0;
  static double maxPriceSortBy = 0;

  ///////////////////////////[ create Contest from Bottom ] /////////////////
  static filterBarBottom(BuildContext dialogContext, ThemeData themeData,
      CustomAppTheme customAppTheme, double minPrice, double maxPrice,
      {required Function(dynamic value, bool isApply) onSortBY,
      required Function(double min, double max, bool isApply) onPriceRange}) {
    RangeValues _currentRangeValues = RangeValues(minPriceSortBy, maxPriceSortBy);

    return showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.7),
      transitionDuration: Duration(milliseconds: 500),
      context: dialogContext,
      pageBuilder: (BuildContext context, __, ___) {
        dialogContext = context;
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return Material(
              color: customAppTheme.blackTrans00,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          margin: EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            color: customAppTheme.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 5,
                          width: MediaQuery.of(context).size.width * 0.07),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: customAppTheme.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12)),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(),
                                  Text(AppString.filter,
                                      style: AppTheme.getTextStyle(
                                          color: customAppTheme.textDark,
                                          letterSpacing: 0.20,
                                          themeData.textTheme.headline6,
                                          fontWeight: 800)),
                                  GestureDetector(
                                    onTap: () {

                                      Navigator.of(context).pop();
                                    },
                                    child: Icon(Icons.close_rounded,
                                        size: 30,
                                        color: customAppTheme.primarylite),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.all(10),
                                color: customAppTheme.primaryBackground,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Price Range",
                                    textAlign: TextAlign.center,
                                    style: AppTheme.getTextStyle(
                                        themeData.textTheme.bodyText1,
                                        fontSize: 18,
                                        fontWeight: 800),
                                  ),
                                )),
                            Container(
                              padding:
                                  EdgeInsets.only(top: 15, left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "MIN Price",
                                        textAlign: TextAlign.center,
                                        style: AppTheme.getTextStyle(
                                            themeData.textTheme.bodyText1,
                                            fontWeight: 800),
                                      ),
                                      Text(
                                        AppString.doller + minPrice.toString(),
                                        textAlign: TextAlign.center,
                                        style: AppTheme.getTextStyle(
                                            themeData.textTheme.bodyText1,
                                            color: customAppTheme.primary,
                                            fontWeight: 800),
                                      )
                                    ],
                                  ),
                                  Expanded(child: Container()),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "MAX Price",
                                        textAlign: TextAlign.center,
                                        style: AppTheme.getTextStyle(
                                            themeData.textTheme.bodyText1,
                                            fontWeight: 800),
                                      ),
                                      Text(
                                        AppString.doller + maxPrice.toString(),
                                        textAlign: TextAlign.center,
                                        style: AppTheme.getTextStyle(
                                            themeData.textTheme.bodyText1,
                                            color: customAppTheme.primary,
                                            fontWeight: 800),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            RangeSlider(
                              values: _currentRangeValues,
                              max: double.parse(maxPrice.toString()),
                              min: double.parse(minPrice.toString()),
                              divisions: 10,
                              labels: RangeLabels(
                                _currentRangeValues.start.round().toString(),
                                _currentRangeValues.end.round().toString(),
                              ),
                              onChanged: (RangeValues values) {
                                setState(() {
                                  minPriceSortBy = double.parse(
                                      _currentRangeValues.start.toString());
                                  maxPriceSortBy = double.parse(
                                      _currentRangeValues.end.toString());
                                  _currentRangeValues = values;
                                });
                              },
                            ),
                            Container(
                                padding: EdgeInsets.all(10),
                                color: customAppTheme.primaryBackground,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Sort By",
                                    textAlign: TextAlign.center,
                                    style: AppTheme.getTextStyle(
                                        themeData.textTheme.bodyText1,
                                        fontSize: 18,
                                        fontWeight: 800),
                                  ),
                                )),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Wrap(
                                alignment: WrapAlignment.start,
                                runSpacing: 8.0,
                                spacing: 8.0,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedSortBy == 0;
                                      });
                                      onSortBY(0, false);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        color: selectedSortBy == 0
                                            ? customAppTheme.primarylite
                                            : customAppTheme.primaryBackground,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "No. of Bids",
                                            style: AppTheme.getTextStyle(
                                              themeData.textTheme.subtitle2,
                                              color: selectedSortBy == 0
                                                  ? customAppTheme.white
                                                  : customAppTheme.primary,
                                              fontWeight: 600,
                                            ),
                                          ),
                                          Text(
                                            "⬆",
                                            style: AppTheme.getTextStyle(
                                                themeData.textTheme.bodyLarge,
                                                color: customAppTheme.primary,
                                                fontWeight: 900,
                                                fontSize: 20
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedSortBy == 1;
                                      });
                                      onSortBY(1,false);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        color: selectedSortBy == 1
                                            ? customAppTheme.primarylite
                                            : customAppTheme.primaryBackground,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "No. of Bids",
                                            style: AppTheme.getTextStyle(
                                              themeData.textTheme.subtitle2,
                                              color: selectedSortBy == 1
                                                  ? customAppTheme.white
                                                  : customAppTheme.primary,
                                              fontWeight: 600,
                                            ),
                                          ),
                                          Text(
                                            "⬇",
                                            style: AppTheme.getTextStyle(
                                                themeData.textTheme.bodyLarge,
                                                color: customAppTheme.primary,
                                                fontWeight: 900,
                                                fontSize: 20
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedSortBy == 2;
                                      });
                                      onSortBY(2,false);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        color: selectedSortBy == 2
                                            ? customAppTheme.primarylite
                                            : customAppTheme.primaryBackground,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text("High to low price",
                                              style: AppTheme.getTextStyle(
                                                themeData.textTheme.subtitle2,
                                                color: selectedSortBy == 2
                                                    ? customAppTheme.white
                                                    : customAppTheme.primary,
                                                fontWeight: 600,
                                              )),
                                          Text(
                                            "⬆",
                                            style: AppTheme.getTextStyle(
                                                themeData.textTheme.bodyLarge,
                                                color: customAppTheme.primary,
                                                fontWeight: 900,
                                                fontSize: 20
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedSortBy == 3;
                                      });
                                      onSortBY(3,false);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        color: selectedSortBy == 3
                                            ? customAppTheme.primarylite
                                            : customAppTheme.primaryBackground,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "Low to high price",
                                            style: AppTheme.getTextStyle(
                                              themeData.textTheme.subtitle2,
                                              color: selectedSortBy == 3
                                                  ? customAppTheme.white
                                                  : customAppTheme.primary,
                                              fontWeight: 600,
                                            ),
                                          ),
                                          Text(
                                            "⬇",
                                            style: AppTheme.getTextStyle(
                                              themeData.textTheme.bodyLarge,
                                                 color: customAppTheme.primary,
                                              fontWeight: 900,
                                              fontSize: 20
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(color: customAppTheme.btnDisable),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: (){

                                    setState(() {
                                      selectedSortBy = 999;
                                      minPriceSortBy = minPrice;
                                      maxPriceSortBy = maxPrice;
                                    });
                                    Navigator.of(context).pop();
                                   },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                      color: customAppTheme.primary,
                                    ),
                                    child: Text(
                                      'Clear',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: customAppTheme.white),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){


                                      if(maxPrice!=maxPriceSortBy || minPrice!=minPriceSortBy){
                                        onPriceRange(minPriceSortBy, maxPriceSortBy, true);
                                      }
                                      if(selectedSortBy !=999){
                                        onSortBY(selectedSortBy, true);
                                      }
                                      Navigator.of(context).pop();

                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius:BorderRadius.all(Radius.circular(8)),
                                      color: customAppTheme.primary,
                                      boxShadow:  [
                                        BoxShadow(
                                          color: customAppTheme.btnDisable,
                                          offset: Offset(0.5, 1.0), //(x,y)
                                          blurRadius: 5.0,
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      'Apply',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: customAppTheme.white),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          // child:
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
    // ??
    //     false;
  }

  static Future<bool> internetDialogRetry(ThemeData themeData, BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Container(
        margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.15),
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: new AlertDialog(
            insetPadding: EdgeInsets.all(0),
            actionsOverflowButtonSpacing: 0.0,
            shape: RoundedRectangleBorder(
              side:
                  BorderSide(color: themeData.colorScheme.onPrimary, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            titlePadding: EdgeInsets.only(top: 16, bottom: 0),
            contentPadding: EdgeInsets.all(10),
            actionsPadding: EdgeInsets.only(left: 0, bottom: 12, right: 0),
            title: Text(
              AppString.fvm,
              textAlign: TextAlign.center,
              style: AppTheme.getTextStyle(themeData.textTheme.headline4,
                  fontWeight: 800),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.signal_cellular_connected_no_internet_4_bar_outlined,
                    color: themeData.colorScheme.primary),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    AppString.noInternetConnection,
                    textAlign: TextAlign.center,
                    style: AppTheme.getTextStyle(themeData.textTheme.bodyText1,
                        fontWeight: 600),
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(true);
                          },
                          child: Container(
                            alignment: AlignmentDirectional.bottomCenter,
                            padding: EdgeInsets.only(
                                top: 8, bottom: 8, left: 18, right: 18),
                            decoration: BoxDecoration(
                              color: themeData.colorScheme.primary,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                            ),
                            child: Text(
                              AppString.retry,
                              textAlign: TextAlign.center,
                              style: AppTheme.getTextStyle(
                                  themeData.textTheme.bodyText2,
                                  color: themeData.colorScheme.onPrimary,
                                  fontWeight: 800),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(false);
                          },
                          child: Container(
                            alignment: AlignmentDirectional.bottomCenter,
                            padding: EdgeInsets.only(
                                top: 8, bottom: 8, left: 18, right: 18),
                            decoration: BoxDecoration(
                              color: themeData.colorScheme.primary,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                            ),
                            child: Text(
                              AppString.closeApp,
                              textAlign: TextAlign.center,
                              style: AppTheme.getTextStyle(
                                  themeData.textTheme.bodyText2,
                                  color: themeData.colorScheme.onPrimary,
                                  fontWeight: 800),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ).then((value) {
      return value;
    });
  }

// Column(
// crossAxisAlignment: CrossAxisAlignment.center,
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Container(
// padding: EdgeInsets.all(30),
// child: Center(
// child: Text(
// AppString.noInternetConnection,
// textAlign: TextAlign.center,
// style: AppTheme.getTextStyle(
// themeData.textTheme.bodyText1,
// color: customAppTheme.textDark,
// fontSize: 16,
// fontWeight: 700),
// )),
// ),
// Row(
// crossAxisAlignment: CrossAxisAlignment.center,
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// TextButton(
// onPressed: () {
// setState(() {
// apiState == 0;
// _parent?.loadData();
// });
// },
// child: Container(
// padding: EdgeInsets.all(10),
// alignment: Alignment.center,
// decoration: BoxDecoration(
// borderRadius:
// BorderRadius.all(Radius.circular(8)),
// color: customAppTheme.primary,
// ),
// child: Text(
// AppString.retry,
// style: AppTheme.getTextStyle(
// color: customAppTheme.white,
// themeData.textTheme.bodyText2,
// letterSpacing: 1.2,
// fontWeight: 600),
// ),
// ),
// ),
// ],
// )
// ],
// )
}
