import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:himalayastoreapp/controllers/products_pager_view_controller.dart';
import 'package:himalayastoreapp/pages/authenticate/sign_up_page.dart';
import 'package:himalayastoreapp/pages/cart/cart_history_page.dart';
import 'package:himalayastoreapp/pages/cart/cart_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../controllers/authentication_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/main_page_controller.dart';
import '../../controllers/products_page_controller.dart';
import '../../push_notifications/push_notification_system.dart';
import '../../utils/app_colors.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/small_text.dart';
import '../authenticate/account_page.dart';
import '../deliveries/pending_deliveries.dart';
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
    CartScreen(page: "",),
    AccountScreen()
  ];

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Semantics(label: "Botón Home de Menú",child: Icon(CupertinoIcons.home)),
        title: ("Home"),
        activeColorPrimary: AppColors.himalayaBlue,
        inactiveColorPrimary: AppColors.himalayaGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Semantics(label: "Botón Historial de Compras de Menú",child: Icon(CupertinoIcons.archivebox)),
        title: ("History"),
        activeColorPrimary: AppColors.himalayaBlue,
        inactiveColorPrimary: AppColors.himalayaGrey,
      ),
      PersistentBottomNavBarItem(
        icon: GetBuilder<CartController>(builder: (controller){
          return controller.items.length>0 ? Stack(
            children: [
              Semantics(label: "Botón Carrito de compras con ${controller.totalItems} items de Menú",child: Icon(CupertinoIcons.shopping_cart)),
              controller.totalItems>=1 ?
              Positioned(
                  right: 0,
                  top: 0,
                  child: ApplIcon(
                    icon: Icons.circle,
                    size: 15,
                    iconColor: Colors.transparent,
                    backgroundColor: Colors.redAccent,
                  )
              ) :
              Container(),
              controller.totalItems>=1 ?
              Positioned(
                right: 2,
                top: 1,
                child: SmallText(
                  text: controller.totalItems.toString(),
                  color: Colors.white,
                  size: 10,
                ),
              ) :
              Container()
            ],
          ) :
          Icon(CupertinoIcons.shopping_cart);
        }),
        title: ("Cart"),
        activeColorPrimary: AppColors.himalayaBlue,
        inactiveColorPrimary: AppColors.himalayaGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Semantics(label: "Botón Perfil de Usuario de Menú",child: Icon(CupertinoIcons.person)),
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

    _loadResources();
    initNotificationService();

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

  void initNotificationService() async{

    PushNotificationSystem pushNotificationSystem = PushNotificationSystem(context: context);
    pushNotificationSystem.initializeCloudMessaging();
    pushNotificationSystem.generateMessagingToken();

  }

  Future<void> _loadResources() async{

  }

}
