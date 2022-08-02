import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fvm/Util/AppTheme.dart';
import 'package:fvm/Util/Util.dart';
import 'package:fvm/View/CardProduct.dart';
import '../../Util/AppImages.dart';

class FavoritePage extends StatefulWidget {
  static const name = '/favorite';

  @override
  _FavoritePage createState() => _FavoritePage();
}

class _FavoritePage extends State<FavoritePage> {
  late CustomAppTheme customAppTheme;
  late ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    customAppTheme = CustomAppTheme();
    return Scaffold(
      body: Util.imgListFav.length == 0
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  Center(
                    child: Icon(Icons.favorite,
                        color: customAppTheme.white, size: 250),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1),
                    child: Text(
                        "You don't have any favorite product, check home page for products ",
                        style: AppTheme.getTextStyle(
                            themeData.textTheme.bodyText1,
                            color: themeData.disabledColor,
                            fontWeight: 600)),
                  )
                ])
          : SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 64),
              child: Container(
                  // padding: EdgeInsets.symmetric(horizontal: 12),
                  // child: MasonryGridView.count(
                  //   shrinkWrap: true,
                  //   crossAxisCount: 2,
                  //   mainAxisSpacing: 10,
                  //   crossAxisSpacing: 12,
                  //   physics: const NeverScrollableScrollPhysics(),
                  //   itemCount: Util.imgListFav.length,
                  //   itemBuilder: (context, index) {
                  //     return CardProduct(
                  //       Util.imgListFav[index],
                  //       onCardClick: (cardIndex) {},
                  //       onFavClick: () {
                  //         setState(() {});
                  //       },
                  //     );
                  //   },
                  // )
                  ),
            ),
    );
  }
}
