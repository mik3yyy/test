import 'package:flutter/cupertino.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/convert_currency_res.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/expandable_widget/expanded.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent_tab_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/edit_form.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/validator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/add-fund-to-wallet/currency_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/custom_paint/custom_paint_widget.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/safepay/view_virtual_card.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/convert_currency_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_view_widget.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../components/AppSnackBar/snackbar/app_snackbar_view.dart';
import '../../../components/app image/app_image.dart';
import '../../../components/app text theme/app_text_theme.dart';

class SafePayScreen extends StatefulHookConsumerWidget {
  const SafePayScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SafePayScreenState();
}

class _SafePayScreenState extends ConsumerState<SafePayScreen> {
  final toggleNumberProvider = StateProvider<bool>((ref) => true);
  @override
  Widget build(BuildContext context) {
    final fromCurrency = useTextEditingController();
    final toCurrency = useTextEditingController();
    final fromExchangeCurrency = useTextEditingController();

    final rate = useState("0.0");
    // final toExchangeCurrency = useTextEditingController(text: rate.value);
    final from = useState("0.0");
    final convert = ref.watch(conversionProvider);

    ref.listen<RequestState>(conversionProvider, (previous, value) {
      if (value is Success<ConvertCurrencyRes>) {
        rate.value = value.value!.data.rates.rate.toString();
      }

      if (value is Error) {
        AppSnackBar.showErrorSnackBar(context, message: value.error.toString());
      }
    });
    return GenericWidget(
      appbar: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
        child: Column(
          children: [
            Space(20.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (() => Navigator.pop(context)),
                  child: const Icon(
                    Icons.arrow_back_ios_outlined,
                    color: Colors.white,
                  ),
                ),
                Space(15.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '\$ 200',
                      style: AppText.header1(context, Colors.white, 25.sp),
                    ),
                    Space(10.h),
                    Text(
                      'Default wallet balance',
                      style: AppText.body2(context, Colors.white, 20.sp),
                    ),
                  ],
                ),
                const Spacer(),
                Icon(
                  Icons.notifications,
                  color: Colors.white,
                  size: 20.sp,
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

            // const WalletOptionList()
          ],
        ),
      ),
      bgColor: AppColors.whiteColor,
      child: SizedBox(
        height: 750.h,
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Space(30.h),
              const SafePayCard(),
              Space(20.h),

              Container(
                padding: EdgeInsets.only(left: 35.w, right: 35.w),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        pushNewScreen(context,
                            screen: const ViewVirtualCard(),
                            pageTransitionAnimation:
                                PageTransitionAnimation.fade);
                      },
                      child: Text(
                        'View',
                        style:
                            AppText.body2Medium(context, Colors.black, 20.sp),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Remove ',
                      style:
                          AppText.body2Medium(context, Colors.black12, 20.sp),
                    ),
                  ],
                ),
              ),

              Space(30.h),
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
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     Text(
                                    //       'From',
                                    //       style: AppText.body6(
                                    //         context,
                                    //         AppColors.textColor,
                                    //         16.sp,
                                    //       ),
                                    //     ),
                                    //     Text(
                                    //       'To',
                                    //       style: AppText.body6(
                                    //         context,
                                    //         AppColors.textColor,
                                    //         16.sp,
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    Space(10.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                              labelText: 'From',

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
                                              labelText: 'To',

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
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Space(10),
                                            Text("Exchange Rate",
                                                style: AppText.body2(context,
                                                    Colors.black38, 15.sp)),
                                            const Space(10),
                                            Text(rate.value,
                                                style: AppText.body2(context,
                                                    Colors.black, 20.sp)),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Space(14.h),
                                    CustomButton(
                                      buttonText: convert is Loading
                                          ? loading()
                                          : buttonText(
                                              context, "Get Exchange Rate"),
                                      bgColor: AppColors.appColor,
                                      textColor: AppColors.whiteColor,
                                      borderColor:
                                          AppColors.appColor.withOpacity(0.3),
                                      buttonWidth:
                                          MediaQuery.of(context).size.width,
                                      onPressed: convert is Loading
                                          ? null
                                          : () {
                                              if (fromCurrency.text.isEmpty &&
                                                  toCurrency.text.isEmpty) {
                                                return;
                                              } else {
                                                ref
                                                    .read(conversionProvider
                                                        .notifier)
                                                    .conversion(
                                                        fromCurrency.text,
                                                        toCurrency.text);
                                              }
                                            },
                                    ),
                                    Space(14.h),
                                    InkWell(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width: 150.w,
                                            child: EditForm(
                                              enabled: true,
                                              keyboardType:
                                                  TextInputType.number,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              labelText: convert is Loading
                                                  ? "---"
                                                  : 'Enter amount',

                                              // textAlign: TextAlign.start,
                                              controller: fromExchangeCurrency,
                                              obscureText: false,
                                              validator: (value) => null,
                                              onTap: () {
                                                if (fromCurrency.text.isEmpty &&
                                                    toCurrency.text.isEmpty) {
                                                  return;
                                                } else {
                                                  ref
                                                      .read(conversionProvider
                                                          .notifier)
                                                      .conversion(
                                                          fromCurrency.text,
                                                          toCurrency.text);
                                                }
                                              },
                                              onChanged: (value) {
                                                final res =
                                                    (num.tryParse(value) ?? 0) *
                                                        (num.tryParse(
                                                                rate.value) ??
                                                            0);

                                                from.value = res.toString();
                                              },
                                            ),
                                          ),
                                          // Text(
                                          //   // salesPrice.toString(),
                                          //   ((num.tryParse(from.value) ?? 0) *
                                          //           (num.tryParse(rate.value) ??
                                          //               0))
                                          //       .toString(),
                                          //   style: TextStyle(
                                          //     color: const Color(0xFF2C2C2C),
                                          //     fontSize: 14.sp,
                                          //     fontWeight: FontWeight.w700,
                                          //   ),
                                          // ),
                                          Text(
                                            from.value,
                                            style: AppText.body2(
                                                context, Colors.black, 20.sp),
                                          ),
                                        ],
                                      ),
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

              // Container(
              //   height: 60.h,
              //   color: AppColors.appColor,
              //   padding: EdgeInsets.only(left: 20.w, right: 20.w),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(
              //         'View Exchange rates',
              //         style: AppText.body2Medium(context, Colors.white, 20.sp),
              //       ),
              //       const Icon(
              //         Icons.arrow_drop_down,
              //         color: Colors.white,
              //         size: 30,
              //       )
              //     ],
              //   ),
              // ),
              Space(30.h),
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Column(
                  children: [
                    Container(
                      height: 90.h,
                      color: AppColors.appColor.withOpacity(0.1),
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            color: AppColors.appColor.withOpacity(0.5),
                          ),
                          Space(20.w),
                          Text(
                            'Make use of your virtual cards for payment.\nClick on the card to make easy payment',
                            style: AppText.body2Medium(
                                context, Colors.black54, 17.sp),
                          ),
                        ],
                      ),
                    ),
                    Space(30.h),
                    Opacity(
                      opacity: 0.1,
                      child: SizedBox(
                        height: 90.h,
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Upgrade Free account',
                                  style: AppText.body2Bold(
                                      context, Colors.black54, 22.sp),
                                ),
                                Space(10.h),
                                Text(
                                  'Upgrade your account to add a\nnew virtual card',
                                  style: AppText.body2Medium(
                                      context, Colors.black54, 16.sp),
                                ),
                              ],
                            ),
                            const Spacer(),
                            // Space(20.w),
                            Container(
                              width: 120,
                              height: 40.h,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(30.r)),
                              child: Center(
                                child: Text(
                                  'UPGRADE',
                                  style: AppText.body2Bold(
                                      context, Colors.white, 15.sp),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //!!!!!
              //!!!!!
              //!!!!! change to successful when payment is successful

              //  const Image(
              //     image: AssetImage(
              //   AppImage.successSafepay,
              // )),
              //!!!!!
              //!!!!!
              //!!!!!
              //!!!!!
              //!!!!! change to insufficient when payment is insufficent

              //  const Image(
              //     image: AssetImage(
              //   AppImage.insufficient,
              // )),

              //!!!!!
              //!!!!!
              //!!!!! This is for scanning POS Machine
              //!!!!!
              //!!!!!
              //  Container(
              //   margin: EdgeInsets.only(left: 20.w, right: 20.w),
              //   child: Text(
              //     'Scan POS machine using NFC for quick pay',
              //     textAlign: TextAlign.center,
              //     style: AppText.header2(context, AppColors.appColor, 20.sp),
              //   ),
              // ),
              Space(55.h),
              // CustomButton(
              //     buttonText: 'Fund card',
              //     bgColor: AppColors.appColor,
              //     borderColor: AppColors.appColor,
              //     textColor: Colors.white,
              //     onPressed: () {
              //       pushNewScreen(
              //         context,
              //         screen: const FundVirtualCard(),
              //         withNavBar: true, // OPTIONAL VALUE. True by default.
              //         pageTransitionAnimation: PageTransitionAnimation.fade,
              //       );
              //       // context.navigate(AvailableBalance()

              //       // );
              //     },
              //     buttonWidth: 320),
            ],
          ),
        ),
      ),
    );
  }
}

