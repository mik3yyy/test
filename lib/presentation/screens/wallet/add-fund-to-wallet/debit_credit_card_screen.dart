import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/make_payment/fund_wallet/fund_wallet_req.dart';
import 'package:kayndrexsphere_mobile/presentation/components/AppSnackBar/snackbar/app_snackbar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/expandable_widget/expanded.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent-tab-view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/transaction_information/view_model/get_card_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/transaction_information/webview/card_webview.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/edit_form.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/validator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/add-fund-to-wallet/vm/fund_wallet_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/safe_pay_withdraw/withdraw_from_wallet.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../../Data/services/payment/make_payment/fund_wallet/fund_wallet_res.dart';
import 'widget/add_fund_heading_container.dart';

class DebitCreditCardScreen extends StatefulHookConsumerWidget {
  const DebitCreditCardScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DebitCreditCardScreenState();
}

class _DebitCreditCardScreenState extends ConsumerState<DebitCreditCardScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String dollar = "USD";
  String pound = "GBP";
  String euro = "EUR";
  String naira = "NGN";
  String kayndrex = "KAYNDREX";
  @override
  Widget build(BuildContext context) {
    final fundWallet = ref.watch(fundWalletProvider);
    final depositController = useTextEditingController();
    final currencyController = useTextEditingController();
    final currency = useTextEditingController();

    final amountController = useTextEditingController();
    final firstDigit = useTextEditingController();
    final secondDigit = useTextEditingController();

    ref.listen<RequestState>(fundWalletProvider, (prev, value) {
      if (value is Success<FundWalletRes>) {
        // print(value.value!.data!.url.toString());
        pushNewScreen(context,
            screen: CardWebView(
              url: value.value!.link!.data!.link.toString(),
              successMsg: 'Wallet Funded',
            ));
      }

      if (value is Error) {
        AppSnackBar.showErrorSnackBar(context, message: value.error.toString());
      }
    });
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
                padding: EdgeInsets.only(left: 23.w, right: 23.w),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 130.w,
                            child: Stack(
                              children: [
                                SelectCurrency(
                                    text: "currency",
                                    dollar: dollar,
                                    currencyController: currencyController,
                                    pound: pound,
                                    euro: euro,
                                    naira: naira,
                                    kayndrex: kayndrex),
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
                            width: 245.w,
                            child: EditForm(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              labelText: 'Enter amount',
                              keyboardType: TextInputType.number,
                              // textAlign: TextAlign.start,
                              controller: amountController,
                              obscureText: false,
                              validator: (value) => validateCurrency(value),
                            ),
                          ),
                        ],
                      ),
                      Space(30.h),
                      SelectSavedCards(
                        firstDigit: firstDigit,
                        secondDigit: secondDigit,
                      ),
                      Space(10.h),
                      SelectCurrency(
                          text: "Deposit currency",
                          dollar: dollar,
                          currencyController: depositController,
                          pound: pound,
                          euro: euro,
                          naira: naira,
                          kayndrex: kayndrex),
                    ],
                  ),
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
                  bgColor: AppColors.appColor,
                  textColor: AppColors.whiteColor,
                  borderColor: AppColors.appColor.withOpacity(0.3),
                  buttonWidth: MediaQuery.of(context).size.width,
                  onPressed: fundWallet is Loading
                      ? null
                      : () {
                          if (formKey.currentState!.validate()) {
                            var fundWalletReq = FundWalletReq(
                                amount: int.parse(amountController.text),
                                depositCurrencyCode: depositController.text,
                                walletCurrencyCode: currencyController.text);

                            ref
                                .read(fundWalletProvider.notifier)
                                .fundWallet(fundWalletReq);
                          }
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

class SelectSavedCards extends StatefulHookConsumerWidget {
  final TextEditingController firstDigit;
  final TextEditingController secondDigit;
  const SelectSavedCards({
    Key? key,
    required this.firstDigit,
    required this.secondDigit,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectSavedCardsState();
}

class _SelectSavedCardsState extends ConsumerState<SelectSavedCards> {
  @override
  Widget build(BuildContext context) {
    final card = ref.watch(getCardProvider);
    return InkWell(
        onTap: () {
          // debugPrint('Hi, we are here');
          //TODO: If card list is not empty from api, to implement the UI of select out of the list of card UI
          showCupertinoModalPopup(
              context: context,
              builder: (context) {
                return Padding(
                  padding: EdgeInsets.only(left: 25.w, right: 25.w),
                  child: CupertinoActionSheet(
                    actions: [
                      Container(
                        color: Colors.white,
                        child: CupertinoActionSheetAction(
                          child: Text(
                            'Add debit/credit card',
                            style: AppText.body6(
                                context, AppColors.textColor, 12.sp),
                          ),
                          onPressed: () {},
                        ),
                      ),
                      // Container(color: Colors.white, child: const Divider()),
                      card.when(
                          error: (error, stackTrace) => Text(error.toString()),
                          idle: () =>
                              const CircularProgressIndicator.adaptive(),
                          loading: () =>
                              const CircularProgressIndicator.adaptive(),
                          success: (data) {
                            return SizedBox(
                                height: 200,
                                child: ListView.builder(
                                    itemCount: data!.data.cards.length,
                                    itemBuilder: (context, index) {
                                      final savedSaved = data.data.cards[index];
                                      return Container(
                                        color: Colors.white,
                                        child: CupertinoActionSheetAction(
                                          child: Text(
                                            "${savedSaved.first6Digits.toString()} ${savedSaved.last4Digits.toString()}",
                                            style: AppText.body6(context,
                                                AppColors.textColor, 16.sp),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              widget.firstDigit.text =
                                                  savedSaved.first6Digits!;
                                              widget.secondDigit.text =
                                                  savedSaved.last4Digits!;
                                            });

                                            Navigator.pop(context);
                                          },
                                        ),
                                      );
                                    }));
                          })
                    ],
                    cancelButton: CupertinoActionSheetAction(
                      child: Text(
                        "Close",
                        style:
                            AppText.body6(context, AppColors.textColor, 16.sp),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.firstDigit.text.isNotEmpty) ...[
              Text(
                "Select card",
                style: AppText.body2(context, Colors.black38, 15.sp),
              ),
            ] else ...[
              Text(
                "Select card",
                style: AppText.body2(context, Colors.black38, 20.sp),
              ),
            ],
            const Space(8),
            if (widget.firstDigit.text.isEmpty) ...[
              const SizedBox.shrink()
            ] else ...[
              Text(
                "${widget.firstDigit.text}${widget.secondDigit.text} ",
                style: AppText.body2(context, Colors.black, 20.sp),
              ),
            ],
            const Space(2),
            const Divider(
              color: Colors.black,
            )
          ],
        ));
  }
}
