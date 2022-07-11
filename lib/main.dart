import 'package:flutter/material.dart';
import 'package:fvm/SplashScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:fvm/Util/AppString.dart';
import 'package:fvm/View/auth/Forgot.dart';
import 'package:fvm/View/auth/Login.dart';
import 'package:fvm/View/auth/OTP.dart';
import 'package:fvm/View/auth/Register.dart';
import 'package:fvm/View/sellermode/AddProduct.dart';
import 'package:fvm/View/sellermode/YourProduct.dart';
import 'package:fvm/Widget/bottombar/fancy_bottom_navigation.dart';
import 'Util/AppTheme.dart';
import 'View/Bubbles.dart';
import 'View/buyer/FavoritePage.dart';
import 'View/buyer/HomePage.dart';
import 'View/buyer/ProfilePage.dart';
import 'View/drawer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
// https://medium.com/flutter-community/flutter-push-pop-push-1bb718b13c31
class MyApp extends StatelessWidget {
  late BuildContext _buildContext;
  late CustomAppTheme customAppTheme;
  late ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    customAppTheme = CustomAppTheme();
    _buildContext = context;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppString.AppName,
      theme: ThemeData(
        scaffoldBackgroundColor: customAppTheme.primaryBackground,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: customAppTheme.textDark),
          backgroundColor: customAppTheme.primaryBackground,
          titleTextStyle: AppTheme.getTextStyle(themeData.textTheme.titleLarge,
              color: customAppTheme.textDark,
              fontWeight: 800,
              letterSpacing: 0.20),
        ),
        primaryColor: customAppTheme.primary,
      ),
      home: Bubbles(),
      routes: <String, WidgetBuilder>{
        '/splash': (BuildContext context) => SplashScreen(),
        MyHomePage.name: (BuildContext context) => MyHomePage(),
        LoginScreen.name: (BuildContext context) => LoginScreen(),
        OTPScreen.name: (BuildContext context) => OTPScreen(),
        RegisterScreen.name: (BuildContext context) => RegisterScreen(),
        ForgotScreen.name: (BuildContext context) => ForgotScreen(),

        FavoritePage.name: (BuildContext context) => FavoritePage(),
        HomePage.name: (BuildContext context) => HomePage(),
        ProfilePage.name: (BuildContext context) => ProfilePage(),


        AddProduct.name: (BuildContext context) => AddProduct(),
        YourProduct.name: (BuildContext context) => YourProduct(),

      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  static String name = '/myhome';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late CustomAppTheme customAppTheme;
  int currentPage = 0;
  GlobalKey bottomNavigationKey = GlobalKey();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    customAppTheme = CustomAppTheme();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        shadowColor: customAppTheme.blackTrans00,
        title: Text(SplashScreen.isSeller?currentPage==0? AppString.listYourProduct: currentPage==1?AppString.yourProduct:AppString.profile:AppString.AppName),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child: _getPage(currentPage),
        ),
      ),
      bottomNavigationBar: FancyBottomNavigation(
        textColor: customAppTheme.primary,
        tabs: [
          SplashScreen.isSeller
              ? TabData(
                  iconData: Icons.line_style_rounded,
                  title: AppString.addProduct,
                  onclick: () {
                    final FancyBottomNavigationState fState =
                        bottomNavigationKey.currentState
                            as FancyBottomNavigationState;
                    fState.setPage(2);
                  })
              : TabData(
                  iconData: Icons.home_rounded,
                  title: AppString.home,
                  onclick: () {
                    final FancyBottomNavigationState fState =
                        bottomNavigationKey.currentState
                            as FancyBottomNavigationState;
                    fState.setPage(2);
                  }),
          SplashScreen.isSeller
              ? TabData(
                  iconData: Icons.view_list,
                  title: AppString.yourProduct,
                  onclick: () {
                    final FancyBottomNavigationState fState =
                        bottomNavigationKey.currentState
                            as FancyBottomNavigationState;
                    fState.setPage(2);
                  })
              : TabData(
                  iconData: Icons.star_rounded,
                  title: AppString.favorite,
                  // onclick: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => SecondPage()))
                ),
          TabData(iconData: Icons.person_rounded, title: AppString.profile)
        ],
        initialSelection: 0,
        key: bottomNavigationKey,
        onTabChangedListener: (position) {
          setState(() {
            currentPage = position;
          });
        },
      ),
      drawer: Container(
        child: CustomDrawer(
            currentPage: currentPage,
            onSelectedItem: (onSelectedItem) {
              setState(() {
                currentPage = onSelectedItem;
                scaffoldKey.currentState?.openEndDrawer();
                _getPage(onSelectedItem);
                final FancyBottomNavigationState fState = bottomNavigationKey
                    .currentState as FancyBottomNavigationState;
                fState.setPage(currentPage);
              });
            }),
      ),
    );
  }

  _getPage(int page) {
    switch (page) {
      case 0:
        return SplashScreen.isSeller?AddProduct():HomePage();
      case 1:
        return SplashScreen.isSeller?YourProduct():FavoritePage();
      default:
        return ProfilePage();
    }
  }
}
