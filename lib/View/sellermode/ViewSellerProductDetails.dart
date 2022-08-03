import 'package:flutter/material.dart';
import 'package:fvm/Controller/product/buyer/BidsByIDAmountController.dart';
import 'package:fvm/Controller/product/buyer/BidsByIDAmountParent.dart';
import 'package:fvm/Controller/product/buyer/PlacebidController.dart';
import 'package:fvm/Controller/product/seller/EditProductController.dart';
import 'package:fvm/Controller/product/seller/EditProductParent.dart';
import 'package:fvm/Model/CommonModel.dart';
import 'package:fvm/Model/product/buyer/BidsByIDAmountModel.dart';
import 'package:fvm/Model/product/buyer/ProductsModel.dart';
import 'package:fvm/Model/product/seller/SellerProductsModel.dart';
import 'package:fvm/Util/ApiList.dart';
import 'package:fvm/Util/AppString.dart';
import 'package:fvm/Util/AppTheme.dart';
import 'package:fvm/Util/Util.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ViewSellerProductDetails extends StatefulWidget {
  static const name = '/viewProductDetails';
  SellerProductsModelData productsModelData;

  ViewSellerProductDetails(this.productsModelData);

  @override
  _ViewSellerProductDetails createState() =>
      _ViewSellerProductDetails(productsModelData);
}

class _ViewSellerProductDetails extends State<ViewSellerProductDetails>
    implements EditProductController, BidsByIDAmountController {
  late CustomAppTheme customAppTheme;
  late ThemeData themeData;
  SellerProductsModelData products = new SellerProductsModelData();

  var date = "";

  int apiState = 0;

  EditProductParent? _parent;
  BidsByIDAmountParent? _bidsByIDAmountParent;

  BidsByIDAmountModel bidData = new BidsByIDAmountModel();

  _ViewSellerProductDetails(productsModelData) {
    _parent = EditProductParent(this);
    _bidsByIDAmountParent = BidsByIDAmountParent(this);

    Util.consoleLog("sas" + products.buyerId.toString());

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
                          image: NetworkImage(
                            Api.images + i,
                          ),
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
                  products.buyerId != "null"
                      ? Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  "Congratulations contact highest bidder contact details:",
                                  style: AppTheme.getTextStyle(
                                      themeData.textTheme.bodyText1,
                                      color: customAppTheme.textDark,
                                      fontSize: 24,
                                      fontWeight: 600),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  products.buyerEmail.toString(),
                                  style: AppTheme.getTextStyle(
                                      themeData.textTheme.bodyText1,
                                      color: customAppTheme.textDark,
                                      fontSize: 16,
                                      fontWeight: 800),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _bidsByIDAmountParent?.loadData({
                                    'product_id': products.sId,
                                    'bid_amount':
                                        products.currentHighestBid.toString()
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
                                  "Close deal",
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onLoadBitAmountCompleted(BidsByIDAmountModel items) {

    Util.consoleLog("comple" + items.data!.toString());

    bidData = items;
    products.buyerId =items.data!.userId.toString();
    products.buyerEmail = items.data!.email.toString();

        _parent?.loadData({
      'seller_id': products.sellerId,
      'buyer_email': items.data!.email.toString(),
      'buyer_id': items.data!.userId.toString()
    }, products.sId);
  }

  @override
  void onLoadBitAmountConnection(connection) {
    Util.createSnackBar(
        connection, context, customAppTheme.colorError, customAppTheme.white);
  }

  @override
  void onLoadBitAmountError(CommonModel items) {
    Util.consoleLog("error");

    Util.createSnackBar(
        items.msg, context, customAppTheme.colorError, customAppTheme.white);
  }

  @override
  void onLoadEditCompleted(CommonModel items) {
    Util.createSnackBar("Deal close successfully", context,
        customAppTheme.colorError, customAppTheme.white);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (buildContext) =>
                ViewSellerProductDetails(
                   products)));

    setState(() {
      apiState = 1;
    });
  }

  @override
  void onLoadEditConnection(connection) {
    Util.createSnackBar(
        connection, context, customAppTheme.colorError, customAppTheme.white);
  }

  @override
  void onLoadEditError(CommonModel items) {
    Util.createSnackBar(
        items.msg, context, customAppTheme.colorError, customAppTheme.white);
  }
}
