import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/user_account_details_res.dart';
import 'package:kayndrexsphere_mobile/presentation/components/AppSnackBar/snackbar/app_snackbar_view.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/get_account_details_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/set_wallet_as_default_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_view_widget.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../components/app image/app_image.dart';
import '../../../components/app text theme/app_text_theme.dart';

class AvailableWallet extends StatefulWidget {
  final List<Wallet> wallet;
  const AvailableWallet({
    required this.wallet,
    Key? key,
  }) : super(key: key);

  @override
  State<AvailableWallet> createState() => _AvailableWalletState();
}

class _AvailableWalletState extends State<AvailableWallet> {
  @override
  Widget build(BuildContext context) {
    final isDefault =
        widget.wallet.where((element) => element.isDefault == 1).toList();
    return GenericWidget(
      appbar: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Space(20.h),
            InkWell(
              onTap: (() => Navigator.pop(context)),
              child: const Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.white,
              ),
            ),
            Space(20.h),
            const Center(
              child: CircleAvatar(
                radius: 30.0,
                backgroundImage: AssetImage(
                  AppImage.image1,
                ),
              ),
            )
          ],
        ),
      ),
      bgColor: AppColors.whiteColor,
      child: SizedBox(
        height: 700.h,
        child: Padding(
          padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 45.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isDefault.isEmpty
                  ? const SizedBox(
                      height: 0.0,
                    )
                  : Column(
                      children: [
                        Text(
                          'Default wallets',
                          style: AppText.header2(
                              context, AppColors.appColor, 20.sp),
                        ),
                        Space(5.h),
                        //TODO: Getting overflow when display default wallet, but would fix it later
                        // Expanded(
                        //   child: ListView.separated(
                        //       shrinkWrap: true,
                        //       itemCount: isDefault.length,
                        //       separatorBuilder: (context, index) {
                        //         return SizedBox(
                        //           height: 33.h,
                        //         );
                        //       },
                        //       itemBuilder: (context, index) {
                        //         final item = isDefault[index];
                        //         return Container(
                        //           height: 100.h,
                        //           width: MediaQuery.of(context).size.width,
                        //           padding:
                        //               EdgeInsets.only(left: 20.w, right: 20.w),
                        //           decoration: BoxDecoration(
                        //               borderRadius: BorderRadius.circular(15.r),
                        //               border: Border.all(
                        //                   width: 1, color: AppColors.appColor)),
                        //           child: Row(
                        //             children: [
                        //               Column(
                        //                 crossAxisAlignment:
                        //                     CrossAxisAlignment.start,
                        //                 mainAxisAlignment:
                        //                     MainAxisAlignment.center,
                        //                 children: [
                        //                   Text(
                        //                     //TODO: To convert the symbol to name E.G NGN = Naira
                        //                     '${item.currency!.code!} wallet',
                        //                     style: AppText.header2(context,
                        //                         AppColors.appColor, 20.sp),
                        //                   ),
                        //                   Space(10.h),
                        //                   //TODO: Naira symbol not working with the font, to look for another solution
                        //                   Text(
                        //                     '${item.currency!.symbol!} ${item.balance.toString()}',
                        //                     style: AppText.header2(context,
                        //                         AppColors.appColor, 20.sp),
                        //                   ),
                        //                 ],
                        //               ),
                        //               const Spacer(),
                        //               GestureDetector(
                        //                 onTap: () {
                        //                   showCupertinoModalPopup(
                        //                       context: context,
                        //                       builder: (context) {
                        //                         return Padding(
                        //                           padding: EdgeInsets.only(
                        //                               left: 25.w, right: 25.w),
                        //                           child: CupertinoActionSheet(
                        //                             actions: [
                        //                               //WalletName
                        //                               Container(
                        //                                 color: Colors.white,
                        //                                 child:
                        //                                     CupertinoActionSheetAction(
                        //                                   child: Padding(
                        //                                     padding:
                        //                                         EdgeInsets.only(
                        //                                             left: 30.w,
                        //                                             right:
                        //                                                 30.w),
                        //                                     child: Text(
                        //                                       //TODO: To convert the symbol to name E.G NGN = Naira
                        //                                       '${item.currency!.code!} wallet',
                        //                                       style:
                        //                                           AppText.body5(
                        //                                         context,
                        //                                         AppColors
                        //                                             .textColor
                        //                                             .withOpacity(
                        //                                                 0.67),
                        //                                         16.sp,
                        //                                       ),
                        //                                     ),
                        //                                   ),
                        //                                   isDefaultAction: true,
                        //                                   onPressed: () {
                        //                                     // currencyController.text = dollar;
                        //                                     // Navigator.pop(context);
                        //                                   },
                        //                                 ),
                        //                               ),
                        //                               //View Wallet
                        //                               Container(
                        //                                 color: Colors.white,
                        //                                 child:
                        //                                     CupertinoActionSheetAction(
                        //                                   child: Padding(
                        //                                     padding:
                        //                                         EdgeInsets.only(
                        //                                             left: 30.w,
                        //                                             right:
                        //                                                 30.w),
                        //                                     child: Text(
                        //                                       //TODO: To change the font when add_fund_ui is merged
                        //                                       'view wallet',
                        //                                       style:
                        //                                           AppText.body5(
                        //                                         context,
                        //                                         AppColors
                        //                                             .textColor,
                        //                                         16.sp,
                        //                                       ),
                        //                                     ),
                        //                                   ),
                        //                                   isDefaultAction: true,
                        //                                   onPressed: () {
                        //                                     // currencyController.text = dollar;
                        //                                     // Navigator.pop(context);
                        //                                   },
                        //                                 ),
                        //                               ),
                        //                               //Transfer to another wallet
                        //                               Container(
                        //                                 color: Colors.white,
                        //                                 child:
                        //                                     CupertinoActionSheetAction(
                        //                                   child: Padding(
                        //                                     padding:
                        //                                         EdgeInsets.only(
                        //                                             left: 30.w,
                        //                                             right:
                        //                                                 30.w),
                        //                                     child: Text(
                        //                                       'Transfer to another wallet',
                        //                                       style:
                        //                                           AppText.body5(
                        //                                         context,
                        //                                         AppColors
                        //                                             .textColor,
                        //                                         16.sp,
                        //                                       ),
                        //                                     ),
                        //                                   ),
                        //                                   isDefaultAction: true,
                        //                                   onPressed: () {
                        //                                     // currencyController.text = dollar;
                        //                                     // Navigator.pop(context);
                        //                                   },
                        //                                 ),
                        //                               ),
                        //                               //Make wallet default
                        //                               Container(
                        //                                 color: Colors.white,
                        //                                 child:
                        //                                     CupertinoActionSheetAction(
                        //                                   child: Padding(
                        //                                     padding:
                        //                                         EdgeInsets.only(
                        //                                             left: 30.w,
                        //                                             right:
                        //                                                 30.w),
                        //                                     child: Text(
                        //                                       'Make Default',
                        //                                       style:
                        //                                           AppText.body5(
                        //                                         context,
                        //                                         AppColors
                        //                                             .textColor,
                        //                                         16.sp,
                        //                                       ),
                        //                                     ),
                        //                                   ),
                        //                                   isDefaultAction: true,
                        //                                   onPressed: () {
                        //                                     // currencyController.text = dollar;
                        //                                     // Navigator.pop(context);
                        //                                   },
                        //                                 ),
                        //                               ),
                        //                               //Remove wallet
                        //                               Container(
                        //                                 color: Colors.white,
                        //                                 child:
                        //                                     CupertinoActionSheetAction(
                        //                                   child: Padding(
                        //                                     padding:
                        //                                         EdgeInsets.only(
                        //                                             left: 30.w,
                        //                                             right:
                        //                                                 30.w),
                        //                                     child: Text(
                        //                                       //TODO: NO api to remove wallet
                        //                                       'Remove Wallet',
                        //                                       style:
                        //                                           AppText.body5(
                        //                                         context,
                        //                                         AppColors
                        //                                             .textColor,
                        //                                         16.sp,
                        //                                       ),
                        //                                     ),
                        //                                   ),
                        //                                   isDefaultAction: true,
                        //                                   onPressed: () {
                        //                                     // currencyController.text = dollar;
                        //                                     // Navigator.pop(context);
                        //                                   },
                        //                                 ),
                        //                               ),
                        //                             ],
                        //                             cancelButton:
                        //                                 CupertinoActionSheetAction(
                        //                               child: Text(
                        //                                 "Close",
                        //                                 style: AppText.body5(
                        //                                   context,
                        //                                   AppColors.textColor,
                        //                                   16.sp,
                        //                                 ),
                        //                               ),
                        //                               onPressed: () {
                        //                                 Navigator.pop(context);
                        //                               },
                        //                             ),
                        //                           ),
                        //                         );
                        //                       });
                        //                 },
                        //                 child: Row(
                        //                   children: const [
                        //                     Icon(
                        //                       Icons.circle_outlined,
                        //                       color: Colors.black,
                        //                       size: 6,
                        //                     ),
                        //                     Space(3),
                        //                     Icon(
                        //                       Icons.circle_outlined,
                        //                       color: Colors.black,
                        //                       size: 6,
                        //                     ),
                        //                     Space(3),
                        //                     Icon(
                        //                       Icons.circle_outlined,
                        //                       color: Colors.black,
                        //                       size: 6,
                        //                     ),
                        //                   ],
                        //                 ),
                        //               )
                        //             ],
                        //           ),
                        //         );
                        //       }),
                        // ),
                      ],
                    ),

              // isDefault.isEmpty
              //     ? const SizedBox(height: 0.0)
              //     : Column(
              //         children: [
              //           Text(
              //             'Default wallet',
              //             style: AppText.header2(
              //                 context, AppColors.appColor, 20.sp),
              //           ),
              //           SizedBox(
              //             height: 33.h,
              //           ),
              //         ],
              //       ),
              Text(
                'Available wallets',
                style: AppText.header2(context, AppColors.appColor, 20.sp),
              ),
              Space(20.h),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: widget.wallet.length,
                  itemBuilder: (context, index) {
                    final item = widget.wallet[index];
                    return Container(
                      height: 100.h,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(left: 20.w, right: 20.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          border:
                              Border.all(width: 1, color: AppColors.appColor)),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                //TODO: To convert the symbol to name E.G NGN = Naira
                                '${item.currency!.code!} wallet',
                                style: AppText.header2(
                                    context, AppColors.appColor, 20.sp),
                              ),
                              Space(10.h),
                              //TODO: Naira symbol not working with the font, to look for another solution
                              Text(
                                '${item.currency!.symbol!} ${item.balance.toString()}',
                                style: AppText.header2(
                                    context, AppColors.appColor, 20.sp),
                              ),
                            ],
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.w, right: 25.w),
                                      child: CupertinoActionSheet(
                                        actions: [
                                          //WalletName
                                          Container(
                                            color: Colors.white,
                                            child: CupertinoActionSheetAction(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 30.w, right: 30.w),
                                                child: Text(
                                                  //TODO: To convert the symbol to name E.G NGN = Naira
                                                  '${item.currency!.code!} wallet',
                                                  style: AppText.body5(
                                                    context,
                                                    AppColors.textColor
                                                        .withOpacity(0.67),
                                                    16.sp,
                                                  ),
                                                ),
                                              ),
                                              isDefaultAction: true,
                                              onPressed: () {
                                                // currencyController.text = dollar;
                                                // Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                          //View Wallet
                                          Container(
                                            color: Colors.white,
                                            child: CupertinoActionSheetAction(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 30.w, right: 30.w),
                                                child: Text(
                                                  //TODO: Need explanation on how wallet can be viewed and which api ti be used
                                                  'view wallet',
                                                  //TODO: To change the font when add_fund_ui is merged
                                                  style: AppText.body5(
                                                    context,
                                                    AppColors.textColor,
                                                    16.sp,
                                                  ),
                                                ),
                                              ),
                                              isDefaultAction: true,
                                              onPressed: () {
                                                // currencyController.text = dollar;
                                                // Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                          //Transfer to another wallet
                                          Container(
                                            color: Colors.white,
                                            child: CupertinoActionSheetAction(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 30.w, right: 30.w),
                                                child: Text(
                                                  'Transfer to another wallet',
                                                  style: AppText.body5(
                                                    context,
                                                    AppColors.textColor,
                                                    16.sp,
                                                  ),
                                                ),
                                              ),
                                              isDefaultAction: true,
                                              onPressed: () {
                                                //TODO: To transafer from current wallet to another wallet
                                              },
                                            ),
                                          ),

                                          //Make wallet default
                                          Consumer(
                                              builder: (context, ref, child) {
                                            final vm = ref.watch(
                                                setWalletAsDefaultProvider);
                                            ref.listen<RequestState>(
                                                setWalletAsDefaultProvider,
                                                (T, value) {
                                              if (value is Success) {
                                                Navigator.pop(context);
                                                //refreshing account detail to fetch the new default
                                                ref.refresh(
                                                    getAccountDetailsProvider);
                                                return AppSnackBar
                                                    .showSuccessSnackBar(
                                                        context,
                                                        message:
                                                            'Wallet set as default successfully');
                                              }

                                              if (value is Error) {
                                                //TODO: The KDRX can not be set as defualt
                                                return AppSnackBar
                                                    .showErrorSnackBar(context,
                                                        message: value.error
                                                            .toString());
                                              }
                                            });
                                            return Container(
                                              color: Colors.white,
                                              child: CupertinoActionSheetAction(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 30.w, right: 30.w),
                                                  child: Text(
                                                    'Make Default',
                                                    style: AppText.body5(
                                                      context,
                                                      AppColors.textColor,
                                                      16.sp,
                                                    ),
                                                  ),
                                                ),
                                                isDefaultAction: true,
                                                onPressed: () {
                                                  ref
                                                      .read(
                                                          setWalletAsDefaultProvider
                                                              .notifier)
                                                      .setWalletAsDefault(
                                                          item.currency!.code!);
                                                  // Navigator.pop(context);
                                                },
                                                // onPressed: vm is Loading
                                                //     ? null
                                                //     : () {
                                                //         ref.read(setWalletAsDefaultProvider.notifier).setWalletAsDefault('');

                                                //         Navigator.pop(context);
                                                //       },
                                              ),
                                            );
                                          }),
                                          //Remove wallet
                                          Container(
                                            color: Colors.white,
                                            child: CupertinoActionSheetAction(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 30.w, right: 30.w),
                                                child: Text(
                                                  //TODO: NO api to remove wallet
                                                  'Remove Wallet',
                                                  style: AppText.body5(
                                                    context,
                                                    AppColors.textColor,
                                                    16.sp,
                                                  ),
                                                ),
                                              ),
                                              isDefaultAction: true,
                                              onPressed: () {
                                                // currencyController.text = dollar;
                                                // Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                        ],
                                        cancelButton:
                                            CupertinoActionSheetAction(
                                          child: Text(
                                            "Close",
                                            style: AppText.body5(
                                              context,
                                              AppColors.textColor,
                                              16.sp,
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.circle_outlined,
                                  color: Colors.black,
                                  size: 6,
                                ),
                                Space(3),
                                Icon(
                                  Icons.circle_outlined,
                                  color: Colors.black,
                                  size: 6,
                                ),
                                Space(3),
                                Icon(
                                  Icons.circle_outlined,
                                  color: Colors.black,
                                  size: 6,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 20.h,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
