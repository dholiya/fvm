import 'dart:io';
import 'package:camera/camera.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fvm/Controller/product/seller/AddProductController.dart';
import 'package:fvm/Controller/product/seller/AddProductParent.dart';
import 'package:fvm/Controller/product/seller/EditProductController.dart';
import 'package:fvm/Controller/product/seller/EditProductParent.dart';
import 'package:fvm/Model/CommonModel.dart';
import 'package:fvm/Model/product/seller/SellerProductsModel.dart';
import 'package:fvm/Util/ApiList.dart';
import 'package:fvm/Util/AppString.dart';
import 'package:fvm/Util/AppTheme.dart';
import 'package:fvm/Widget/DropDownCustom.dart';

import '../../Util/Util.dart';
import 'TakePictureScreen.dart';
import 'package:intl/intl.dart';

class EditProduct extends StatefulWidget {
  static const name = '/editproduct';

  SellerProductsModelData sellerProductsModelData;

  EditProduct(this.sellerProductsModelData);

  @override
  _EditProduct createState() => _EditProduct(this.sellerProductsModelData);
}

class _EditProduct extends State<EditProduct> implements EditProductController {
  late CustomAppTheme customAppTheme;
  late ThemeData themeData;
  final nameController = TextEditingController();
  final shortController = TextEditingController();
  final longController = TextEditingController();
  final tagController = TextEditingController();
  final priceController = TextEditingController();

  List<String> tagList = <String>[];

  var firstCamera;
  late BuildContext buildContext;

  String date = "";
  String productID="";

  EditProductParent? _parent;

  // SellerProductsModelData productData = new SellerProductsModelData();

  var selectedCategory = "";
  var image;

