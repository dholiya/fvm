import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fvm/Controller/product/buyer/AddFavoriteController.dart';
import 'package:fvm/Controller/product/buyer/AddFavoriteParent.dart';
import 'package:fvm/Controller/product/buyer/FavoriteController.dart';
import 'package:fvm/Controller/product/buyer/FavoriteParent.dart';
import 'package:fvm/Controller/product/buyer/ProductController.dart';
import 'package:fvm/Controller/product/buyer/ProductParent.dart';
import 'package:fvm/Controller/product/seller/EditProductController.dart';
import 'package:fvm/Controller/product/seller/EditProductParent.dart';
import 'package:fvm/Model/CommonModel.dart';
import 'package:fvm/Model/auth/LoginModel.dart';
import 'package:fvm/Model/product/buyer/FavoriteModel.dart';
import 'package:fvm/Model/product/buyer/ProductsModel.dart';
import 'package:fvm/Util/AppString.dart';
import 'package:fvm/Util/AppTheme.dart';
import 'package:fvm/Util/Util.dart';
import 'dart:io';
import 'package:fvm/View/buyer/CardProduct.dart';
import 'package:fvm/View/buyer/ViewProductDetails.dart';
import 'package:fvm/Widget/DesignsCom.dart';
import '../../Widget/Dialogs.dart';

