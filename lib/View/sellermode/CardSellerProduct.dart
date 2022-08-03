import 'package:flutter/material.dart';
import 'package:fvm/Model/product/seller/SellerProductsModel.dart';
import 'package:fvm/Util/ApiList.dart';
import 'package:fvm/Util/AppString.dart';
import 'package:fvm/Util/AppTheme.dart';


class CardSellerProduct extends StatefulWidget {
  SellerProductsModelData product;
  final Function onEditClick;
  final Function onCardClick;
  final Function onDeleteClick;

  CardSellerProduct(this.product, {required this.onEditClick, required this.onCardClick, required this.onDeleteClick});

  @override
  _CardProduct createState() => _CardProduct();
}

class _CardProduct extends State<CardSellerProduct> {
  late CustomAppTheme customAppTheme;
  late ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    customAppTheme = CustomAppTheme();
    return GestureDetector(
      onTap: (){
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
                  // for (var i in widget.product.images!)
                    Stack(
                      children: [
                        Image.network(
                          Api.images+widget.product.images![0],
                          fit: BoxFit.fill,
                        ),
                        Positioned(
                          top:0.0,
                          right: 0.0,
                          child: GestureDetector(
                            onTap: (){
                              widget.onDeleteClick();
                            },
                            child: Container(
                                padding: EdgeInsets.all(10),
                                child: Icon(Icons.delete_outline_rounded, color: customAppTheme.white),
                              decoration: BoxDecoration(
                                  color:customAppTheme.blackTrans44,
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20))
                              )
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
                            widget.onEditClick();
                          });
                        },
                        child: Icon(
                            Icons.edit_rounded,
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
