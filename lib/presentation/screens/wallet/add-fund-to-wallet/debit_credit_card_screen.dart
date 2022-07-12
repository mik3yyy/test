import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/card/res/get_card.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/make_payment/fund_wallet/fund_wallet_req.dart';
import 'package:kayndrexsphere_mobile/presentation/components/AppSnackBar/snackbar/app_snackbar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/expandable_widget/expanded.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent-tab-view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/transaction_information/add_card_form.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/transaction_information/webview/card_webview.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/edit_form.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/validator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/add-fund-to-wallet/currency_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/add-fund-to-wallet/vm/fund_wallet_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/shared/web_view_route_name.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/generic_controller.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../Data/services/payment/make_payment/fund_wallet/fund_wallet_res.dart';
import '../../../components/app image/app_image.dart';
import '../../settings/profile/transaction_information/view_model/get_card_vm.dart';

class DebitCreditCardScreen extends StatefulHookConsumerWidget {
  const DebitCreditCardScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DebitCreditCardScreenState();
}

class _DebitCreditCardScreenState extends ConsumerState<DebitCreditCardScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // String dollar = "USD";
  // String pound = "GBP";
  // String euro = "EUR";
  // String naira = "NGN";
  // String kayndrex = "KAYNDREX";

  // TextEditingController depositController = TextEditingController();
  // TextEditingController currencyController = TextEditingController();
  // TextEditingController currency = TextEditingController();

  // TextEditingController amountController = TextEditingController();
  // TextEditingController firstDigit = TextEditingController();
  // TextEditingController secondDigit = TextEditingController();

  // void handleValidation() {
  //   if(depositController.text.isEmpty){
  //        AppSnackBar.showInfoSnackBar(context, message: "Please select deposit currency");

  //   }
  //   if (currencyController.text.isEmpty) {
  //     AppSnackBar.showInfoSnackBar(context,
  //         message: "Please choose currency");
  //   }
  //   if (currency.text.isEmpty) {
  //     AppSnackBar.showInfoSnackBar(context,
  //         message: "Please choose deposit currency");
  //   }
  //   if (amountController.text.isEmpty) {
  //     AppSnackBar.showInfoSnackBar(context,
  //         message: "Please enter amount");
  //   }
  //   if (firstDigit.text.isEmpty) {
  //     AppSnackBar.showInfoSnackBar(context,
  //         message: "Please choose a card to proceed");
  //   }

  // }

  @override
  Widget build(BuildContext context) {
    final fundWallet = ref.watch(fundWalletProvider);
    final depositController = useTextEditingController();
    final currencyController = useTextEditingController();
    final fromCurrency = useTextEditingController();
    final toCurrency = useTextEditingController();
    final fromExchangeCurrency = useTextEditingController();
    final toExchangeCurrency = useTextEditingController();

    final amountController = useTextEditingController();
    final firstDigit = useTextEditingController();
    final secondDigit = useTextEditingController();

    ref.listen<RequestState>(fundWalletProvider, (prev, value) {
      if (value is Success<FundWalletRes>) {
        context.loaderOverlay.hide();
        // print(value.value!.data!.url.toString());
        pushNewScreen(context,
            screen: CardWebView(
              url: value.value!.link!.data!.link.toString(),
              successMsg: 'Wallet Funded',
              webViewRoute: WebViewRoute.fundCard,
            ));
      }

      if (value is Error) {
        context.loaderOverlay.hide();
        AppSnackBar.showErrorSnackBar(context, message: value.error.toString());
      }
    });
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: const Center(
        child: SpinKitWave(
          color: AppColors.appColor,
          size: 50.0,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Credit/Debit Card',
            style: AppText.header2(context, Colors.black, 20.sp),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: (() => Navigator.pop(context)),
            child: const Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.black,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 40.h,
                  width: MediaQuery.of(context).size.width,
                  color: AppColors.appColor.withOpacity(0.1),
                  child: Center(
                    child: Text(
                      'Enter an amount you want to fund',
                      style:
                          AppText.body2Medium(context, Colors.black54, 20.sp),
                    ),
                  ),
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
                            InkWell(
                              onTap: () {
                                pushNewScreen(context,
                                    screen: SelectCurrencyScreen(
                                      currencyCode: currencyController,
                                      routeName: 'addFunds',
                                    ),
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.slideRight);
                              },
                              child: SizedBox(
                                width: 130,
                                child: EditForm(
                                    enabled: false,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    labelText: 'currency',
                                    keyboardType: TextInputType.text,
                                    // textAlign: TextAlign.start,
                                    controller: currencyController,
                                    obscureText: false,
                                    suffixIcon: const Icon(
                                      CupertinoIcons.chevron_down,
                                      color: Color(0xffA8A8A8),
                                      size: 15,
                                    ),
                                    validator: (value) =>
                                        validateCountry(value)),
                              ),
                            ),
                            // SizedBox(
                            //   width: 150.w,
                            //   child: Stack(
                            //     children: [
                            //       SelectCurrency(
                            //           text: "currency",
                            //           dollar: dollar,
                            //           currencyController: currencyController,
                            //           pound: pound,
                            //           euro: euro,
                            //           naira: naira,
                            //           kayndrex: kayndrex),
                            //     ],
                            //   ),
                            // ),
                            const Spacer(),
                            SizedBox(
                              // width: MediaQuery.of(context).size.width - 150.w,
                              width: 200.w,
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
                        Space(40.h),
                        SelectSavedCards(
                          firstDigit: firstDigit,
                          secondDigit: secondDigit,
                        ),
                        const Divider(
                          color: Colors.black,
                        ),
                        Space(10.h),

                        InkWell(
                          onTap: () {
                            pushNewScreen(context,
                                screen: SelectCurrencyScreen(
                                  currencyCode: depositController,
                                  routeName: 'addFunds',
                                ),
                                pageTransitionAnimation:
                                    PageTransitionAnimation.slideRight);
                          },
                          child: EditForm(
                              enabled: false,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              labelText: 'Deposit currency',
                              keyboardType: TextInputType.text,
                              // textAlign: TextAlign.start,
                              controller: depositController,
                              obscureText: false,
                              suffixIcon: const Icon(
                                CupertinoIcons.chevron_down,
                                color: Color(0xffA8A8A8),
                                size: 15,
                              ),
                              validator: (value) => validateCountry(value)),
                        ),
                        // SelectCurrency(
                        //     text: "Deposit currency",
                        //     dollar: dollar,
                        //     currencyController: depositController,
                        //     pound: pound,
                        //     euro: euro,
                        //     naira: naira,
                        //     kayndrex: kayndrex),
                      ],
                    ),
                  ),
                ),
                Space(43.h),
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
                                      top: 14.w,
                                      bottom: 14.w,
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
                                          expandIcon:
                                              Icons.expand_more_outlined,
                                          collapseIcon:
                                              Icons.expand_less_outlined,
                                          iconColor: AppColors.whiteColor,
                                          iconSize: 28.0,
                                          iconRotationAngle: math.pi / 2,
                                          iconPadding:
                                              EdgeInsets.only(right: 5),
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
                                                autovalidateMode:
                                                    AutovalidateMode
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
                                                autovalidateMode:
                                                    AutovalidateMode
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
                Space(90.h),
                Padding(
                  padding: EdgeInsets.only(left: 22.w, right: 22.w),
                  child: CustomButton(
                    buttonText: fundWallet is Loading ? 'Processing' : 'Next',
                    bgColor: AppColors.appColor,
                    textColor: AppColors.whiteColor,
                    borderColor: AppColors.appColor.withOpacity(0.3),
                    buttonWidth: MediaQuery.of(context).size.width,
                    onPressed: fundWallet is Loading
                        ? null
                        : () {
                            if (formKey.currentState!.validate()) {
                              if (firstDigit.text.isEmpty) {
                                AppSnackBar.showInfoSnackBar(context,
                                    message: "choose a card");
                              } else {
                                var fundWalletReq = FundWalletReq(
                                    amount: int.parse(amountController.text),
                                    depositCurrencyCode: depositController.text,
                                    walletCurrencyCode:
                                        currencyController.text);

                                ref
                                    .read(fundWalletProvider.notifier)
                                    .fundWallet(fundWalletReq);
                                context.loaderOverlay.show();
                              }
                            }
                          },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
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
  List<Cardd> card = [];
  @override
  Widget build(BuildContext context) {
    final brandImage = useState("");
    // final card = ref.watch(getCardProvider);
    // final cards = ref.watch(genericController);
    final getCard = ref.watch(getCardProvider);

    double _cardsHeight() {
      if (card.length == 4) {
        return 200;
      } else if (card.length == 3) {
        return 170;
      } else if (card.length == 2) {
        return 110;
      } else if (card.length == 1) {
        return 70;
      } else {
        return 100;
      }
    }

    return InkWell(
        onTap: () {
          showModalBottomSheet(
              backgroundColor: Colors.transparent,
              context: context,
              builder: (builder) {
                return Container(
                  height: 350.0,
                  width: 200,
                  color: Colors
                      .transparent, //could change this to Color(0xFF737373),
                  //so you don't have to change MaterialApp canvasColor
                  child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0))),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            left: 30,
                            right: 30,
                            bottom: 200,
                            child: Container(
                                height: _cardsHeight(),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                ),
                                child: getCard.when(
                                    idle: () => const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                    loading: () => const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                    success: (data) {
                                      card = data!.data.cards;
                                      double _listSize() {
                                        if (data.data.cards.length == 4) {
                                          return 200;
                                        } else if (data.data.cards.length ==
                                            3) {
                                          return 170;
                                        } else if (data.data.cards.length ==
                                            2) {
                                          return 110;
                                        } else if (data.data.cards.length ==
                                            1) {
                                          return 70;
                                        } else {
                                          return 100;
                                        }
                                      }

                                      return data.data.cards.isEmpty
                                          ? Text("You have no card",
                                              style: AppText.body2Medium(
                                                  context,
                                                  AppColors.textColor,
                                                  25.sp))
                                          : SizedBox(
                                              height: _listSize(),
                                              child: ListView.builder(
                                                  itemCount:
                                                      data.data.cards.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final savedCard =
                                                        data.data.cards[index];
                                                    String _getBrand() {
                                                      if (savedCard.brand ==
                                                          "MASTERCARD") {
                                                        return AppImage
                                                            .masterCard;
                                                      }
                                                      if (savedCard.brand ==
                                                          "VISA") {
                                                        return AppImage.visa;
                                                      }
                                                      if (savedCard.brand ==
                                                          "VERVE") {
                                                        return AppImage.verve;
                                                      }
                                                      if (savedCard.brand ==
                                                          "VISA") {
                                                        return AppImage.visa;
                                                      }
                                                      if (savedCard.brand ==
                                                          "MAESTRO") {
                                                        return AppImage.maestro;
                                                      }

                                                      return '';
                                                    }

                                                    return Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 20),
                                                      child: InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            widget.firstDigit
                                                                    .text =
                                                                savedCard
                                                                    .first6Digits!;
                                                            widget.secondDigit
                                                                    .text =
                                                                savedCard
                                                                    .last4Digits!;
                                                            brandImage.value =
                                                                savedCard
                                                                    .brand!;
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SvgPicture.asset(
                                                              _getBrand(),
                                                              height: 25,
                                                              width: 25,
                                                            ),
                                                            const Space(10),
                                                            Text(
                                                              "${savedCard.first6Digits.toString()}${savedCard.last4Digits.toString()}",
                                                              style: AppText.body6(
                                                                  context,
                                                                  AppColors
                                                                      .textColor,
                                                                  25.sp),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                            );
                                    },
                                    error: (e, s) => Text(e.toString()))

                                // cards.cards.isEmpty
                                //     ? Center(
                                //         child: Text("You have no card",
                                //             style: AppText.body2Medium(context,
                                //                 AppColors.textColor, 25.sp)),
                                //       )
                                //     : SizedBox(
                                //         height: 50,
                                //         child: ListView.builder(
                                //             itemCount: cards.cards.length,
                                //             itemBuilder: (context, index) {
                                //               final savedCard =
                                //                   cards.cards[index];
                                //               String _getBrand() {
                                //                 if (savedCard.brand ==
                                //                     "MASTERCARD") {
                                //                   return AppImage.masterCard;
                                //                 }
                                //                 if (savedCard.brand == "VISA") {
                                //                   return AppImage.visa;
                                //                 }
                                //                 if (savedCard.brand == "VERVE") {
                                //                   return AppImage.verve;
                                //                 }
                                //                 if (savedCard.brand == "VISA") {
                                //                   return AppImage.visa;
                                //                 }
                                //                 if (savedCard.brand ==
                                //                     "MAESTRO") {
                                //                   return AppImage.maestro;
                                //                 }

                                //                 return '';
                                //               }

                                //               return Container(
                                //                 padding: const EdgeInsets.only(
                                //                     top: 20),
                                //                 child: InkWell(
                                //                   onTap: () {
                                //                     setState(() {
                                //                       widget.firstDigit.text =
                                //                           savedCard.first6Digits!;
                                //                       widget.secondDigit.text =
                                //                           savedCard.last4Digits!;
                                //                       brandImage.value =
                                //                           savedCard.brand!;
                                //                     });
                                //                     Navigator.pop(context);
                                //                   },
                                //                   child: Row(
                                //                     mainAxisAlignment:
                                //                         MainAxisAlignment.center,
                                //                     children: [
                                //                       SvgPicture.asset(
                                //                         _getBrand(),
                                //                         height: 25,
                                //                         width: 25,
                                //                       ),
                                //                       const Space(10),
                                //                       Text(
                                //                         "${savedCard.first6Digits.toString()}${savedCard.last4Digits.toString()}",
                                //                         style: AppText.body6(
                                //                             context,
                                //                             AppColors.textColor,
                                //                             25.sp),
                                //                       ),
                                //                     ],
                                //                   ),
                                //                 ),
                                //               );
                                //             }),
                                //       ),
                                ),
                          ),
                          Positioned(
                            left: 30,
                            right: 30,
                            bottom: 130,
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                pushNewScreen(context,
                                    screen: const AddCardForm(),
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.slideRight);
                              },
                              child: Container(
                                height: 50,
                                child: Center(
                                  child: Text(
                                    "Add card",
                                    style: AppText.body6(
                                        context, AppColors.textColor, 20.sp),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(23),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 30,
                            right: 30,
                            bottom: 70,
                            child: InkWell(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                height: 50,
                                child: Center(
                                  child: Text(
                                    "Close",
                                    style: AppText.body6(
                                        context, AppColors.textColor, 20.sp),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(23),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
                );
              });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.firstDigit.text.isNotEmpty) ...[
              Text(
                "Select card to pay with",
                style: AppText.body2(context, Colors.black38, 15.sp),
              ),
            ] else ...[
              Text(
                "Select card to pay with",
                style: AppText.body2(context, Colors.black38, 20.sp),
              ),
            ],
            const Space(7),
            Row(
              children: [
                if (brandImage.value == "MASTERCARD") ...[
                  SvgPicture.asset(
                    AppImage.masterCard,
                    height: 23,
                    width: 23,
                  ),
                ] else if (brandImage.value == "VERVE") ...[
                  SvgPicture.asset(
                    AppImage.verve,
                    height: 23,
                    width: 23,
                  ),
                ] else if (brandImage.value == "VISA") ...[
                  SvgPicture.asset(
                    AppImage.visa,
                    height: 23,
                    width: 23,
                  ),
                ],
                const Space(20),
                const Space(8),
                if (widget.firstDigit.text.isEmpty) ...[
                  const SizedBox.shrink()
                ] else ...[
                  Text(
                    "${widget.firstDigit.text}${widget.secondDigit.text} ",
                    style: AppText.body2(context, Colors.black, 20.sp),
                  ),
                ],
              ],
            ),
          ],
        ));
  }
}
