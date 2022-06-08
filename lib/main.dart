import 'package:flutter/material.dart';
import 'package:fvm/SplashScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:fvm/Util/AppString.dart';
import 'package:fvm/View/menu/HomePage.dart';
import 'package:fvm/Widget/bottombar/fancy_bottom_navigation.dart';
import 'Util/AppTheme.dart';
import 'View/drawer.dart';
import 'View/second_page.dart';

void main() => runApp(MyApp());

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
      home: MyHomePage(),
      routes: <String, WidgetBuilder>{
        '/splash': (BuildContext context) => SplashScreen(),
        // LoginController.name: (BuildContext context) => LoginController(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
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
        leading: IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(Icons.menu_rounded)),
        shadowColor: customAppTheme.blackTrans00,
        title: Text(AppString.AppName),
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
          TabData(
              iconData: Icons.home_rounded,
              title: AppString.home,
              onclick: () {
                final FancyBottomNavigationState fState = bottomNavigationKey
                    .currentState as FancyBottomNavigationState;
                fState.setPage(2);
              }),
          TabData(
              iconData: Icons.star_rounded,
              title: AppString.favorite,
              onclick: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => SecondPage()))),
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
        return HomePage();
      case 1:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("This is the search page"),
            ElevatedButton(
              child: Text(
                "Start new page",
                style: TextStyle(color: Colors.white),
              ),
              // color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SecondPage()));
              },
            )
          ],
        );
      default:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("This is the basket page"),
            ElevatedButton(
              child: Text(
                "Start new page",
                style: TextStyle(color: Colors.white),
              ),
              // color: Theme.of(context).primaryColor,
              onPressed: () {},
            )
          ],
        );
    }
  }
}
