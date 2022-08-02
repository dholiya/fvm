import 'package:flutter/material.dart';
import 'package:fvm/Model/product/ProductsModel.dart';
import 'package:fvm/Util/ApiList.dart';
import 'package:fvm/Util/AppString.dart';

import '../Util/AppTheme.dart';
import '../Util/Util.dart';

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
                  for (var i in widget.product.images!)
                    Image.network(
                      Api.images+i,
                      fit: BoxFit.fill,
                    ),
                Container(
                  padding: EdgeInsets.all(6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product.name.toString(),
                            style: AppTheme.getTextStyle(
                                themeData.textTheme.bodyText1,
                                color: customAppTheme.textDark,
                                fontSize: 16,
                                fontWeight: 700),
                          ),
                          Row(
                            children: [
                              Text("Price: ",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500)),
                              Text("${AppString.doller}" +
                                  widget.product.basePrice.toString())
                            ],
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (Util.imgListFav.contains(widget.product.sId)) {
                              Util.imgListFav.remove(widget.product.sId);
                              widget.onFavClick();
                            } else
                              Util.imgListFav.add(widget.product.sId!);
                          });
                        },
                        child: Icon(
                            Util.imgListFav.contains(widget.product.sId)
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
