import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/faq/faq_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/home.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent-tab-view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/safepay/safepay_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/wallet_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/withdrawal_succesful_screen.dart';

class MainScreen extends StatefulWidget {
  final BuildContext menuScreenContext;
  const MainScreen({Key? key, required this.menuScreenContext})
      : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PersistentTabController _controller;
  late bool _hideNavBar;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _hideNavBar = false;
  }

  List<Widget> _buildScreens() {
    return [
      HomePage(
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      ),
      WalletView(
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      ),
      const Placeholder(),
      // WithdrawalSuccessfulScreen(
      //   menuScreenContext: widget.menuScreenContext,
      //   hideStatus: _hideNavBar,
      //   onScreenHideButtonPressed: () {
      //     setState(() {
      //       _hideNavBar = !_hideNavBar;
      //     });
      //   },
      // ),

      //! change to FAQ screen
      SafePayScreen(
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      )
      // MainScreen(
      //   menuScreenContext: widget.menuScreenContext,
      //   hideStatus: _hideNavBar,
      //   onScreenHideButtonPressed: () {
      //     setState(() {
      //       _hideNavBar = !_hideNavBar;
      //     });
      //   },
      // ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(AppImage.home),
        inactiveIcon: SvgPicture.asset(
          AppImage.home,
          color: Colors.grey.shade300,
        ),
        title: ("Home"),
        activeColorPrimary: AppColors.appColor,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.purple,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AppImage.wallet,
          color: AppColors.appColor,
        ),
        inactiveIcon: SvgPicture.asset(
          AppImage.wallet,
          color: Colors.grey.shade300,
        ),
        title: ("wallet"),
        activeColorPrimary: AppColors.appColor,
        inactiveColorPrimary: Colors.grey,
        // routeAndNavigatorSettings: RouteAndNavigatorSettings(
        //   initialRoute: '/',
        //   routes: {
        //     '/first': (context) => MainScreen2(),
        //     '/second': (context) => MainScreen3(),
        //   },
        // ),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AppImage.portfolio,
          color: AppColors.appColor,
        ),
        inactiveIcon: SvgPicture.asset(
          AppImage.portfolio,
          color: Colors.grey.shade300,
        ),
        title: ("portfolio"),
        activeColorPrimary: AppColors.appColor,
        inactiveColorPrimary: Colors.grey,
        // routeAndNavigatorSettings: RouteAndNavigatorSettings(
        //   initialRoute: '/',
        //   routes: {
        //     '/first': (context) => MainScreen2(),
        //     '/second': (context) => MainScreen3(),
        //   },
        // ),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AppImage.more,
          color: AppColors.appColor,
        ),
        inactiveIcon: SvgPicture.asset(
          AppImage.more,
          color: Colors.grey.shade300,
        ),
        title: ("more"),
        activeColorPrimary: AppColors.appColor,
        inactiveColorPrimary: Colors.grey,
        // routeAndNavigatorSettings: RouteAndNavigatorSettings(
        //   initialRoute: '/',
        //   routes: {
        //     '/first': (context) => MainScreen2(),
        //     '/second': (context) => MainScreen3(),
        //   },
        // ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Navigation Bar Demo')),
      // drawer: Drawer(
      //   child: Center(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: <Widget>[
      //         const Text('This is the Drawer'),
      //       ],
      //     ),
      //   ),
      // ),
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,

        stateManagement: true,
        navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
            ? 0.0
            : kBottomNavigationBarHeight,
        hideNavigationBarWhenKeyboardShows: true,
        margin: const EdgeInsets.all(0.0),
        popActionScreens: PopActionScreensType.all,
        bottomScreenMargin: 0.0,
        onWillPop: (context) async {
          await showDialog(
            context: context!,
            useSafeArea: true,
            builder: (context) => Container(
              height: 50.0,
              width: 50.0,
              color: Colors.white,
              child: ElevatedButton(
                child: Text("Close"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          );
          return false;
        },
        selectedTabScreenContext: (context) {
          // testContext = context;
        },
        hideNavigationBar: _hideNavBar,
        decoration: const NavBarDecoration(
          colorBehindNavBar: Colors.indigo,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: false,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style3, // Choose the nav bar style with this property
      ),
    );
  }
}
