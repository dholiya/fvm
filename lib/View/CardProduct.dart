import 'package:flutter/material.dart';
import 'package:fvm/Util/AppString.dart';

import '../Util/AppTheme.dart';
import '../Util/Util.dart';

class CardProduct extends StatefulWidget {
  String imgList;

  CardProduct(this.imgList);

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Coffee table",style: AppTheme.getTextStyle(themeData.textTheme.bodyText1,
                        color: customAppTheme.textDark, fontSize: 16, fontWeight: 700),),
                    Row(
                      children: [
                        Text("Highest bid: ",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500)),
                        Text("${AppString.doller}" + "500")
                      ],
                    ),
                    // Container(
                    //   padding: EdgeInsets.only(top: 5),
                    //   child: _BidNow(),
                    // ),
                    // Image.asset(
                    //   widget.imgList,
                    //   fit: BoxFit.fill,
                    // )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _BidNow() {
    return GestureDetector(
      onTap: () {
        // Util.checkInternet().then((value) {
        //   if (!value) {
        //     Dialogs.internetDialogRetry(themeData, context).then((value) {
        //       internetChecker();
        //     });
        //   } else {
        //     _verify();
        //   }
        // });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: customAppTheme.primary,
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
            child: Text(
              AppString.bidNow,
              textAlign: TextAlign.center,
              style: AppTheme.getTextStyle(themeData.textTheme.bodyText1,
                  color: customAppTheme.cardBottomBar, fontWeight: 500),
            ),
          ),
        ],
      ),
    );
  }
}
