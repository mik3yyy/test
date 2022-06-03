import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/edit_form.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/validator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/dialog/dialog.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../../components/app text theme/app_text_theme.dart';

class WithdrawFromWallet extends StatefulHookConsumerWidget {
  const WithdrawFromWallet({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _WithdrawFromWalletState();
}

class _WithdrawFromWalletState extends ConsumerState<WithdrawFromWallet> {
  final toggleStateProvider = StateProvider<bool>((ref) {
    return true;
  });
  final transactionPinStateProvider = StateProvider<bool>((ref) => true);
  String dollar = "DOLLAR";
  String pound = "POUND";
  String euro = "EURO";
  String naira = "NAIRA";
  String kayndrex = "KAYNDREX";

  @override
  Widget build(BuildContext context) {
    final toggle = ref.watch(toggleStateProvider.state);
    final transactionPinToggle = ref.watch(transactionPinStateProvider.state);
    final fistNameController = useTextEditingController();
    final currencyController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Safe Transfer',
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
                    Container(
                      height: 80.h,
                      width: MediaQuery.of(context).size.width,
                      color: AppColors.appColor.withOpacity(0.05),
                      child: Row(
                        children: [
                          Space(20.w),
                          Container(
                            height: 30.h,
                            width: 30.w,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(width: 1, color: Colors.black)),
                            child: Center(
                              child: Text(
                                '\$',
                                style:
                                    AppText.body2(context, Colors.black, 15.sp),
                              ),
                            ),
                          ),
                          Space(15.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Dollar wallet balance',
                                style:
                                    AppText.body2(context, Colors.black, 18.sp),
                              ),
                              const Space(2),
                              Text(
                                '\$ 750',
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
                      labelText: 'Enter Amount',
                      keyboardType: TextInputType.name,
                      // textAlign: TextAlign.start,
                      controller: fistNameController,

                      obscureText: false,
                      validator: (value) => validateFirstName(value),
                    ),
                    Space(20.h),
                    Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            showCupertinoModalPopup(
                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.w, right: 25.w),
                                    child: CupertinoActionSheet(
                                      actions: <Widget>[
                                        Container(
                                          color: Colors.white,
                                          child: CupertinoActionSheetAction(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 30.w, right: 30.w),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    dollar,
                                                    style: AppText.body2(
                                                        context,
                                                        Colors.black,
                                                        20.sp),
                                                  ),
                                                  const Spacer(),
                                                  Container(
                                                    height: 25.h,
                                                    width: 25.w,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            width: 1,
                                                            color:
                                                                Colors.black)),
                                                    child: Center(
                                                      child: Text(
                                                        '\$',
                                                        style: AppText.body2(
                                                            context,
                                                            Colors.black,
                                                            15.sp),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            isDefaultAction: true,
                                            onPressed: () {
                                              currencyController.text = dollar;
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                        Container(
                                          color: Colors.white,
                                          child: CupertinoActionSheetAction(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 30.w, right: 30.w),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    pound,
                                                    style: AppText.body2(
                                                        context,
                                                        Colors.black,
                                                        20.sp),
                                                  ),
                                                  const Spacer(),
                                                  Container(
                                                    height: 25.h,
                                                    width: 25.w,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            width: 1,
                                                            color:
                                                                Colors.black)),
                                                    child: Center(
                                                      child: Text(
                                                        '\$',
                                                        style: AppText.body2(
                                                            context,
                                                            Colors.black,
                                                            15.sp),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            isDestructiveAction: true,
                                            onPressed: () {
                                              currencyController.text = pound;
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                        Container(
                                          color: Colors.white,
                                          child: CupertinoActionSheetAction(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 30.w, right: 30.w),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    euro,
                                                    style: AppText.body2(
                                                        context,
                                                        Colors.black,
                                                        20.sp),
                                                  ),
                                                  const Spacer(),
                                                  Container(
                                                    height: 25.h,
                                                    width: 25.w,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            width: 1,
                                                            color:
                                                                Colors.black)),
                                                    child: Center(
                                                      child: Text(
                                                        '\$',
                                                        style: AppText.body2(
                                                            context,
                                                            Colors.black,
                                                            15.sp),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            isDestructiveAction: true,
                                            onPressed: () {
                                              currencyController.text = euro;
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                        Container(
                                          color: Colors.white,
                                          child: CupertinoActionSheetAction(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 30.w, right: 30.w),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    naira,
                                                    style: AppText.body2(
                                                        context,
                                                        Colors.black,
                                                        20.sp),
                                                  ),
                                                  const Spacer(),
                                                  Container(
                                                    height: 25.h,
                                                    width: 25.w,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            width: 1,
                                                            color:
                                                                Colors.black)),
                                                    child: Center(
                                                      child: Text(
                                                        '\$',
                                                        style: AppText.body2(
                                                            context,
                                                            Colors.black,
                                                            15.sp),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            isDestructiveAction: true,
                                            onPressed: () {
                                              currencyController.text = naira;
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                        Container(
                                          color: Colors.white,
                                          child: CupertinoActionSheetAction(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 30.w, right: 30.w),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    kayndrex,
                                                    style: AppText.body2(
                                                        context,
                                                        Colors.black,
                                                        20.sp),
                                                  ),
                                                  const Spacer(),
                                                  Container(
                                                    height: 25.h,
                                                    width: 25.w,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            width: 1,
                                                            color:
                                                                Colors.black)),
                                                    child: Center(
                                                      child: Text(
                                                        '\$',
                                                        style: AppText.body2(
                                                            context,
                                                            Colors.black,
                                                            15.sp),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            isDestructiveAction: true,
                                            onPressed: () {
                                              currencyController.text =
                                                  kayndrex;
                                              Navigator.pop(context);
                                            },
                                          ),
                                        )
                                      ],
                                      cancelButton: CupertinoActionSheetAction(
                                        child: const Text("Close"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: EditForm(
                              enabled: false,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              labelText: 'Select wallet to transfer from',

                              // textAlign: TextAlign.start,
                              controller: currencyController,
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
                    EditForm(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        labelText: 'Enter Kayndrexsphere Acc no of recipient',
                        keyboardType: TextInputType.number,
                        // textAlign: TextAlign.start,
                        controller: fistNameController,
                        obscureText: false,
                        validator: (value) => validateState(value)),
                    Space(20.h),
                    EditForm(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        labelText: 'Purpose of transfer',
                        keyboardType: TextInputType.text,
                        // textAlign: TextAlign.start,
                        controller: fistNameController,
                        obscureText: false,
                        validator: (value) => validateState(value)),
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
                        buttonText: 'Transfer',
                        bgColor: AppColors.appColor,
                        borderColor: AppColors.appColor,
                        textColor: Colors.white,
                        onPressed: () {
                          AppDialog.showSuccessWalletDialog(
                              context, '\$500', 'withdrawn to Jane Doe');
                        },
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