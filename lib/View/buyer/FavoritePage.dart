import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fvm/Controller/product/buyer/FavoriteController.dart';
import 'package:fvm/Controller/product/buyer/FavoriteParent.dart';
import 'package:fvm/Controller/product/buyer/GetProductByIDController.dart';
import 'package:fvm/Controller/product/buyer/GetProductByIDParent.dart';
import 'package:fvm/Controller/product/buyer/RemoveFavoriteController.dart';
import 'package:fvm/Controller/product/buyer/RemoveFavoriteParent.dart';
import 'package:fvm/Controller/product/seller/EditProductController.dart';
import 'package:fvm/Controller/product/seller/EditProductParent.dart';
import 'package:fvm/Model/CommonModel.dart';
import 'package:fvm/Model/product/buyer/FavoriteModel.dart';
import 'package:fvm/Model/product/buyer/ProductsModel.dart';
import 'package:fvm/Util/AppTheme.dart';
import 'package:fvm/Util/Util.dart';
import 'package:fvm/View/buyer/CardProduct.dart';
import 'package:fvm/View/buyer/ViewProductDetails.dart';
import 'package:fvm/Widget/DesignsCom.dart';
import 'package:fvm/Widget/Dialogs.dart';


class FavoritePage extends StatefulWidget {
  static const name = '/favorite';

  @override
  _FavoritePage createState() => _FavoritePage();
}

class _FavoritePage extends State<FavoritePage>
    implements FavoriteController, GetProductByIDController ,RemoveFavoriteController, EditProductController{
  late CustomAppTheme customAppTheme;
  late ThemeData themeData;

  FavoriteParent? _parent;
  List<ProductsModelData> products = <ProductsModelData>[];

  GetProductByIDParent? _getProductByIDParent;
  var runSecond = true;
  int apiState = 0;
  RemoveFavoriteParent? _removeFavoriteParent;
 EditProductParent? _editProductParent;

  var errMsg=null;
  int currentIndex=0;

  _FavoritePage() {
    _parent = FavoriteParent(this);
    _editProductParent = EditProductParent(this);
    _parent?.loadData(Util.loginData?.data?.sId);
    _getProductByIDParent = GetProductByIDParent(this);
    _removeFavoriteParent= RemoveFavoriteParent(this);
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    customAppTheme = CustomAppTheme();
    return Scaffold(
      body:apiState == 0
          ? DesignsCom.ApiState0(customAppTheme)
          : apiState == 3
          ? DesignsCom.ApiState3(
          themeData, errMsg, Icons.line_style_rounded)
          : apiState == 1
          ?  SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 64),
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: MasonryGridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 12,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return CardProduct(
                  products[index],
                  onCardClick: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (buildContext) =>
                                  ViewProductDetails(
                                      products[index])));
                    });
                  },
                  onFavClick: () {
                    _removeFavoriteParent?.loadData(products[index].sId);

                    _editProductParent?.loadData({
                      'seller_id': products[index].sellerId,
                      'favorite_by':Util.loginData?.data!.sId,
                    }, products[index].sId);

                    setState(() {
                      currentIndex = index;
                    });
                  },

                );
              },
            )),
      ): DesignsCom.ApiState4(themeData),
    );
  }

  @override
  void onLoadFavCompleted(FavoriteModel items) {
    if(mounted)
    setState(() {
      apiState = 0;
    });
    items.data?.asMap().forEach((index, value) {
      _getProductByIDParent!.loadData(value.productId);
    });
  }

  @override
  void onLoadFavConnection(connection) {
    Dialogs.internetDialogRetry(themeData, context).then((value) {
      value == false
          ? SystemNavigator.pop()
          : setState(() {
        apiState = 0;
        _parent?.loadData(Util.loginData?.data?.sId);
      });
    });
    setState(() {
      apiState = 2;
    });
  }

  @override
  void onLoadFavError(CommonModel items) {
    setState(() {
      items.status == 300 ? apiState = 3 : apiState = 4;
      errMsg = items.msg;
    });
  }

  @override
  void onLoadGetByIDCompleted(ProductsModelData items) {
    if(mounted)
      setState(() {
        products.add(items);
        apiState = 1;
      });
  }

  @override
  void onLoadGetByIDConnection(connection) {
    Dialogs.internetDialogRetry(themeData, context).then((value) {
      value == false
          ? SystemNavigator.pop()
          : setState(() {
        apiState = 0;
        _parent?.loadData(Util.loginData?.data?.sId);
          });
    });

    setState(() {
      apiState = 2;
    });

  }

  @override
  void onLoadGetByIDError(CommonModel items) {
    if(mounted)
    setState(() {
      items.status == 300 ? apiState = 3 : apiState = 4;
      errMsg = items.msg;
    });
  }

  @override
  void onLoadRemoveFavCompleted(CommonModel items) {
    setState(() {
      apiState = 0;
      products.removeAt(currentIndex);
    });
    // Util.createSnackBar(items.msg, context, customAppTheme.colorSuccess, customAppTheme.white);
    setState(() {
      apiState = 1;
    });

    if(products.length==0){
      setState(() {
        apiState = 3;
      });
    }
  }

  @override
  void onLoadRemoveFavConnection(connection) {
    Dialogs.internetDialogRetry(themeData, context).then((value) {
      value == false
          ? SystemNavigator.pop()
          : setState(() {
        apiState = 0;
        _removeFavoriteParent?.loadData(products[currentIndex].sId);
        _editProductParent?.loadData({
          'seller_id': products[currentIndex].sellerId,
          'favorite_by':Util.loginData?.data!.sId,
        }, products[currentIndex].sId);

      });
    });
  }

  @override
  void onLoadRemoveFavError(CommonModel items) {
    Util.createSnackBar(items.msg, context, customAppTheme.colorSuccess, customAppTheme.white);
  }

  @override
  void onLoadEditCompleted(CommonModel items) {

  }

  @override
  void onLoadEditConnection(connection) {
  }

  @override
  void onLoadEditError(CommonModel items) {
  }


}