  _EditProduct(SellerProductsModelData s) {
    _parent = EditProductParent(this);
    if (s != null) {
      selectedCategory =
          (s.category == null || s.category!.isEmpty || s.category == ""
              ? ""
              : s.category!);
      image = s.images;
      productID = s.sId!;
      nameController.text = s.name!;
      priceController.text = s.basePrice!.toString();
      shortController.text = s.shortDescription!;
      longController.text = s.longDescription!;
      Util.consoleLog("tag : " + s.tag.toString());
      DateFormat df = DateFormat('yyyy-MM-dd HH:mm');
      DateTime dt = df.parse(s.bidEndDate!.toString());
      date = DateFormat.y().format(dt)+"-"+DateFormat.M().format(dt)+"-"+DateFormat.d().format(dt)+" "+DateFormat.Hm().format(dt);

      tagList.addAll(s.tag!);
      Util.consoleLog("get select cate : " + s.category.toString());
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    buildContext = context;
    customAppTheme = CustomAppTheme();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit product data"),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 64),
          child: Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                image?.length == null
                    ? Container()
                    : CarouselSlider(
                        items: [
                          for (var i in image)
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
                          height: 250.0,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          aspectRatio: 1 / 1,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          viewportFraction: 0.8,
                        ),
                      ),
                Container(
                  padding: EdgeInsets.only(bottom: 10, top: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Name",
                    style: AppTheme.getTextStyle(
                        color: customAppTheme.primary,
                        themeData.textTheme.bodyText1,
                        fontWeight: 700),
                  ),
                ),
                userInput(nameController, 'Enter product name',
                    TextInputType.name, 1),
                Container(
                  padding: EdgeInsets.only(bottom: 10, top: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Price",
                    style: AppTheme.getTextStyle(
                        color: customAppTheme.primary,
                        themeData.textTheme.bodyText1,
                        fontWeight: 700),
                  ),
                ),
                userInput(priceController, 'Enter initial price',
                    TextInputType.number, 1),
                Container(
                  padding: EdgeInsets.only(bottom: 10, top: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Short description",
                    style: AppTheme.getTextStyle(
                        color: customAppTheme.primary,
                        themeData.textTheme.bodyText1,
                        fontWeight: 700),
                  ),
                ),
                userInput(shortController, 'Enter short description',
                    TextInputType.name, 2),
                Container(
                  padding: EdgeInsets.only(bottom: 10, top: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Long description",
                    style: AppTheme.getTextStyle(
                        color: customAppTheme.primary,
                        themeData.textTheme.bodyText1,
                        fontWeight: 700),
                  ),
                ),
                userInput(longController, 'Enter Long description',
                    TextInputType.multiline, 5),
                DropDownCustom(
                  customAppTheme: customAppTheme,
                  themeData: themeData,
                  onSelect: (category) {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                  selected: selectedCategory,
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 10, top: 20),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Text(
                        "Add tags",
                        style: AppTheme.getTextStyle(
                            color: customAppTheme.primary,
                            themeData.textTheme.bodyText1,
                            fontWeight: 700),
                      ),
                      Expanded(child: Container()),
                      Text(
                        "Hit GO to confirm tag",
                        style: AppTheme.getTextStyle(
                          color: customAppTheme.primary,
                          themeData.textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
                userInput(tagController, 'Enter tag name', TextInputType.name, 1),
                tagList.length != 0
                    ? Align(
                        alignment: Alignment.topLeft,
                        child: Wrap(
                            alignment: WrapAlignment.start,
                            spacing: 8.0, // gap between adjacent chips
                            runSpacing: 4.0, // gap between lines
                            children: tagList
                                .map((item) => Container(
                                    padding: EdgeInsets.all(6),
                                    margin: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                      color: customAppTheme.white,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(item.toString()),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              tagList.remove(item);
                                            });
                                          },
                                          child: Icon(Icons.close_rounded,
                                              size: 16,
                                              color: customAppTheme.primary),
                                        ),
                                      ],
                                    )))
                                .toList()),
                      )
                    : Container(),
                Container(
                  padding: EdgeInsets.only(bottom: 10, top: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Bid end Date",
                    style: AppTheme.getTextStyle(
                        color: customAppTheme.primary,
                        themeData.textTheme.bodyText1,
                        fontWeight: 700),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    color: customAppTheme.white,
                  ),
                  child: Row(children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Icon(
                        Icons.calendar_today_rounded,
                        color: customAppTheme.primary,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        date,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.1,
                            color: customAppTheme.blackTransBB),
                      ),
                    )
                  ]),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Map<String, String> tagsJson = Map();

                    tagList.asMap().forEach((index, value) {
                      tagsJson["tag[${index}]"] = value;
                    });

                    _parent?.loadData({
                      'name': nameController.text.toString().trim(),
                      'short_description':
                          shortController.text.toString().trim(),
                      'long_description': longController.text.toString(),
                      'base_price': priceController.text.toString(),
                      'category': selectedCategory.toString(),
                      'seller_id': Util.loginData!.data!.sId!
                    },productID);

                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 25),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: customAppTheme.primary,
                      ),
                      child: Text(
                        'Update Product',
                        style: AppTheme.getTextStyle(
                            color: customAppTheme.white,
                            themeData.textTheme.headline6,
                            fontWeight: 700),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget userInput(TextEditingController controller, String hintTitle,
      TextInputType keyboardType, int maxline) {
    return Container(
      child: TextFormField(
        inputFormatters: [
          if (controller == priceController)
            FilteringTextInputFormatter.allow(RegExp(r'^\d{1,4}\.?\d{0,2}')),
          // if (controller == priceController)
          //   new LengthLimitingTextInputFormatter(4)
          // else
          if (controller == nameController)
            LengthLimitingTextInputFormatter(15)
          else if (controller == shortController)
            LengthLimitingTextInputFormatter(100)
          else if (controller == tagController)
            LengthLimitingTextInputFormatter(10)
        ],
        controller: controller,
        textInputAction: controller == tagController
            ? TextInputAction.go
            : TextInputAction.next,
        autofocus: false,
        maxLines: maxline,
        onFieldSubmitted: (value) {
          Util.consoleLog("onEditingComplete");
          setState(() {
            if (controller == tagController &&
                (tagController.text != null && tagController.text != "")) {
              if (tagList.length > 6) {
                Util.createSnackBar("Max 7 tag allowed", context,
                    customAppTheme.colorError, customAppTheme.white);
                return;
              }
              tagList.add(tagController.text);
              tagController.text = "";
              value == "";
            }
          });
        },
        obscureText:
            keyboardType == TextInputType.visiblePassword ? true : false,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          filled: true,
          fillColor: customAppTheme.white,
          hintText: hintTitle,
          prefix: controller == priceController
              ? Text(AppString.doller + " ",
                  style: TextStyle(color: customAppTheme.black))
              : Container(width: 0),
          hintStyle: TextStyle(color: customAppTheme.blackTrans88),
          contentPadding: EdgeInsets.all(14),
          focusedBorder: Util.noBorder8(),
          enabledBorder: Util.noBorder8(),
        ),
      ),
    );
  }

  @override
  void onLoadEditCompleted(CommonModel items) {
    Util.createSnackBar(
        items.msg, context, customAppTheme.colorError, customAppTheme.white);
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