class HomePage extends StatefulWidget {
  static const name = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    implements ProductController, EditProductController, AddFavoriteController {
  late CustomAppTheme customAppTheme;
  late ThemeData themeData;
  final searchController = TextEditingController();
  ProductParent? _parent;
  List<ProductsModelData> _productsModel = <ProductsModelData>[];
  List<ProductsModelData> _productsModelTemp = <ProductsModelData>[];
  int searchState=0;

  var apiState = 0;
  double maxPrice=0, minPrice=0;

  AddFavoriteParent? _favoriteParent;
  var errMsg = null;

  EditProductParent? _editProductParent;

  var sellerFVId, productFVId;
  int currentIndex=0;

  _HomePageState() {
    _favoriteParent = AddFavoriteParent(this);
    _parent = ProductParent(this);
    _parent?.loadData();
    _editProductParent = EditProductParent(this);
  }

  @override
  void initState() {
    Dialogs.selectedSortBy = 999;
    Dialogs.minPriceSortBy = 0;
    Dialogs.maxPriceSortBy = 0;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    customAppTheme = CustomAppTheme();
    return Scaffold(
      body: apiState == 0
          ? DesignsCom.ApiState0(customAppTheme)
          : apiState == 3
              ? DesignsCom.ApiState3(
                  themeData, errMsg, Icons.line_style_rounded)
              : apiState == 1
                  ? SingleChildScrollView(
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
                                    controller: searchController,
                                    autofocus: false,
                                    onSubmitted: (value) {
                                      FocusManager.instance.primaryFocus ?.unfocus();
                                    },
                                    onChanged: (name) {
                                     _filter(name);
                                    },
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
                                      Dialogs.filterBarBottom(context, themeData, customAppTheme,  minPrice, maxPrice, onSortBY:(shortBy,isApply){
                                        if(isApply)_filterShort(shortBy);
                                        else _refresh();
                                        setState(() {
                                          Dialogs.selectedSortBy = shortBy;
                                        });
                                      }, onPriceRange: (double min, double max,bool isApply) {
                                        setState(() {
                                          if(isApply)_filterPrice(min, max);
                                          else _refresh();

                                          Dialogs.minPriceSortBy = min;
                                          Dialogs.maxPriceSortBy = max;
                                        });
                                      });
                                      FocusManager.instance.primaryFocus ?.unfocus();
                                    },
                                    child: Util.ButtonDesignIcon(
                                        Icons.sort_rounded,
                                        customAppTheme,
                                        themeData),
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
                                itemCount: _productsModelTemp.length,
                                itemBuilder: (context, index) {
                                  return _productsModelTemp[index].sellerId == Util.loginData!.data!.sId
                                      ? Container()
                                      : CardProduct(
                                          _productsModelTemp[index],
                                          onCardClick: () {
                                            setState(() {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (buildContext) =>
                                                          ViewProductDetails(
                                                              _productsModelTemp
                                                                      [
                                                                  index])));
                                            });
                                          },
                                          onFavClick: () {

                                            setState(() {
                                              currentIndex = index;
                                              sellerFVId = _productsModelTemp[index].sellerId;
                                              productFVId = _productsModelTemp[index].sId
                                                  .toString();
                                            });

                                            _editProductParent?.loadData({
                                              'seller_id': sellerFVId,
                                              'favorite_by':Util.loginData?.data!.sId,
                                            }, productFVId);


                                          },
                                        );
                                },
                              )),
                        ],
                      ),
                    )
                  : DesignsCom.ApiState4(themeData),
    );
  }

  _filter(name){
    if (name.isEmpty || name.length < 2 || name.toString() == "" || name == null) {
      _refresh();
      return;
    }
    else {
      setState(() {
        _productsModelTemp = [];
      });
      _productsModel.forEach((element) {
        if(element.name!.toLowerCase().contains(name.toString().toLowerCase()))
          setState(() {
            _productsModelTemp.add(element);
          });
      });

      setState(() {
        apiState = 1;
      });
    }
  }

  _filterShort(shortBy){
    // 0 = no of bids high to low, 1 = no of bid low to high,   2 = high to low, 3 = low to high

    setState(() {
      apiState = 0;
    });
    setState(() {
      if(shortBy==0){
        _productsModelTemp.sort((a, b) => b.bids!.compareTo(a.bids!));
      }else if(shortBy==1) _productsModelTemp.sort((a, b) => a.bids!.compareTo(b.bids!));
      else if(shortBy == 2) {
        _productsModelTemp.sort((a, b) => b.basePrice!.compareTo(a.basePrice!));
      }else {
        _productsModelTemp.sort((a, b) => a.basePrice!.compareTo(b.basePrice!));
        // _productsModelTemp.reversed;
      }
    });
      setState(() {
        apiState = 1;
      });
  }

  _filterPrice(min, max){
    setState(() {
      apiState = 0;
    });
      setState(() {
        _productsModelTemp = [];
      });
      _productsModel.forEach((element) {
        if(min <= element.basePrice! && element.basePrice! <= max)
          setState(() {
            _productsModelTemp.add(element);
          });
      });
      setState(() {
        apiState = 1;
      });
  }

  _refresh(){
    setState(() {
      apiState = 0;
    });
    setState(() {
      _productsModelTemp = _productsModel;
    });
    setState(() {
      apiState = 1;
    });
  }


  @override
  void onLoadCompleted(ProductsModel items) {
    setState(() {
      items.data!.asMap().forEach((index, element) {
        if(index==0) minPrice=double.parse(element.basePrice.toString());
        if(double.parse(element.basePrice.toString())>maxPrice) maxPrice = double.parse(element.basePrice.toString());
        if(double.parse(element.basePrice.toString())<minPrice) minPrice = double.parse(element.basePrice.toString());
        if(element.sellerId != Util.loginData!.data!.sId) _productsModel.add(element);
      });
      _productsModelTemp = _productsModel;
      apiState = 1;
    });
    setState(() {
      Dialogs.minPriceSortBy = minPrice;
      Dialogs.maxPriceSortBy = maxPrice;
    });

  }

  @override
  void onLoadConnection(connection) {
    Dialogs.internetDialogRetry(themeData, context).then((value) {
      value == false
          ? SystemNavigator.pop()
          : setState(() {
              apiState = 0;
              _parent?.loadData();
            });
    });
    setState(() {
      apiState = 2;
    });
  }

  @override
  void onLoadError(CommonModel items) {
    setState(() {
      items.status == 300 ? apiState = 3 : apiState = 4;
      errMsg = items.msg;
    });
  }

  // fav
  @override
  void onLoadEditCompleted(CommonModel items) {
    setState(() {
      apiState = 0;
    });

    _productsModelTemp[currentIndex].favoriteBy!.contains(Util.loginData!.data!.sId)?
    _productsModelTemp[currentIndex].favoriteBy!.remove(Util.loginData!.data!.sId):
    _productsModelTemp[currentIndex].favoriteBy!.add(Util.loginData!.data!.sId.toString());

    _favoriteParent?.loadData({
      "user_id":  Util.loginData?.data!.sId.toString(),
      "product_id": productFVId.toString()
    });
    // Util.createSnackBar(items.msg, context, customAppTheme.colorSuccess, customAppTheme.white);
    setState(() {
      apiState = 1;
    });
  }

  @override
  void onLoadEditConnection(connection) {
    Dialogs.internetDialogRetry(themeData, context).then((value) {
      value == false
          ? SystemNavigator.pop()
          : setState(() {
              apiState = 0;
              _editProductParent?.loadData({
                'seller_id': sellerFVId,
                'favorite_by': Util.loginData?.data!.sId,
              }, productFVId);
            });
    });
    setState(() {
      apiState = 2;
    });
  }

  @override
  void onLoadEditError(CommonModel items) {
    setState(() {
      items.status == 300 ? apiState = 3 : apiState = 4;
      errMsg = items.msg;
    });
  }

  @override
  void onLoadFavCompleted(CommonModel items) {

  }

  @override
  void onLoadFavConnection(connection) {
  }

  @override
  void onLoadFavError(CommonModel items) {
    Util.createSnackBar(items.msg, context, customAppTheme.colorError, customAppTheme.white);
  }

}