class SafePayCard extends StatelessWidget {
  const SafePayCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30.r),
      child: Stack(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        children: [
          Container(
            height: 200,
            width: 330,
            color: Colors.indigo[50],
          ),
          Positioned(
            left: -300,
            right: 0,
            bottom: 0,
            child: SizedBox(
              height: 120,
              width: 120,
              child: CustomPaint(
                  foregroundPainter: CircleBlurPainter(
                      circleWidth: 100,
                      blurSigma: 30.0,
                      color: const Color(0xff2790C3))),
            ),
          ),
          Positioned(
            left: 0,
            right: -300,
            top: -100,
            child: SizedBox(
              height: 220,
              width: 220,
              child: CustomPaint(
                  foregroundPainter: CircleBlurPainter(
                      circleWidth: 100,
                      blurSigma: 40.0,
                      color: AppColors.appColor)),
            ),
          ),
          Positioned(
            left: 60,
            right: 0,
            top: 30,
            child: Text(
              'Virtual Card (Free Card)',
              style: AppText.body2Medium(context, Colors.white, 22.sp),
            ),
          ),
          Positioned(
            left: 15,
            right: 0,
            top: 75,
            child: Text(
              'Janeth Doe',
              style: AppText.body2Medium(context, Colors.white, 20.sp),
            ),
          ),
          Positioned(
            left: 15,
            right: 0,
            top: 100,
            child: Text(
              '2817-9403-1784-5372',
              style: AppText.body2Bold(context, Colors.white, 25.sp),
            ),
          ),
          Positioned(
            left: 15,
            right: 0,
            bottom: 10,
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Exp. Date',
                      style: AppText.body2Medium(context, Colors.white, 17.sp),
                    ),
                    Space(7.h),
                    Text(
                      '12-2022',
                      style: AppText.body2Medium(context, Colors.white, 17.sp),
                    ),
                  ],
                ),
                const Space(187),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CVV',
                      style: AppText.body2Medium(context, Colors.white, 17.sp),
                    ),
                    Space(7.h),
                    Text(
                      '***',
                      style: AppText.body2Medium(context, Colors.white, 17.sp),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
