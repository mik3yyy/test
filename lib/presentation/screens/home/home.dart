import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_view_widget.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/withdraw.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/withdrawal_method.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../components/app image/app_image.dart';
import '../../components/app text theme/app_text_theme.dart';
import '../wallet/transfer/transfer.dart';
import 'widgets/bottomNav/persistent-tab-view.dart';

class HomePage extends StatefulHookConsumerWidget {
  final BuildContext menuScreenContext;
  final Function onScreenHideButtonPressed;
  final bool hideStatus;
  const HomePage(
      {Key? key,
      required this.menuScreenContext,
      required this.onScreenHideButtonPressed,
      required this.hideStatus})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final toggleAmountProvider = StateProvider<bool>((ref) => true);
  final currency = [
    "Dollar",
    "Pounds",
    "Euro",
    "Naira",
  ];

  String setValue = 'Dollar';

  @override
  Widget build(BuildContext context) {
    final toggleAmount = ref.watch(toggleAmountProvider.state);
    return GenericWidget(
      appbar: Padding(
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
        ),
        child: Column(
          children: [
            Space(20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Hi Dave',
                      style: AppText.header1(context, Colors.white, 25.sp),
                    ),
                    Space(10.h),
                    Text(
                      'Thanks for signing up with us',
                      style: AppText.body2(context, Colors.white, 18.sp),
                    ),
                  ],
                ),
                const Spacer(),
                Icon(
                  Icons.notifications,
                  color: Colors.white,
                  size: 30.sp,
                ),
                Space(10.w),
                const CircleAvatar(
                  radius: 18.0,
                  backgroundImage: AssetImage(
                    AppImage.image1,
                  ),
                )
              ],
            ),
            Space(30.h),
            Container(
              height: 150.h,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: AppColors.bottomSheet,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 120.w,
                        child: DropdownButton<String>(
                            underline: const SizedBox.shrink(),
                            value: setValue,
                            isExpanded: true,
                            dropdownColor: Colors.white,
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.appColor,
                            ),
                            items: currency.map(buildItem).toList(),
                            onChanged: (value) {
                              setState(() {
                                setValue = value!;
                              });
                            }),
                      ),
                      Space(85.w),
                      InkWell(
                        onTap: () {
                          toggleAmount.state = !toggleAmount.state;
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Icon(
                            toggleAmount.state
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: toggleAmount.state
                                ? AppColors.appColor
                                : Colors.grey.shade400,
                            size: 20,
                          ),
                        ),
                      ),
                      Space(20.w)
                    ],
                  ),
                  toggleAmount.state
                      ? Text(
                          '****',
                          style: AppText.header1(
                              context, AppColors.appColor, 40.sp),
                        )
                      : Text(
                          '\$ 200.00',
                          style: AppText.header1(
                              context, AppColors.appColor, 40.sp),
                        ),
                  Space(10.h),
                  Text(
                    'Acc No: 23456789',
                    style: AppText.body2(context, AppColors.appColor, 20.sp),
                  ),
                ],
              ),
            )
            // Space(30.h),
            // const WalletOptionList()
          ],
        ),
      ),
      bgColor: const Color(
        0xfff9f9f9,
      ),
      child: SizedBox(
        height: 500,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 0.w, right: 0.w, top: 0.h),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 10, top: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(45.r)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset:
                            const Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MenuCards(
                            title: 'Transfer',
                            image: AppImage.transfer,
                            firstColor: AppColors.appColor.withOpacity(0.65),
                            secondColor: AppColors.appColor,
                            onPressed: () {
                              pushNewScreen(
                                context, screen: const Transfer(),
                                withNavBar:
                                    true, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation:
                                    PageTransitionAnimation.fade,
                              );
                            },
                          ),
                          MenuCards(
                            title: 'Add funds',
                            image: AppImage.addFunds,
                            firstColor:
                                const Color(0xff00848C).withOpacity(0.6),
                            secondColor: const Color(0xff00404E),
                            onPressed: () {},
                          ),
                          MenuCards(
                            title: 'Withdraw',
                            image: AppImage.withdraw,
                            firstColor:
                                const Color(0xff1E6342).withOpacity(0.6),
                            secondColor: const Color(0xff00351C),
                            onPressed: () {
                              pushNewScreen(
                                context, screen: const WithdrawalMethodScreen(),
                                withNavBar:
                                    true, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation:
                                    PageTransitionAnimation.fade,
                              );
                            },
                          ),
                        ],
                      ),
                      Space(30.w),
                      SizedBox(
                        width: 370.w,
                        child: Row(
                          children: [
                            Text(
                              'Transactions',
                              style: AppText.body2Bold(
                                  context, Colors.black26, 21.sp),
                            ),
                            const Spacer(),
                            Text(
                              'View all',
                              style: AppText.body2Bold(
                                  context, Colors.black54, 21.sp),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Space(30.h),
                SizedBox(
                  height: 300.h,
                  child: ListView.separated(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return const TransactionBuild();
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 20.h);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildItem(String currencyValue) {
    return DropdownMenuItem(
        value: currencyValue,
        child: Text(
          currencyValue,
          style: AppText.body2Bold(context, AppColors.appColor, 19.sp),
        ));
  }
}

class MenuCards extends StatelessWidget {
  final String title;
  final String image;
  final Color firstColor;
  final Color secondColor;

  final void Function()? onPressed;
  const MenuCards(
      {Key? key,
      required this.title,
      required this.image,
      required this.firstColor,
      required this.secondColor,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 120.h,
        width: 110.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          // color: AppColors.appColor,
          gradient: RadialGradient(
            colors: [firstColor, secondColor],
            radius: 0.75,
            focal: Alignment.topLeft,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Space(5.h),
            SvgPicture.asset(
              image,
              color: Colors.white,
              height: 30.h,
              width: 30.w,
            ),
            Space(25.h),
            Text(
              title,
              style: AppText.header2(context, Colors.white, 15.sp),
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionBuild extends StatelessWidget {
  const TransactionBuild({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 60.h,
            width: 60.w,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.orange),
          ),
          Space(10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Transfer',
                      style: AppText.body2(context, Colors.black, 18.sp),
                    ),
                    const Spacer(),
                    Text(
                      '\$ 240',
                      style: AppText.body2(context, Colors.black, 18.sp),
                    ),
                  ],
                ),
                Space(10.h),
                Row(
                  children: [
                    Text(
                      'Transfer to Jane Doe',
                      style: AppText.body2(context, Colors.black, 18.sp),
                    ),
                    const Spacer(),
                    Text(
                      '03/05/2022',
                      style: AppText.body2(context, Colors.black, 18.sp),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
