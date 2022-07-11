import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fvm/Util/AppTheme.dart';
import 'package:fvm/Util/Util.dart';
import 'package:fvm/View/CardProduct.dart';
import '../../Util/AppImages.dart';
import '../../Widget/Dialogs.dart';

class HomePage extends StatefulWidget {
  static const name = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _imgList = <String>[
    AppImages.coffeTable,
    AppImages.smallFan,
    AppImages.ryobi40vTrimmer,
    AppImages.iphone13128GB,
    AppImages.coffeTable,
    AppImages.smallFan,
    AppImages.ryobi40vTrimmer
  ];
  late CustomAppTheme customAppTheme;
  late ThemeData themeData;
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    customAppTheme = CustomAppTheme();
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 64),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    flex: 85,
                    child: TextField(
                      autofocus: false,
                      decoration: InputDecoration(
                        filled: true,
                        suffixIcon: GestureDetector(
                            onTap: () {
                              Util.createSnackBar(
                                  "sad",
                                  context,
                                  customAppTheme.btnDisable,
                                  customAppTheme.primary);
                            },
                            child: Icon(
                              Icons.search_rounded,
                              color: customAppTheme.primarylite,
                            )),
                        fillColor: Colors.white,
                        hintText: 'Search...',
                        contentPadding: EdgeInsets.all(14),
                        focusedBorder: Util.noBorder8(),
                        enabledBorder: Util.noBorder8(),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 10,
                    child: GestureDetector(
                      onTap: () {
                        Dialogs.filterBarBottom(
                            context, themeData, customAppTheme);
                      },
                      child: Util.ButtonDesignIcon(
                          Icons.sort_rounded, customAppTheme, themeData),
                    ),
                  )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: MasonryGridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 12,
                  itemCount: _imgList.length,
                  itemBuilder: (context, index) {
                    return CardProduct(
                      _imgList[index],
                      onCardClick: (cardIndex) {},
                      onFavClick: () {},
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}
