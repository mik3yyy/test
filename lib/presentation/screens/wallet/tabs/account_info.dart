import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:math' as math;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/expandable_widget/expanded.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent-tab-view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/edit_form.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/validator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/add-fund-to-wallet/currency_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class AccounInfoTab extends HookConsumerWidget {
  const AccounInfoTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final fromCurrency = useTextEditingController();
    final toCurrency = useTextEditingController();
    final fromExchangeCurrency = useTextEditingController();
    final toExchangeCurrency = useTextEditingController();
    return Padding(
      padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 15.h),
      child: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                  height: 55.h,
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.r),
                          ),
                        ),
                        filled: true,
                        hintStyle:
                            AppText.body2(context, Colors.black26, 19.sp),
                        hintText: "Search account number",
                        suffixIcon: const Icon(Icons.search),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: -4.h, horizontal: 10.w),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: AppColors.appColor),
                          borderRadius: BorderRadius.circular(25.7),
                        ),
                        fillColor: Colors.transparent),
                  )),
              Space(10.h),
              ExpandableTheme(
                data: const ExpandableThemeData(
                  iconColor: Colors.blue,
                  useInkWell: true,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ExpandableNotifier(
                      child: ScrollOnExpand(
                        child: Column(
                          children: [
                            ExpandablePanel(
                              theme: const ExpandableThemeData(
                                headerAlignment:
                                    ExpandablePanelHeaderAlignment.center,
                                tapBodyToExpand: false,
                                tapBodyToCollapse: false,
                                hasIcon: false,
                              ),
                              header: Container(
                                padding: EdgeInsets.only(
                                    left: 19.w,
                                    top: 10.w,
                                    bottom: 10.w,
                                    right: 19.w),
                                decoration: const BoxDecoration(
                                  color: AppColors.appColor,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'View Exchange rates',
                                      style: AppText.body2Medium(
                                          context, Colors.white, 20.sp),
                                    ),
                                    const ExpandableIcon(
                                      theme: ExpandableThemeData(
                                        expandIcon: Icons.expand_more_outlined,
                                        collapseIcon:
                                            Icons.expand_less_outlined,
                                        iconColor: AppColors.whiteColor,
                                        iconSize: 28.0,
                                        iconRotationAngle: math.pi / 2,
                                        iconPadding: EdgeInsets.only(right: 5),
                                        hasIcon: false,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              collapsed: Container(),
                              expanded: Padding(
                                padding:
                                    EdgeInsets.only(left: 19.w, right: 19.w),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Space(10.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'From',
                                          style: AppText.body6(
                                            context,
                                            AppColors.textColor,
                                            16.sp,
                                          ),
                                        ),
                                        Text(
                                          'To',
                                          style: AppText.body6(
                                            context,
                                            AppColors.textColor,
                                            16.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Space(10.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            pushNewScreen(context,
                                                screen: SelectCurrencyScreen(
                                                  currencyCode: fromCurrency,
                                                  routeName: 'addFunds',
                                                ),
                                                pageTransitionAnimation:
                                                    PageTransitionAnimation
                                                        .slideRight);
                                          },
                                          child: SizedBox(
                                            width: 100.w,
                                            child: EditForm(
                                              enabled: false,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              labelText: 'USD',

                                              // textAlign: TextAlign.start,
                                              controller: fromCurrency,
                                              obscureText: false,
                                              validator: (value) =>
                                                  validateCurrency(value),
                                              suffixIcon: const Icon(
                                                CupertinoIcons.chevron_down,
                                                color: Color(0xffA8A8A8),
                                                size: 15,
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            pushNewScreen(context,
                                                screen: SelectCurrencyScreen(
                                                  currencyCode: toCurrency,
                                                  routeName: "addFunds",
                                                ),
                                                pageTransitionAnimation:
                                                    PageTransitionAnimation
                                                        .slideRight);
                                          },
                                          child: SizedBox(
                                            width: 100.w,
                                            child: EditForm(
                                              enabled: false,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              labelText: 'USD',

                                              // textAlign: TextAlign.start,
                                              controller: toCurrency,
                                              obscureText: false,
                                              validator: (value) =>
                                                  validateCurrency(value),
                                              suffixIcon: const Icon(
                                                CupertinoIcons.chevron_down,
                                                color: Color(0xffA8A8A8),
                                                size: 15,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Space(14.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 150.w,
                                          child: EditForm(
                                            enabled: true,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            labelText: 'Enter amount',

                                            // textAlign: TextAlign.start,
                                            controller: fromExchangeCurrency,
                                            obscureText: false,
                                            validator: (value) =>
                                                validateCurrency(value),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 150.w,
                                          child: EditForm(
                                            enabled: true,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            labelText: 'Enter amount',

                                            // textAlign: TextAlign.start,
                                            controller: toExchangeCurrency,
                                            obscureText: false,
                                            validator: (value) =>
                                                validateCurrency(value),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Space(18.h),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),

              //* Successful card

              Container(
                margin: EdgeInsets.only(top: 15.h, bottom: 15.h),
                height: 220.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      stops: [0.10, 0.1],
                      colors: [Colors.greenAccent, Colors.white]),
                  border: Border.all(width: 1, color: const Color(0xffDDDDDD)),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 23.w, right: 9.w),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 260.w,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Amount Transferred',
                                  style: AppText.body2(
                                      context, AppColors.appColor, 17.sp),
                                ),
                                const Spacer(),
                                Text(
                                  '\$ 20000',
                                  style: AppText.body2(
                                      context, AppColors.appColor, 17.sp),
                                )
                              ],
                            ),
                            Space(
                              20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Recipient Name',
                                  style: AppText.body2(
                                      context, AppColors.appColor, 17.sp),
                                ),
                                const Spacer(),
                                Text(
                                  'Folashade Kemi',
                                  style: AppText.body2(
                                      context, AppColors.appColor, 17.sp),
                                )
                              ],
                            ),
                            Space(
                              20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Acc.No',
                                  style: AppText.body2(
                                      context, AppColors.appColor, 17.sp),
                                ),
                                const Spacer(),
                                Text(
                                  '3422358973',
                                  style: AppText.body2(
                                      context, AppColors.appColor, 17.sp),
                                )
                              ],
                            ),
                            Space(
                              20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Date',
                                  style: AppText.body2(
                                      context, AppColors.appColor, 17.sp),
                                ),
                                const Spacer(),
                                Text(
                                  '12 April 2022',
                                  style: AppText.body2(
                                      context, AppColors.appColor, 17.sp),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      const Spacer(),
                      RotatedBox(
                        quarterTurns: -1,
                        child: Text(
                          'Successful',
                          style:
                              AppText.body2(context, AppColors.appColor, 17.sp),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              // Space(10.h),

              //* Failed card

              Container(
                margin: EdgeInsets.only(top: 15.h, bottom: 15.h),
                height: 220.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      stops: [0.10, 0.1],
                      colors: [Colors.red, Colors.white]),
                  border: Border.all(width: 1, color: const Color(0xffDDDDDD)),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 23.w, right: 9.w),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 260.w,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Amount Transferred',
                                  style: AppText.body2(
                                      context, AppColors.appColor, 17.sp),
                                ),
                                const Spacer(),
                                Text(
                                  '\$ 20000',
                                  style: AppText.body2(
                                      context, AppColors.appColor, 17.sp),
                                )
                              ],
                            ),
                            Space(
                              20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Recipient Name',
                                  style: AppText.body2(
                                      context, AppColors.appColor, 17.sp),
                                ),
                                const Spacer(),
                                Text(
                                  'Folashade Kemi',
                                  style: AppText.body2(
                                      context, AppColors.appColor, 17.sp),
                                )
                              ],
                            ),
                            Space(
                              20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Acc.No',
                                  style: AppText.body2(
                                      context, AppColors.appColor, 17.sp),
                                ),
                                const Spacer(),
                                Text(
                                  '3422358973',
                                  style: AppText.body2(
                                      context, AppColors.appColor, 17.sp),
                                )
                              ],
                            ),
                            Space(
                              20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Date',
                                  style: AppText.body2(
                                      context, AppColors.appColor, 17.sp),
                                ),
                                const Spacer(),
                                Text(
                                  '12 April 2022',
                                  style: AppText.body2(
                                      context, AppColors.appColor, 17.sp),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      const Spacer(),
                      RotatedBox(
                        quarterTurns: -1,
                        child: Text(
                          'Failed',
                          style:
                              AppText.body2(context, AppColors.appColor, 17.sp),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
