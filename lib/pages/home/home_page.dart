import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:himalayastoreapp/pages/authenticate/sign_up_page.dart';
import 'package:himalayastoreapp/pages/cart/cart_history_page.dart';
import 'package:himalayastoreapp/pages/cart/cart_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../utils/app_colors.dart';
import 'main_products_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;

  late PersistentTabController _controller;

  List<Widget> _pages=[
    MainProductsScreen(),
    CartHistoryScreen(),
    CartScreen(),
    SignUpScreen()
  ];

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: AppColors.himalayaBlue,
        inactiveColorPrimary: AppColors.himalayaGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.archivebox),
        title: ("History"),
        activeColorPrimary: AppColors.himalayaBlue,
        inactiveColorPrimary: AppColors.himalayaGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.shopping_cart),
        title: ("Cart"),
        activeColorPrimary: AppColors.himalayaBlue,
        inactiveColorPrimary: AppColors.himalayaGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.person),
        title: ("Me"),
        activeColorPrimary: AppColors.himalayaBlue,
        inactiveColorPrimary: AppColors.himalayaGrey,
      ),
    ];
  }

  void onTabNav(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = PersistentTabController(initialIndex: 0);

  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _pages,
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }
}
