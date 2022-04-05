import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/faq/faq_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/home.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/wallet_view.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int pageIndex = 0;
  List<Widget> pageList = <Widget>[
    const HomePage(),
    const WalletView(),
    Container(),
    Container(),
    // const FaqScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[pageIndex],
      bottomNavigationBar: Container(
        height: 100.h,
        decoration: BoxDecoration(
          color: Colors.red,
          // color: const Color(0xFFF8F9FB),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40..r),
            topLeft: Radius.circular(40.r),
          ),
        ),
        // height: 72.h,
        child: BottomNavigationBar(
          backgroundColor: const Color(0xFFF8F9FB),
          currentIndex: pageIndex,
          onTap: (value) {
            setState(() {
              pageIndex = value;
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.appColor,
          selectedIconTheme: const IconThemeData(
            color: AppColors.appColor,
          ),
          selectedLabelStyle:
              AppText.bottomBarText(context, AppColors.appColor),
          unselectedLabelStyle:
              AppText.bottomBarText(context, const Color(0XffC4C4C4)),
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Image.asset(AppImage.bottomIcon1),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Image.asset(
                  AppImage.bottomIcon1,
                  color: AppColors.appColor,
                ),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Image.asset(
                  AppImage.bottomIcon2,
                ),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Image.asset(
                  AppImage.bottomIcon2,
                  color: AppColors.appColor,
                ),
              ),
              label: 'Wallets',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Image.asset(AppImage.bottomIcon3),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Image.asset(
                  AppImage.bottomIcon3,
                  color: AppColors.appColor,
                ),
              ),
              label: 'Portfolio',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Image.asset(
                  AppImage.bottomIcon4,
                  color: Colors.grey,
                ),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Image.asset(
                  AppImage.bottomIcon4,
                  color: AppColors.appColor,
                ),
              ),
              label: 'More',
            ),
          ],
        ),
      ),
    );
  }
}
