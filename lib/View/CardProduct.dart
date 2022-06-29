import 'package:flutter/material.dart';
import 'package:fvm/Util/AppString.dart';

import '../Util/AppTheme.dart';
import '../Util/Util.dart';

class CardProduct extends StatefulWidget {
  String imgList;
  final Function onCardClick;
  final Function onFavClick;

  CardProduct(this.imgList,
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
    return Container(
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
              Image.asset(
                widget.imgList,
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
                          "Coffee table",
                          style: AppTheme.getTextStyle(
                              themeData.textTheme.bodyText1,
                              color: customAppTheme.textDark,
                              fontSize: 16,
                              fontWeight: 700),
                        ),
                        Row(
                          children: [
                            Text("Highest bid: ",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500)),
                            Text("${AppString.doller}" + "500")
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (Util.imgListFav.contains(widget.imgList)) {
                            Util.imgListFav.remove(widget.imgList);
                            widget.onFavClick();
                          } else
                            Util.imgListFav.add(widget.imgList);
                        });
                      },
                      child: Icon(
                          Util.imgListFav.contains(widget.imgList)
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
    );
  }
}
