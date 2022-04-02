import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/route/navigator.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isWalletEmpty = true;
    return Scaffold(
        body: isWalletEmpty == false
            ? const NoWalletSetUpWidget()
            : WalletSetup());
  }
}

class NoWalletSetUpWidget extends StatelessWidget {
  const NoWalletSetUpWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: CustomWalletAppBarWithChild(
        child1: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Wallets',
                        style: AppText.body3(
                          context,
                          Colors.white,
                        ),
                      ),
                      Space(4.h),
                      Text(
                        'Lets you view your wallets',
                        style: AppText.body3(
                          context,
                          Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Icon(
                        Icons.notifications,
                        color: Colors.white,
                        size: 18.sp,
                      ),
                    ),
                    Space(15.w),
                    const CircleAvatar(
                      radius: 18.0,
                      backgroundImage: AssetImage(
                        AppImage.image1,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
        child2: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //TODO: To change the sized of import the image from figma
            Image.asset(
              AppImage.bottomIcon2,
            ),
            Space(7.h),
            Text(
              'You have no wallet set up ',
              style: AppText.body1(
                context,
                AppColors.appColor.withOpacity(0.3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WalletSetup extends StatelessWidget {
  WalletSetup({Key? key}) : super(key: key);

  final List<WalletNamelist> _walletNameList = [
    WalletNamelist(currency: 'Dollar', amount: '\$ 200.0'),
    WalletNamelist(currency: 'Pound', amount: '\$ 300.0'),
    WalletNamelist(currency: 'Euro', amount: '\$ 0.0'),
    WalletNamelist(currency: 'Naira', amount: 'N 40,000.0'),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: CustomWalletAppBarWithChild(
        child1: Column(
          children: const [
            CircleAvatar(
              radius: 30.0,
              backgroundImage: AssetImage(
                AppImage.image1,
              ),
            ),
          ],
        ),
        child2: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 15.0, 16.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Available wallets',
                style: AppText.body3(
                  context,
                  AppColors.appColor,
                ),
              ),
              // Space(12.h),
              SizedBox(
                  height: 500.h,
                  child: ListView.builder(
                      itemCount: _walletNameList.length,
                      itemBuilder: (context, index) {
                        final item = _walletNameList[index];

                        return GestureDetector(
                          onTap: () {
                            // print('hello');
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    elevation: 50.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(13.r),
                                    ),
                                    content: Container(
                                      decoration: const BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.1),
                                              spreadRadius: 0,
                                              blurRadius: 20),
                                        ],
                                      ),
                                      height: 168.h,
                                      width: 311.w,
                                      child: Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () => context.popView(),
                                            child: Align(
                                              alignment: Alignment.topRight,
                                              child: Icon(
                                                Icons.close,
                                                size: 15.sp,
                                                color: AppColors.appColor,
                                              ),
                                            ),
                                          ),
                                          Space(17.h),
                                          AlertDailogTextDetails(
                                            text1: 'Amount received:',
                                            text2: item.amount,
                                          ),
                                          Space(12.h),
                                          const AlertDailogTextDetails(
                                            text1: 'Sender:',
                                            text2: 'Amaka J',
                                          ),
                                          Space(12.h),
                                          const AlertDailogTextDetails(
                                            text1: 'Sender Account::',
                                            text2: '2345637823',
                                          ),
                                          Space(14.h),
                                          Image.asset(
                                            AppImage.successIcon,
                                            width: 30.w,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.fromLTRB(
                                    18.0, 13.0, 18.0, 13.0),
                                height: 76.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(13.r),
                                  border: Border.all(
                                    width: 1.w,
                                    color:
                                        const Color.fromRGBO(7, 39, 119, 0.5),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${item.currency} wallet',
                                      style: AppText.body3(
                                        context,
                                        AppColors.appColor,
                                      ),
                                    ),
                                    Space(2.h),
                                    Text(
                                      item.amount,
                                      style: AppText.body3(
                                        context,
                                        AppColors.appColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Space(20.h)
                            ],
                          ),
                        );
                      })
                  // ListView.separated(
                  //     itemCount: _walletNameList.length,
                  //     separatorBuilder: (context, index) => Space(20.h),
                  //     itemBuilder: (context, index) {
                  //       final item = _walletNameList[index];
                  //       return Container(
                  //         padding:
                  //             const EdgeInsets.fromLTRB(18.0, 13.0, 18.0, 13.0),
                  //         height: 76.h,
                  //         width: double.infinity,
                  //         decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           borderRadius: BorderRadius.circular(13.r),
                  //           border: Border.all(
                  //             width: 1.w,
                  //             color: const Color.fromRGBO(7, 39, 119, 0.5),
                  //           ),
                  //         ),
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text(
                  //               '${item.currency} wallet',
                  //               style: AppText.body3(
                  //                 context,
                  //                 AppColors.appColor,
                  //               ),
                  //             ),
                  //             Space(2.h),
                  //             Text(
                  //               item.currency,
                  //               style: AppText.body3(
                  //                 context,
                  //                 AppColors.appColor,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       );
                  //     }),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

class AlertDailogTextDetails extends StatelessWidget {
  const AlertDailogTextDetails({
    Key? key,
    required this.text1,
    required this.text2,
  }) : super(key: key);

  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: AppText.body3(
            context,
            AppColors.appColor,
          ),
        ),
        Text(
          text2,
          style: AppText.body3(
            context,
            AppColors.appColor,
          ),
        ),
      ],
    );
  }
}

class WalletNamelist {
  final String currency;
  final String amount;

  WalletNamelist({
    required this.currency,
    required this.amount,
  });
}

class CustomWalletAppBarWithChild extends StatelessWidget {
  final Widget child1;
  final Widget child2;
  const CustomWalletAppBarWithChild({
    required this.child1,
    required this.child2,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      // alignment: Alignment.bottomCenter,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16.0, 40.0, 16.0, 22.0),
          height: 200.h,
          // height: 165.74.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF2E426F),
            borderRadius: BorderRadius.circular(25.r),
          ),
          child: child1,
        ),
        Container(
          margin: EdgeInsets.only(top: 150.h),
          // margin: EdgeInsets.only(top: 130.h),
          //TODO: MIght change the height depeneing on the size of the screen
          height: 900.h,
          width: double.infinity,
          decoration: BoxDecoration(
            // color: Colors.red,
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(25.r),
          ),
          child: child2,
        ),
      ],
    );
  }
}
