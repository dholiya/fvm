import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Util/AppString.dart';
import '../Util/AppTheme.dart';
import '../Util/Util.dart';

class Dialogs {
  Dialogs();

  ///////////////////////////[ create Contest from Bottom ] /////////////////
  static filterBarBottom(BuildContext dialogContext, ThemeData themeData,
      CustomAppTheme customAppTheme)
  {
    RangeValues _currentRangeValues = const RangeValues(40, 80);

    int selectedSortBy = 0;
    return showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.3),
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
                              padding: EdgeInsets.only(top: 15, left: 10, right: 10),
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
                                        AppString.doller + " 25",
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
                                        AppString.doller + " 252",
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
                              max: 100,
                              divisions: 5,
                              labels: RangeLabels(
                                _currentRangeValues.start.round().toString(),
                                _currentRangeValues.end.round().toString(),
                              ),
                              onChanged: (RangeValues values) {
                                setState(() {
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      setState((){
                                        selectedSortBy==0;
                                        Util.consoleLog("Hello");
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius:  BorderRadius.all(Radius.circular(10)),
                                        color: selectedSortBy==0?customAppTheme.primarylite:customAppTheme.primaryBackground,
                                      ),
                                      child: Text(
                                        "Number of Bids",
                                        style: AppTheme.getTextStyle(
                                          themeData.textTheme.bodyText1,
                                          color: selectedSortBy==0?customAppTheme.white:customAppTheme.primary,
                                          fontWeight: 600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  GestureDetector(
                                    onTap: (){
                                      setState((){
                                        selectedSortBy==1;
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(10)),
                                        color: selectedSortBy==1?customAppTheme.primarylite:customAppTheme.primaryBackground,
                                      ),
                                      child: Text(
                                        "Date of Post",
                                          style: AppTheme.getTextStyle(
                                            themeData.textTheme.bodyText1,
                                            color: selectedSortBy==1?customAppTheme.white:customAppTheme.primary,
                                            fontWeight: 600,
                                          )),
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  GestureDetector(
                                    onTap: (){
                                      setState((){
                                        selectedSortBy==2;
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(10)),
                                        color: selectedSortBy==2?customAppTheme.primarylite:customAppTheme.primaryBackground,
                                      ),
                                      child: Text(
                                        "Other",
                                        style: AppTheme.getTextStyle(
                                          themeData.textTheme.bodyText1,
                                          color: selectedSortBy==2?customAppTheme.white:customAppTheme.primary,
                                          fontWeight: 600,
                                        ),),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Container(
                            //     padding: EdgeInsets.all(10),
                            //     child: Row(
                            //       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //       // crossAxisAlignment: CrossAxisAlignment.center,
                            //       children: [
                            //         ,
                            //
                            //       ],
                            //     )
                            // ),

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
}
