import 'package:flutter/material.dart';
import 'package:fvm/Model/product/buyer/ProductsModel.dart';
import 'package:fvm/Util/ApiList.dart';
import 'package:fvm/Util/AppString.dart';

import '../../Util/AppTheme.dart';
import '../../Util/Util.dart';

class CardProduct extends StatefulWidget {
  ProductsModelData product;
  final Function onCardClick;
  final Function onFavClick;

  CardProduct(this.product,
      {required this.onCardClick, required this.onFavClick});

  @override
  _CardProduct createState() => _CardProduct();
}

class _CardProduct extends State<CardProduct> {
  late CustomAppTheme customAppTheme;
  late ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    customAppTheme = CustomAppTheme();
    return GestureDetector(
      onTap: () {
          widget.onCardClick();
      },
      child: Container(
        padding: EdgeInsets.only(top: 8),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Column(
              children: [
                if (widget.product.images?.length != 0)
                  // for (var i in widget.product?.images[0])
                  Stack(
                    children: [
                      Image.network(
                        Api.images + widget.product.images![0],
                        fit: BoxFit.fill,
                      ),
                      widget.product.buyerId.toString()=="null"?Container():Positioned(
                        top: -7.0,
                        right: -24.0,
                        child: Container(
                          padding: EdgeInsets.only(top: 20),
                          child: RotationTransition(
                            turns: AlwaysStoppedAnimation(45 / 360),
                            child: Container(
                                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                                color:customAppTheme.colorError,
                                child: Text("Sold out", style: AppTheme.getTextStyle(
                                    themeData.textTheme.overline,
                                    color: customAppTheme.white,
                                   fontWeight: 800
                                ))
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                Container(
                  padding: EdgeInsets.all(6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.product.name.toString(),
                              maxLines: 2,
                              overflow: TextOverflow.fade,
                              style: AppTheme.getTextStyle(
                                  themeData.textTheme.bodyText1,
                                  color: customAppTheme.textDark,
                                  fontSize: 16,
                                  fontWeight: 700),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Text("Price: ",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500)),
                                Expanded(
                                  child: Text("${AppString.doller}" +
                                      widget.product.basePrice.toString(),
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            // Util.favList.contains(widget.product.sId!)?
                            widget.onFavClick();
                          });
                        },
                        child: Icon(
                            widget.product.favoriteBy!.contains(Util.loginData?.data!.sId)
                                ? Icons.star_rounded
                                : Icons.star_border_rounded,
                            color: customAppTheme.primary,
                            size: 24),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
