import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fvm/Util/AppString.dart';
import 'package:fvm/Util/AppTheme.dart';
import 'package:fvm/Widget/DropDownCustom.dart';
import 'dart:math' as math;

import '../../Util/Util.dart';
import '../CardProduct.dart';
import 'TakePictureScreen.dart';

class YourProduct extends StatefulWidget {
  static const name = '/yourProduct';

  @override
  _YourProduct createState() => _YourProduct();
}

class _YourProduct extends State<YourProduct> {
  late CustomAppTheme customAppTheme;
  late ThemeData themeData;
  bool isProductListed = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    customAppTheme = CustomAppTheme();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 64),
          child: Center(
            child: Container(
                alignment: Alignment.center,
                child: isProductListed
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            Center(
                              child: Icon(Icons.line_style_rounded,
                                  color: customAppTheme.white, size: 250),
                            ),
                            Center(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.1),
                                child: Text("You haven't added any product yet",
                                    style: AppTheme.getTextStyle(
                                        themeData.textTheme.bodyText1,
                                        color: themeData.disabledColor,
                                        fontWeight: 600)),
                              ),
                            )
                          ])
                    : SingleChildScrollView(
                        padding: EdgeInsets.only(bottom: 64),
                        child: Container(
                            // padding: EdgeInsets.symmetric(horizontal: 12),
                            // child: MasonryGridView.count(
                            //   shrinkWrap: true,
                            //   crossAxisCount: 2,
                            //   mainAxisSpacing: 10,
                            //   crossAxisSpacing: 12,
                            //   physics: const NeverScrollableScrollPhysics(),
                            //   itemCount: Util.imgListFav.length,
                            //   itemBuilder: (context, index) {
                            //     return CardProduct(
                            //       Util.imgListFav[index],
                            //       onCardClick: (cardIndex) {},
                            //       onFavClick: () {
                            //         setState(() {});
                            //       },
                            //     );
                            //   },
                            // )
                            ),
                      )),
          ),
        ),
      ),
    );
  }
}
