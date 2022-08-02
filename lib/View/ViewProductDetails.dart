import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fvm/Model/product/ProductsModel.dart';
import 'package:fvm/Util/ApiList.dart';
import '../Util/AppTheme.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ViewProductDetails extends StatefulWidget {
  static const name = '/viewProductDetails';
  ProductsModelData productsModelData;

  ViewProductDetails(this.productsModelData);

  @override
  _ViewProductDetails createState() => _ViewProductDetails();
}

class _ViewProductDetails extends State<ViewProductDetails> {
  late CustomAppTheme customAppTheme;
  late ThemeData themeData;



  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    customAppTheme = CustomAppTheme();
    return Scaffold(
      appBar: AppBar(
        title: Text("Preview"),
      ),
      body: Column(
        children: [
          CarouselSlider(
            items: [
              for (var i in widget.productsModelData.images!)
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(
                      Api.images+i,
                    ),
                    ),
                  ),
                ),
            ],
            //Slider Container properties
            options: CarouselOptions(
              height: 350.0,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  widget.productsModelData.name!,
                  style: AppTheme.getTextStyle(themeData.textTheme.bodyText1,
                      color: customAppTheme.textDark,
                      fontSize: 16,
                      fontWeight: 900),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  widget.productsModelData.basePrice.toString(),
                  style: AppTheme.getTextStyle(themeData.textTheme.bodyText1,
                      color: customAppTheme.textDark,
                      fontSize: 16,
                      fontWeight: 800),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  widget.productsModelData.longDescription!,
                  style: AppTheme.getTextStyle(themeData.textTheme.bodyText1,
                      color: customAppTheme.textDark,
                      fontSize: 14,
                      fontWeight: 700),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
