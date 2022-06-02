import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/expandable_widget/expanded.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/edit_form.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/validator.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import 'widget/add_fund_heading_container.dart';

class DebitCreditCardScreen extends StatelessWidget {
  const DebitCreditCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currency = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Credit/Debit Card',
          style: AppText.body6(
            context,
            AppColors.textColor,
            16.sp,
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: (() => Navigator.pop(context)),
          child: Icon(
            Icons.chevron_left,
            color: AppColors.textColor,
            size: 60.sp,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AddFundHeadingContainer(
                text: 'Enter an amount you want to fund',
                textAlign: TextAlign.left,
                paddingLeft: 25.sp,
              ),
              Space(27.h),
              Padding(
                padding: EdgeInsets.only(left: 22.w, right: 22.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 100.w,
                          child: Stack(
                            children: [
                              EditForm(
                                enabled: false,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                labelText: 'USD',

                                // textAlign: TextAlign.start,
                                controller: currency,
                                obscureText: false,
                                validator: (value) => validateCurrency(value),
                                //TODO: To see how to add flag later as prefixIcon
                                // prefixIcon: const Icon(
                                //   CupertinoIcons.chevron_down,
                                //   color: Color(0xffA8A8A8),
                                //   size: 15,
                                // ),
                                suffixIcon: const Icon(
                                  CupertinoIcons.chevron_down,
                                  color: Color(0xffA8A8A8),
                                  size: 15,
                                ),
                              ),
                              // Positioned(
                              //   left: 375.w,
                              //   right: 0,
                              //   bottom: 17.h,
                              //   child: const Icon(
                              //     CupertinoIcons.chevron_down,
                              //     color: Color(0xffA8A8A8),
                              //     size: 15,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        Space(5.w),
                        SizedBox(
                          // width: MediaQuery.of(context).size.width - 150.w,
                          width: 250.w,
                          child: EditForm(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            labelText: 'Enter amount',
                            keyboardType: TextInputType.number,
                            // textAlign: TextAlign.start,
                            controller: currency,
                            obscureText: false,
                            validator: (value) => validateCurrency(value),
                          ),
                        ),
                      ],
                    ),
                    Space(16.h),
                    InkWell(
                      onTap: () {
                        // debugPrint('Hi, we are here');
                        //TODO: If card list is not empty from api, to implement the UI of select out of the list of card UI
                        showCupertinoModalPopup(
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding:
                                    EdgeInsets.only(left: 25.w, right: 25.w),
                                child: CupertinoActionSheet(
                                  actions: [
                                    Container(
                                      color: Colors.white,
                                      child: CupertinoActionSheetAction(
                                        child: Text(
                                          'Add debit/credit card',
                                          style: AppText.body6(context,
                                              AppColors.textColor, 12.sp),
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                    Container(
                                        color: Colors.white,
                                        child: const Divider()),
                                    Container(
                                      color: Colors.white,
                                      child: CupertinoActionSheetAction(
                                        child: Text(
                                          'Add  card',
                                          style: AppText.body6(context,
                                              AppColors.textColor, 16.sp),
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                  ],
                                  cancelButton: CupertinoActionSheetAction(
                                    child: Text(
                                      "Close",
                                      style: AppText.body6(
                                          context, AppColors.textColor, 16.sp),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              );
                            });
                      },
                      child: EditForm(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        labelText: 'Select card to pay with',
                        keyboardType: TextInputType.number,
                        enabled: false,
                        controller: currency,
                        obscureText: false,
                        validator: (value) => validateCurrency(value),
                        suffixIcon: const Icon(
                          CupertinoIcons.chevron_down,
                          color: Color(0xffA8A8A8),
                          size: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Space(43.h),
              //TODO: To implement custom keyboard
              ExpandableTheme(
                data: const ExpandableThemeData(
                  iconColor: Colors.blue,
                  useInkWell: true,
                ),
                child: Column(
                  children: [
                    ExpandableNotifier(
                      child: ScrollOnExpand(
                        child: Column(
                          children: [
                            ExpandablePanel(
                              theme: const ExpandableThemeData(
                                headerAlignment:
                                    ExpandablePanelHeaderAlignment.center,
                                tapBodyToExpand: true,
                                tapBodyToCollapse: true,
                                hasIcon: false,
                              ),
                              header: Container(
                                padding: EdgeInsets.only(
                                    left: 19.w,
                                    top: 7.w,
                                    bottom: 7.w,
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
                                      style: AppText.body6(
                                          context, AppColors.whiteColor, 16.sp),
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
                                        SizedBox(
                                          width: 100.w,
                                          child: EditForm(
                                            enabled: false,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            labelText: 'USD',

                                            // textAlign: TextAlign.start,
                                            controller: currency,
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
                                        SizedBox(
                                          width: 100.w,
                                          child: EditForm(
                                            enabled: false,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            labelText: 'USD',

                                            // textAlign: TextAlign.start,
                                            controller: currency,
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
                                            enabled: false,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            labelText: 'Enter amount',

                                            // textAlign: TextAlign.start,
                                            controller: currency,
                                            obscureText: false,
                                            validator: (value) =>
                                                validateCurrency(value),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 150.w,
                                          child: EditForm(
                                            enabled: false,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            labelText: 'Enter amount',

                                            // textAlign: TextAlign.start,
                                            controller: currency,
                                            obscureText: false,
                                            validator: (value) =>
                                                validateCurrency(value),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Space(18.h),
                                    // CustomButton(
                                    //   buttonText: 'Next',
                                    //   bgColor:
                                    //       AppColors.appColor.withOpacity(0.3),
                                    //   textColor: AppColors.whiteColor,
                                    //   borderColor:
                                    //       AppColors.appColor.withOpacity(0.3),
                                    //   buttonWidth:
                                    //       MediaQuery.of(context).size.width,
                                    // ),
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
              Space(176.h),
              Padding(
                padding: EdgeInsets.only(left: 22.w, right: 22.w),
                child: CustomButton(
                  buttonText: 'Next',
                  bgColor: AppColors.appColor.withOpacity(0.3),
                  textColor: AppColors.whiteColor,
                  borderColor: AppColors.appColor.withOpacity(0.3),
                  buttonWidth: MediaQuery.of(context).size.width,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
