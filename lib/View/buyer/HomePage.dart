import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fvm/Controller/product/ProductController.dart';
import 'package:fvm/Controller/product/ProductParent.dart';
import 'package:fvm/Model/CommonModel.dart';
import 'package:fvm/Model/product/ProductsModel.dart';
import 'package:fvm/Util/AppString.dart';
import 'package:fvm/Util/AppTheme.dart';
import 'package:fvm/Util/Util.dart';
import 'dart:io';
import 'package:fvm/View/CardProduct.dart';
import 'package:fvm/View/ViewProductDetails.dart';
import '../../Util/AppImages.dart';
import '../../Widget/Dialogs.dart';

class HomePage extends StatefulWidget {
  static const name = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements ProductController {
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
  final searchController = TextEditingController();
  ProductParent? _parent;
  ProductsModel _productsModel = new ProductsModel();
  var apiState = 0;

  _HomePageState() {
    _parent = ProductParent(this);
    _parent?.loadData();
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    customAppTheme = CustomAppTheme();
    return Scaffold(
      body: apiState == 0
          ? Center(
              child: CircularProgressIndicator(
                  strokeWidth: 4, color: customAppTheme.primaryVariant))
          : apiState == 2
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(30),
                      child: Center(
                          child: Text(
                        AppString.noInternetConnection,
                        textAlign: TextAlign.center,
                        style: AppTheme.getTextStyle(
                            themeData.textTheme.bodyText1,
                            color: customAppTheme.textDark,
                            fontSize: 16,
                            fontWeight: 700),
                      )),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              apiState == 0;
                              _parent?.loadData();
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              color: customAppTheme.primary,
                            ),
                            child: Text(
                              AppString.retry,
                              style: AppTheme.getTextStyle(
                                  color: customAppTheme.white,
                                  themeData.textTheme.bodyText2,
                                  letterSpacing: 1.2,
                                  fontWeight: 600),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              : apiState == 3
                  ? Container(
                      padding: EdgeInsets.all(30),
                      child: Center(
                          child: Text(
                        AppString.somethingWrong,
                        textAlign: TextAlign.center,
                        style: AppTheme.getTextStyle(
                            themeData.textTheme.bodyText1,
                            color: customAppTheme.textDark,
                            fontSize: 16,
                            fontWeight: 700),
                      )),
                    )
                  : SingleChildScrollView(
                      padding: EdgeInsets.only(bottom: 64),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 85,
                                  child: TextField(
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      filled: true,
                                      suffixIcon: GestureDetector(
                                          onTap: () {
                                            Util.createSnackBar(
                                                "sad",
                                                context,
                                                customAppTheme.btnDisable,
                                                customAppTheme.primary);
                                          },
                                          child: Icon(
                                            Icons.search_rounded,
                                            color: customAppTheme.primarylite,
                                          )),
                                      fillColor: Colors.white,
                                      hintText: 'Search...',
                                      contentPadding: EdgeInsets.all(14),
                                      focusedBorder: Util.noBorder8(),
                                      enabledBorder: Util.noBorder8(),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(),
                                ),
                                Expanded(
                                  flex: 10,
                                  child: GestureDetector(
                                    onTap: () {
                                      Dialogs.filterBarBottom(
                                          context, themeData, customAppTheme);
                                    },
                                    child: Util.ButtonDesignIcon(
                                        Icons.sort_rounded,
                                        customAppTheme,
                                        themeData),
                                  ),
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              },
                            child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                child: MasonryGridView.count(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 12,
                                  itemCount: _productsModel.data?.length,
                                  itemBuilder: (context, index) {
                                    return CardProduct(
                                      _productsModel.data![index],
                                      onCardClick: () {
                                        setState((){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (buildContext) => ViewProductDetails(_productsModel.data![index])));
                                        });
                                      },
                                      onFavClick: () {


                                      },
                                    );
                                  },
                                )),
                          ),
                        ],
                      ),
                    ),
    );
  }

  @override
  void onLoadCompleted(ProductsModel items) {
    setState(() {
      _productsModel = items;
      apiState = 1;
    });
  }

  @override
  void onLoadConnection(connection) {
    Util.createSnackBar(
        connection, context, customAppTheme.colorError, customAppTheme.white);
    setState(() {
      apiState = 2;
    });
  }

  @override
  void onLoadError(CommonModel items) {
    Util.createSnackBar(
        items.msg, context, customAppTheme.colorError, customAppTheme.white);
    setState(() {
      apiState = 3;
    });
  }
}
