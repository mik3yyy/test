import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/route/navigator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/alert_dialog_text.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../components/app image/app_image.dart';
import '../../../components/app text theme/app_text_theme.dart';
import 'wallet list model/wallet_model.dart';
import 'wallet_appbar.dart';

class WalletSetup extends StatelessWidget {
  const WalletSetup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: CustomWalletAppBarWithChild(
        containerOneHeight: 200.h,
        containerTwoHeight: 900.h,
        containerTwoMargin: 150.h,
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
                      itemCount: walletNameList.length,
                      itemBuilder: (context, index) {
                        final item = walletNameList[index];

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
