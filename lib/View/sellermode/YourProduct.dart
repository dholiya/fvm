import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fvm/Controller/product/seller/DeleteSellerProductController.dart';
import 'package:fvm/Controller/product/seller/DeleteSellerProductParent.dart';
import 'package:fvm/Controller/product/seller/SellerProductController.dart';
import 'package:fvm/Controller/product/seller/SellerProductParent.dart';
import 'package:fvm/Model/CommonModel.dart';
import 'package:fvm/Model/product/seller/SellerProductsModel.dart';
import 'package:fvm/Util/AppString.dart';
import 'package:fvm/Util/AppTheme.dart';
import 'package:fvm/View/sellermode/CardSellerProduct.dart';
import 'package:fvm/View/sellermode/EditProduct.dart';
import 'package:fvm/View/sellermode/ViewSellerProductDetails.dart';
import '../../Util/Util.dart';

class YourProduct extends StatefulWidget {
  static const name = '/yourProduct';

  @override
  _YourProduct createState() => _YourProduct();
}

class _YourProduct extends State<YourProduct>
    implements SellerProductController, DeleteSellerProductController {
  late CustomAppTheme customAppTheme;
  late ThemeData themeData;

  SellerProductParent? _parent;
  SellerProductsModel _sellerProductsModel = new SellerProductsModel();

  DeleteSellerProductParent? _deleteSellerProductParent;

  var apiState = 0;

  _YourProduct() {
    _deleteSellerProductParent = DeleteSellerProductParent(this);
    _parent = SellerProductParent(this);
    _parent?.loadData();
  }

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
                  ? Center(
                      child: Column(
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
                                        color: themeData.primaryColor,
                                        fontWeight: 600)),
                              ),
                            )
                          ]),
                    )
                  : SingleChildScrollView(
                      padding: EdgeInsets.only(bottom: 64),
                      child: Column(
                        children: [
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: MasonryGridView.count(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 12,
                                itemCount: _sellerProductsModel.data?.length,
                                itemBuilder: (context, index) {
                                  return CardSellerProduct(
                                    _sellerProductsModel.data![index],
                                    onEditClick: () {
                                      setState(() {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (buildContext) =>
                                                    EditProduct(
                                                        _sellerProductsModel
                                                            .data![index])));
                                      });
                                    },
                                    onDeleteClick: () {
                                      _deleteSellerProductParent?.loadData(
                                          _sellerProductsModel
                                              .data![index].sId);
                                    },
                                    onCardClick: () {
                                      setState(() {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (buildContext) =>
                                                    ViewSellerProductDetails(
                                                        _sellerProductsModel
                                                            .data![index])));
                                      });
                                    },
                                  );
                                },
                              )),
                        ],
                      ),
                    ),
    );
  }

  @override
  void onLoadCompleted(SellerProductsModel items) {
    setState(() {
      _sellerProductsModel = items;
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

  @override
  void onLoadDeleteCompleted(CommonModel items) {
    setState(() {
      apiState = 0;
    });
    Util.createSnackBar(
        items.msg, context, customAppTheme.colorError, customAppTheme.white);
    _parent?.loadData();
  }

  @override
  void onLoadDeleteConnection(connection) {
    Util.createSnackBar(
        connection, context, customAppTheme.colorError, customAppTheme.white);
  }

  @override
  void onLoadDeleteError(CommonModel items) {
    Util.createSnackBar(items.msg, context, customAppTheme.colorError, customAppTheme.white);
  }
}
