import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fvm/Controller/product/buyer/PlacebidController.dart';
import 'package:fvm/Controller/product/buyer/PlacebidParent.dart';
import 'package:fvm/Controller/product/seller/EditProductController.dart';
import 'package:fvm/Controller/product/seller/EditProductParent.dart';
import 'package:fvm/Model/CommonModel.dart';
import 'package:fvm/Model/product/buyer/ProductsModel.dart';
import 'package:fvm/Util/ApiList.dart';
import 'package:fvm/Util/AppString.dart';
import 'package:fvm/Util/Util.dart';
import 'package:fvm/Widget/DesignsCom.dart';
import 'package:fvm/Widget/Dialogs.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';
import '../../Util/AppTheme.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ViewProductDetails extends StatefulWidget {
  static const name = '/viewProductDetails';
  ProductsModelData productsModelData;

  ViewProductDetails(this.productsModelData);

  @override
  _ViewProductDetails createState() => _ViewProductDetails(productsModelData);
}

class _ViewProductDetails extends State<ViewProductDetails>
    implements PlacebidController, EditProductController {
  late CustomAppTheme customAppTheme;
  late ThemeData themeData;
  ProductsModelData products = new ProductsModelData();

  PlacebidParent? _parent;
  EditProductParent? _editProductParent;

  var date = "";
  var bids;
  var currentHighest;

  final priceController = TextEditingController();

  int apiState = 0;

  _ViewProductDetails(productsModelData) {
    _parent = PlacebidParent(this);
    _editProductParent = EditProductParent(this);

    if (productsModelData != null) {
      products = productsModelData;
      Util.consoleLog(products.bidEndDate.toString());

      DateFormat df = DateFormat('yyyy-MM-dd HH:mm');
      DateTime dt =
          df.parse(products.bidEndDate.toString().replaceFirst("T", " "));

      date = DateFormat.y().format(dt) +
          "-" +
          DateFormat.M().format(dt) +
          "-" +
          DateFormat.d().format(dt) +
          " " +
          DateFormat.Hm().format(dt);

      bids = products.bids.toString();
      currentHighest = products.currentHighestBid.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    customAppTheme = CustomAppTheme();
    return Scaffold(
      appBar: AppBar(
        title: Text("Preview"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CarouselSlider(
                items: [
                  for (var i in products.images!)
                    Container(
                      margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(Api.images + i),
                        ),
                      ),
                    ),
                ],
                //Slider Container properties
                options: CarouselOptions(
                  height: 400,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 1 / 1,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        products.name!,
                        style: AppTheme.getTextStyle(
                            themeData.textTheme.bodyText1,
                            color: customAppTheme.textDark,
                            fontSize: 20,
                            fontWeight: 800),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            "Base price:",
                            style: AppTheme.getTextStyle(
                                themeData.textTheme.bodyText1,
                                color: customAppTheme.textDark,
                                fontSize: 16,
                                fontWeight: 600),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            AppString.doller + products.basePrice.toString(),
                            style: AppTheme.getTextStyle(
                                themeData.textTheme.bodyText1,
                                color: customAppTheme.textDark,
                                fontSize: 16,
                                fontWeight: 800),
                          ),
                        ),
                        Expanded(child: Container())
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            "Bid end date:",
                            style: AppTheme.getTextStyle(
                                themeData.textTheme.bodyText1,
                                color: customAppTheme.textDark,
                                fontSize: 16,
                                fontWeight: 600),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            date.toString(),
                            style: AppTheme.getTextStyle(
                                themeData.textTheme.bodyText1,
                                color: customAppTheme.textDark,
                                fontSize: 16,
                                fontWeight: 800),
                          ),
                        ),
                        Expanded(child: Container())
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            "Current highest bid:",
                            style: AppTheme.getTextStyle(
                                themeData.textTheme.bodyText1,
                                color: customAppTheme.textDark,
                                fontSize: 16,
                                fontWeight: 600),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            AppString.doller +
                                products.currentHighestBid.toString(),
                            style: AppTheme.getTextStyle(
                                themeData.textTheme.bodyText1,
                                color: customAppTheme.textDark,
                                fontSize: 16,
                                fontWeight: 800),
                          ),
                        ),
                        Expanded(child: Container())
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            "Number of bid:",
                            style: AppTheme.getTextStyle(
                                themeData.textTheme.bodyText1,
                                color: customAppTheme.textDark,
                                fontSize: 16,
                                fontWeight: 600),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            products.bids.toString(),
                            style: AppTheme.getTextStyle(
                                themeData.textTheme.bodyText1,
                                color: customAppTheme.textDark,
                                fontSize: 16,
                                fontWeight: 800),
                          ),
                        ),
                        Expanded(child: Container())
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      products.shortDescription!,
                      style: AppTheme.getTextStyle(
                          themeData.textTheme.bodyText1,
                          color: customAppTheme.textDark,
                          fontSize: 14,
                          fontWeight: 600),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                    child: Text(
                      "Description:",
                      style: AppTheme.getTextStyle(
                          themeData.textTheme.bodyText1,
                          color: customAppTheme.textDark,
                          fontSize: 14,
                          fontWeight: 800),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      products.shortDescription!,
                      style: AppTheme.getTextStyle(
                          themeData.textTheme.bodyText1,
                          color: customAppTheme.textDark,
                          fontSize: 14,
                          fontWeight: 600),
                    ),
                  ),
                  products.buyerId.toString()=="null"?Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      userInput(priceController, 'Enter bid value',
                          TextInputType.number, 1),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              if(priceController.text.toString().trim().isEmpty || double.parse(priceController.text)<1){
                                Util.createSnackBar(
                                    "Please enter valid bid amount", context, customAppTheme.colorError, customAppTheme.white);
                                return;
                              }
                              _parent?.loadData({
                                'product_id': products.sId.toString(),
                                'user_id':
                                    Util.loginData?.data!.sId!.toString(),
                                'bid_date': DateFormat('yyyy-MM-dd HH:mm')
                                    .parse(DateTime.now().toString())
                                    .toString(),
                                'bid_amount':
                                    priceController.text.toString().trim(),
                                'email': Util.loginData?.data?.email.toString()
                              });

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
                              "Place bid",
                              style: AppTheme.getTextStyle(
                                  color: customAppTheme.white,
                                  themeData.textTheme.bodyText2,
                                  letterSpacing: 1.2,
                                  fontWeight: 600),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ):Container(
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                      color:customAppTheme.colorError,
                      child: Text("Sold out", style: AppTheme.getTextStyle(
                          themeData.textTheme.bodyMedium,
                          color: customAppTheme.white,
                          fontWeight: 800
                      ))
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget userInput(TextEditingController controller, String hintTitle,
      TextInputType keyboardType, int maxline) {
    return Container(
      padding: EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width * 0.5,
      child: TextFormField(
        inputFormatters: [
          if (controller == priceController)
            FilteringTextInputFormatter.allow(RegExp(r'^\d{1,3}\.?\d{0,2}')),
        ],
        controller: controller,
        textInputAction: TextInputAction.go,
        autofocus: false,
        maxLines: maxline,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          filled: true,
          fillColor: customAppTheme.white,
          hintText: hintTitle,
          prefix: Text(AppString.doller + " "),
          hintStyle: TextStyle(color: customAppTheme.blackTrans88),
          contentPadding: EdgeInsets.all(14),
          focusedBorder: Util.noBorder8(),
          enabledBorder: Util.noBorder8(),
        ),
      ),
    );
  }

  @override
  void onLoadBIDCompleted(CommonModel items) {
    if (products.currentHighestBid == null) products.currentHighestBid = 0;
    if (products.bids == null) products.bids = 0;

    setState(() {
      apiState = 0;
      currentHighest = products.currentHighestBid! > double.parse(priceController.text.toString())
          ? products.currentHighestBid.toString()
          : priceController.text.toString();
      bids = (int.parse(products.bids.toString()) + 1).toString();
    });

    _editProductParent?.loadData({
      'seller_id': products.sellerId!,
      'current_highest_bid': currentHighest,
      'bids': bids,
    }, products.sId.toString());
  }

  @override
  void onLoadBIDConnection(connection) {
    Dialogs.internetDialogRetry(themeData, context).then((value) {
      value == false
          ? SystemNavigator.pop()
          : setState(() {
        apiState = 0;
        if(priceController.text.toString().trim().isEmpty || double.parse(priceController.text)<1){
          Util.createSnackBar(
              "Please enter valid bid amount", context, customAppTheme.colorError, customAppTheme.white);
          return;
        }
        _parent?.loadData({
          'product_id': products.sId.toString(),
          'user_id':
          Util.loginData?.data!.sId!.toString(),
          'bid_date': DateFormat('yyyy-MM-dd HH:mm')
              .parse(DateTime.now().toString())
              .toString(),
          'bid_amount':
          priceController.text.toString().trim(),
          'email': Util.loginData?.data?.email.toString()
        });

      });
    });
    setState(() {
      apiState = 2;
    });
  }

  @override
  void onLoadBIDError(CommonModel items) {
    Util.createSnackBar(
        items.msg, context, customAppTheme.colorError, customAppTheme.white);
  }



  @override
  void onLoadEditCompleted(CommonModel items) {
    setState(() {
      products.currentHighestBid = double.tryParse(currentHighest);
      products.bids = int.tryParse(bids);
      priceController.text = "";
      FocusManager.instance.primaryFocus
          ?.unfocus();
      setState(() {
        apiState = 1;
      });
    });

    Util.createSnackBar(items.msg, context, customAppTheme.colorSuccess, customAppTheme.white);
  }

  @override
  void onLoadEditConnection(connection) {
    Dialogs.internetDialogRetry(themeData, context).then((value) {
      value == false
          ? SystemNavigator.pop()
          : setState(() {
        apiState = 0;
        _editProductParent?.loadData({
          'seller_id': products.sellerId!,
          'current_highest_bid': currentHighest,
          'bids': bids,
        }, products.sId.toString());
      });
    });
    setState(() {
      apiState = 2;
    });

  }

  @override
  void onLoadEditError(CommonModel items) {
    Util.createSnackBar(
        items.msg, context, customAppTheme.colorError, customAppTheme.white);
  }
}
