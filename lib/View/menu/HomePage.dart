import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fvm/Util/AppString.dart';
import 'package:fvm/Util/AppTheme.dart';
import 'package:fvm/Util/Util.dart';
import 'package:fvm/View/CardProduct.dart';
import '../../Util/AppImages.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _imgList = <String>[
    AppImages.coffeTable,
    AppImages.smallFan,
    AppImages.ryobi40vTrimmer,
    AppImages.iphone13128GB,
    AppImages.coffeTable,
    AppImages.smallFan,
    AppImages.ryobi40vTrimmer
  ];
  late CustomAppTheme customAppTheme;
  late ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    customAppTheme = CustomAppTheme();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    flex: 9,
                    child: TextField(
                      autofocus: false,
                      decoration: InputDecoration(
                        filled: true,
                        suffixIcon: Icon(Icons.search_rounded),
                        fillColor: Colors.white,
                        hintText: 'Search...',
                        contentPadding:EdgeInsets.all(14),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Util.ButtonDesignIcon(Icons.sort_rounded, customAppTheme, themeData),
                  )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: MasonryGridView.count(
                  shrinkWrap: true,
                  // use this
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 12,
                  itemCount: _imgList.length,
                  itemBuilder: (context, index) {
                    return CardProduct(_imgList[index]);
                  },
                )),
          ],
        ),
      ),
    );
  }
}
