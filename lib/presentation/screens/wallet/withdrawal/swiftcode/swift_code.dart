import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/edit_form.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/validator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/Nuban/nuban.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/widget/currency.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../../components/app text theme/app_text_theme.dart';

class SwiftCodeView extends StatefulHookConsumerWidget {
  const SwiftCodeView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SwiftCodeViewState();
}

class _SwiftCodeViewState extends ConsumerState<SwiftCodeView> {
  final toggleStateProvider = StateProvider<bool>((ref) {
    return true;
  });
  final transactionPinStateProvider = StateProvider<bool>((ref) => true);
  final toggleSelectionProvider = StateProvider<String>((ref) => 'IBAN');

  final String amount = '750';
  @override
  Widget build(BuildContext context) {
    final toggle = ref.watch(toggleStateProvider.state);
    final transactionPinToggle = ref.watch(transactionPinStateProvider.state);
    final fistNameController = useTextEditingController();
    final currencyController = useTextEditingController();
    final bankController = useTextEditingController();

    final selection = ref.watch(toggleSelectionProvider.state);
    final amountController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'SWIFTCODE [BIC]',
          style: AppText.header2(context, Colors.black, 20.sp),
        ),
        leading: InkWell(
          onTap: (() => Navigator.pop(context)),
          child: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.black,
          ),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
          child: Column(
            children: [
              Container(
                height: 40.h,
                width: MediaQuery.of(context).size.width,
                color: AppColors.appColor.withOpacity(0.05),
                child: Padding(
                  padding: EdgeInsets.only(right: 210.w),
                  child: Center(
                    child: Text(
                      'Withdraw From Wallets',
                      style: AppText.body2(context, Colors.black54, 20.sp),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20.w, left: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Space(20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ToggleSelection(
                          textColor: selection.state == 'IBAN'
                              ? AppColors.appColor
                              : Colors.grey[400]!,
                          borderColor: selection.state == 'IBAN'
                              ? AppColors.appColor
                              : Colors.grey[200]!,
                          color: selection.state == 'IBAN'
                              ? Colors.grey[200]!
                              : Colors.grey[100]!,
                          name: 'IBAN',
                          onPressed: () {
                            selection.state = 'IBAN';
                            print(selection.state);
                          },
                        ),
                        ToggleSelection(
                          textColor: selection.state == 'SEPA'
                              ? AppColors.appColor
                              : Colors.grey[400]!,
                          borderColor: selection.state == 'SEPA'
                              ? AppColors.appColor
                              : Colors.grey[200]!,
                          color: selection.state == 'SEPA'
                              ? Colors.grey[200]!
                              : Colors.grey[100]!,
                          name: 'SEPA',
                          onPressed: () {
                            selection.state = 'SEPA';
                            print(selection.state);
                          },
                        ),
                      ],
                    ),

                    Space(20.h),
                    Stack(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: EditForm(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              labelText: 'Enter amount',
                              keyboardType: TextInputType.number,
                              // textAlign: TextAlign.start,
                              controller: amountController,
                              obscureText: false,
                              validator: (value) => validateCountry(value)),
                        ),
                        Positioned(
                            left: 375.w,
                            right: 0,
                            bottom: 17.h,
                            child: const Icon(
                              Icons.check_circle,
                              color: Colors.red,
                              size: 15,
                            )),
                      ],
                    ),
                    Space(20.h),
                    //*
                    //*
                    //* Select currency
                    //*
                    //*
                    CurrencyWidget(
                      currencyController: currencyController,
                      text: 'Select wallet to withdraw from',
                    ),

                    Space(20.h),
                    EditForm(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        labelText: selection.state == "IBAN"
                            ? 'Enter IBAN of recipient'
                            : 'Enter SEPA of recipient',
                        keyboardType: TextInputType.text,
                        // textAlign: TextAlign.start,
                        controller: fistNameController,
                        obscureText: false,
                        validator: (value) => validateState(value)),
                    Space(10.h),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'John Doe',
                        style:
                            AppText.body2(context, Colors.greenAccent, 18.sp),
                      ),
                    ),
                    Space(20.h),
                    EditForm(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        labelText: 'Enter account name of recipient',
                        keyboardType: TextInputType.name,
                        // textAlign: TextAlign.start,
                        controller: fistNameController,
                        obscureText: false,
                        validator: (value) => validateFirstName(value)),
                    Space(20.h),
                    EditForm(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        labelText: 'Enter account number of recipient',
                        keyboardType: TextInputType.number,
                        // textAlign: TextAlign.start,
                        controller: amountController,
                        obscureText: false,
                        validator: (value) => validateCountry(value)),
                    Space(20.h),
                    Stack(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: EditForm(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              labelText: 'Enter Country',
                              keyboardType: TextInputType.number,
                              // textAlign: TextAlign.start,
                              controller: fistNameController,
                              obscureText: false,
                              validator: (value) => validateCountry(value)),
                        ),
                        Positioned(
                          left: 375.w,
                          right: 0,
                          bottom: 17.h,
                          child: const Icon(
                            CupertinoIcons.chevron_down,
                            color: Color(0xffA8A8A8),
                            size: 15,
                          ),
                        ),
                      ],
                    ),
                    Space(20.h),
                    SelectBank(bankController: bankController),
                    Space(20.h),
                    EditForm(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        labelText: 'Enter bank address of recipient',
                        keyboardType: TextInputType.text,
                        // textAlign: TextAlign.start,
                        controller: fistNameController,
                        obscureText: false,
                        validator: (value) {
                          return null;
                        }),
                    Space(20.h),
                    EditForm(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        labelText: 'Enter swift code of recipient’s bank',
                        keyboardType: TextInputType.number,
                        // textAlign: TextAlign.start,
                        controller: fistNameController,
                        obscureText: false,
                        validator: (value) {
                          return null;
                        }),
                    Space(20.h),

                    EditForm(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        labelText: 'Purpose of withdrawal/transfer ',
                        keyboardType: TextInputType.text,
                        // textAlign: TextAlign.start,
                        controller: fistNameController,
                        obscureText: false,
                        validator: (value) => validatePhoneNumber(value)),
                    Space(20.h),
                    Row(
                      children: [
                        Text(
                          'Add to beneficiaries',
                          style: AppText.header2(context, Colors.black, 20.sp),
                        ),
                        const Spacer(),
                        Switch.adaptive(
                            activeColor: Colors.greenAccent,
                            value: toggle.state,
                            onChanged: (value) {
                              toggle.state = !toggle.state;
                            }),
                      ],
                    ),
                    Space(20.h),
                    Container(
                      height: 80.h,
                      width: MediaQuery.of(context).size.width,
                      color: AppColors.appColor.withOpacity(0.05),
                      child: Row(
                        children: [
                          Space(20.w),
                          const Icon(
                            Icons.security,
                            size: 30,
                          ),
                          Space(15.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'For security reasons',
                                style: AppText.header2(
                                    context, Colors.black, 20.sp),
                              ),
                              const Space(2),
                              Text(
                                'Enter transaction PIN',
                                style: AppText.body2Bold(
                                    context, Colors.black, 23.sp),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Space(20.h),
                    EditForm(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      labelText: 'Enter Transaction Pin',
                      keyboardType: TextInputType.text,
                      // textAlign: TextAlign.start,
                      controller: fistNameController,
                      obscureText: transactionPinToggle.state,
                      validator: (value) => validatePassword(value),
                      suffixIcon: SizedBox(
                        width: 55.w,
                        child: GestureDetector(
                          onTap: () {
                            transactionPinToggle.state =
                                !transactionPinToggle.state;
                          },
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 0.h),
                            child: Icon(
                              transactionPinToggle.state
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Space(20.h),
                    CustomButton(
                        buttonText: 'Withdraw to bank',
                        bgColor: AppColors.appColor,
                        borderColor: AppColors.appColor,
                        textColor: Colors.white,
                        onPressed: () {},
                        buttonWidth: MediaQuery.of(context).size.width),
                    Space(7.h),
                    Center(
                      child: Text(
                        'Cancel',
                        style:
                            AppText.header3(context, AppColors.appColor, 20.sp),
                      ),
                    ),
                  ],
                ),
              ),
              Space(100.h),
            ],
          ),
        ),
      ),
    );
  }
}

class ToggleSelection extends StatelessWidget {
  final String name;
  final Color color;
  final Color borderColor;
  final Color textColor;
  final void Function()? onPressed;
  const ToggleSelection(
      {Key? key,
      required this.name,
      required this.color,
      required this.borderColor,
      required this.textColor,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
      height: 40,
      width: 150,
      decoration: BoxDecoration(
          border: Border.all(width: 1.w, color: borderColor),
          borderRadius: BorderRadius.circular(30.r),
          color: color),
      child: InkWell(
        onTap: onPressed,
        child: Center(
          child: Text(
            name,
            style: AppText.body2(context, textColor, 19.sp),
          ),
        ),
      ),
    );
  }
}
