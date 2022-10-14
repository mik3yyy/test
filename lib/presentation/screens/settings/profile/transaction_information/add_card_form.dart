import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/card/req/add_card_req.dart';
import 'package:kayndrexsphere_mobile/presentation/components/AppSnackBar/snackbar/app_snackbar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/widgets/user_wallets.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent_tab_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/transaction_information/card_widget.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/transaction_information/view_model/add_card_viewmodel.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/edit_form.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/validator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/add-fund-to-wallet/currency_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/generic_controller.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../../components/app text theme/app_text_theme.dart';

class AddCardForm extends StatefulHookConsumerWidget {
  const AddCardForm({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddCardFormState();
}

class _AddCardFormState extends ConsumerState<AddCardForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final toggleStateProvider = StateProvider<bool>((ref) {
    return true;
  });

  // final MaskedTextController _cardNumberController =
  //     MaskedTextController(mask: '0000 0000 0000 0000');

  final TextEditingController _cardNumberController = MaskedTextController(
    mask: '0000 0000 0000 0000',
  );
  final TextEditingController _expiryDateController =
      MaskedTextController(mask: '00/00');
  final TextEditingController _cvvCodeController =
      MaskedTextController(mask: '0000');

  FocusNode cvvFocusNode = FocusNode();
  FocusNode expiryDateNode = FocusNode();
  FocusNode cardHolderNode = FocusNode();

  @override
  void dispose() {
    cardHolderNode.dispose();
    cvvFocusNode.dispose();
    expiryDateNode.dispose();
    super.dispose();
  }

  String dollar = "USD";
  String pound = "GBP";
  String euro = "EUR";
  String naira = "NGN";
  String kayndrex = "KAYNDREX";

  @override
  Widget build(BuildContext context) {
    final card = ref.watch(addCardProvider);
    final toggle = ref.watch(toggleStateProvider.state);
    final depositCurrencyController = useTextEditingController();
    final walletCurrencyController = useTextEditingController();
    final amountController = useTextEditingController();
    final nameController = useTextEditingController();
    final cardControllerValue = useState("");

    ref.listen<RequestState>(addCardProvider, (prev, value) {
      // if (value is Success<AddCardRes>) {
      //   context.loaderOverlay.hide();
      //   if (value.value!.data!.fields![1].contains("address")) {
      //     pushNewScreen(context,
      //         screen: AddressAuthenication(
      //           depositRef: value.value!.data!.depositRef!,
      //           mode: value.value!.data!.mode!,
      //         ));
      //   } else {
      //     pushNewScreen(context,
      //         screen: CardWebView(
      //           url: value.value!.data!.url.toString(),
      //           successMsg: 'Card added',
      //           webViewRoute: WebViewRoute.addCard,
      //         ));
      //   }
      // }

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
          backgroundColor: Colors.transparent,
          title: Text(
            'Transaction Information',
            style: AppText.header2(context, Colors.black, 20.sp),
          ),
          leading: InkWell(
            onTap: (() => Navigator.pop(context)),
            child: const Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        body: Column(
          children: [
            Container(
              height: 40.h,
              width: MediaQuery.of(context).size.width,
              color: AppColors.appColor.withOpacity(0.1),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 7.5, horizontal: 20),
                child: Text(
                  'Add Card',
                  style: AppText.body2Medium(context, Colors.black54, 20.sp),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 23.w, right: 23.w, top: 30.h),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        EditForm(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            labelText: 'Card name',
                            keyboardType: TextInputType.name,
                            // textAlign: TextAlign.start,
                            controller: nameController,
                            obscureText: false,
                            onChanged: (value) {
                              // if (value.isEmpty) {
                              //   return;
                              // }
                              // if (int.tryParse(value)! > amount.value) {
                              //   enteredAmount.value = true;
                              // } else {
                              //   enteredAmount.value = false;
                              // }
                            },
                            validator: (value) => validateCardName(value)),
                        const Space(20),
                        EditForm(
                          controller: _cardNumberController,
                          validator: (value) => validateCardNumber(value),
                          obscureText: false,
                          focusNode: expiryDateNode,
                          labelText: "card number",
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            cardControllerValue.value =
                                value.replaceAll(RegExp(r"\s+\b|\b\s"), "");
                          },
                          onEditingComplete: () {
                            FocusScope.of(context).requestFocus(expiryDateNode);
                          },
                        ),
                        const Space(20),
                        Row(
                          children: [
                            SizedBox(
                              width: 150,
                              child: EditForm(
                                controller: _expiryDateController,
                                validator: (value) => validateExpiryDate(value),
                                obscureText: false,
                                focusNode: cvvFocusNode,
                                labelText: "card expiry",
                                keyboardType: TextInputType.number,
                                onEditingComplete: () {
                                  FocusScope.of(context)
                                      .requestFocus(cvvFocusNode);
                                },
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: 150,
                              child: EditForm(
                                controller: _cvvCodeController,
                                validator: (value) => validateCCV(value),
                                obscureText: false,
                                labelText: "ccv",
                                keyboardType: TextInputType.number,
                                onEditingComplete: () {},
                              ),
                            ),
                          ],
                        ),
                        const Space(20),
                        EditForm(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            labelText: 'Enter amount',
                            keyboardType: TextInputType.number,
                            // textAlign: TextAlign.start,
                            controller: amountController,
                            obscureText: false,
                            onChanged: (value) {
                              // if (value.isEmpty) {
                              //   return;
                              // }
                              // if (int.tryParse(value)! > amount.value) {
                              //   enteredAmount.value = true;
                              // } else {
                              //   enteredAmount.value = false;
                              // }
                            },
                            validator: (value) => validateAmount(value)),
                        const Space(20),
                        InkWell(
                          onTap: () {
                            pushNewScreen(context,
                                screen: SelectCurrencyScreen(
                                  currencyCode: depositCurrencyController,
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
                              controller: depositCurrencyController,
                              obscureText: false,
                              suffixIcon: const Icon(
                                CupertinoIcons.chevron_down,
                                color: Color(0xffA8A8A8),
                                size: 15,
                              ),
                              validator: (value) => validateCountry(value)),
                        ),
                        const Space(20),
                        EditForm(
                            enabled: true,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            labelText: "Wallet currency",
                            keyboardType: TextInputType.text,
                            // textAlign: TextAlign.start,
                            controller: walletCurrencyController,
                            obscureText: false,
                            suffixIcon: SelectWalletList(
                              currency: walletCurrencyController,
                              routeName: "transferScreen",
                            ),
                            validator: (value) => validateCountry(value)),

                        // SelectCurrency(
                        //     text: "Wallet currency",
                        //     dollar: dollar,
                        //     currencyController: walletCurrencyController,
                        //     pound: pound,
                        //     euro: euro,
                        //     naira: naira,
                        //     kayndrex: kayndrex),
                        const Space(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Save card',
                              style:
                                  AppText.header2(context, Colors.black, 20.sp),
                            ),
                            Switch.adaptive(
                                activeColor: Colors.greenAccent,
                                value: toggle.state,
                                onChanged: (value) {
                                  toggle.state = !toggle.state;
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 23, right: 23),
              child: CustomButton(
                  buttonText:
                      card is Loading ? loading() : buttonText(context, "Next"),
                  bgColor: AppColors.appColor,
                  borderColor: AppColors.appColor,
                  textColor: Colors.white,
                  onPressed: card is Loading
                      ? null
                      : () {
                          if (formKey.currentState!.validate()) {
                            var addCardreq = AddCardReq(
                                nameOnCard: nameController.text,
                                cardNumber: cardControllerValue.value,
                                expiration: _expiryDateController.text,
                                cvv: _cvvCodeController.text,
                                amount: amountController.text,
                                saveCard: toggle.state,
                                depositCurrencyCode:
                                    depositCurrencyController.text,
                                walletCurrencyCode:
                                    walletCurrencyController.text);

                            ref
                                .read(genericController.notifier)
                                .addCardReq(addCardreq);

                            ref
                                .read(addCardProvider.notifier)
                                .addCard(addCardreq);
                            context.loaderOverlay.show();
                          }
                        },
                  buttonWidth: MediaQuery.of(context).size.width),
            ),
            const Space(70)
          ],
        ),
      ),
    );
  }
}
