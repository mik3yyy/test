import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/user_account_details_res.dart';
import 'package:kayndrexsphere_mobile/presentation/components/AppSnackBar/snackbar/app_snackbar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/vm/sign_in_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/profile/vm/get_user_profile.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/edit_form.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/dropdown/custom_dropdown.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/get_account_details_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/wallet_transfer_vm.dart.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_textfield.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/dialog/dialog.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../components/app text theme/app_text_theme.dart';
import '../../../components/reusable_widget.dart/custom_button.dart';

class ToWallet extends StatefulHookConsumerWidget {
  // final List<Wallet>? wallet;
  const ToWallet(
      {

      // required this.wallet,

      Key? key})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ToWalletState();
}

class _ToWalletState extends ConsumerState<ToWallet> {
  final passwordToggleStateProvider = StateProvider<bool>((ref) => true);
  final formKey = GlobalKey<FormState>();

  final List<Map<String, dynamic>> _items = [
    //TODO: How to loop through and remove default wallet code because you can tranfer to default wallet
    {
      'value': 'EUR',
      'label': '€ Euro',
      // 'icon': Icon(Icons.stop),
    },
    {
      'value': 'GBP',
      'label': '£ Pounds',
      // 'icon': Icon(Icons.fiber_manual_record),
      // 'textStyle': TextStyle(color: Colors.red),
    },
    {
      'value': 'NGN',
      'label': 'NGN Naira',
      // 'enable': false,
      // 'icon': Icon(Icons.grade),
    },
    // {
    //   'value': '€ Euro',
    //   'label': '€ Euro',
    //   // 'icon': Icon(Icons.stop),
    // },
    // {
    //   'value': '£ Pounds',
    //   'label': '£ Pounds',
    //   // 'icon': Icon(Icons.fiber_manual_record),
    //   // 'textStyle': TextStyle(color: Colors.red),
    // },
    // {
    //   'value': 'NGN Naira',
    //   'label': 'NGN Naira',
    //   // 'enable': false,
    //   // 'icon': Icon(Icons.grade),
    // },
  ];
  String? selectedItem = 'Euro';
  @override
  Widget build(BuildContext context) {
    //TODO: to refresh accoun details
    // ref.refresh(getAccountDetailsProvider);
    // final userWallet =
    //     widget.wallet!.where((element) => element.isDefault == 1).toList();
    final defaultWallet = ref.watch(getUserProfileProvider);
    // final defaultWallet = ref.watch(signInProvider);
    final vm = ref.watch(transferToWalletProvider);
    final transactionPinToggle = ref.watch(passwordToggleStateProvider.state);
    // final fistNameController = useTextEditingController();
    final amountController = useTextEditingController();
    final toCurrencyController = useTextEditingController();
    final transactionPinController = useTextEditingController();

    final currencyCode = defaultWallet.maybeWhen(
        success: (v) => v!.data!.defaultWallet!.currencyCode!,
        orElse: () => '');

    ref.listen<RequestState>(transferToWalletProvider, (T, value) {
      if (value is Success) {
        context.loaderOverlay.hide();
        //TODO: We might need to refactor the success dialog
        AppDialog.showSuccessMessageDialog(
            context, 'Funds transferred successfully');
        //Refreshing user account details, so the new balance can reflect on the screen

        ref.refresh(getUserProfileProvider);
        amountController.clear();
        toCurrencyController.clear();
        transactionPinController.clear();

        // return AppSnackBar.showSuccessSnackBar(context,
        //     message: 'Transfer Succesfully');
      }
      if (value is Error) {
        context.loaderOverlay.hide();
        AppDialog.showErrorMessageDialog(context, value.error.toString());
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
      child: Padding(
        padding: EdgeInsets.only(left: 30.w, right: 30.w),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Transfer from $currencyCode wallet to other wallets',
                    style: AppText.body2(context, Colors.black, 19.sp),
                  ),
                ),
                Space(25.h),
                Text(
                  'Enter amount',
                  style: AppText.body2(context, AppColors.appColor, 19.sp),
                ),
                Space(5.h),
                WalletTextField(
                  labelText: 'Click to type',
                  obscureText: false,
                  color: Colors.white,
                  controller: amountController,
                  readOnly: false,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please entee amount';
                    }
                    return null;
                  },
                ),
                Space(25.h),
                Text(
                  'Select wallet account currency',
                  style: AppText.body2(context, AppColors.appColor, 19.sp),
                ),
                Space(5.h),
                SelectFormField(
                  type: SelectFormFieldType.dropdown, // or can be dialog
                  // initialValue: selectedItem,
                  controller: toCurrencyController,
                  style: AppText.body2(context, Colors.black, 19.sp),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please select a currency you want to transfer to';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Select currency',
                    hintStyle: AppText.body2(context, Colors.grey[400]!, 19.sp),
                    // floatingLabelBehavior: FloatingLabelBehavior.never,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0.h, horizontal: 10.w),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.appColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: AppColors.appColor, width: 1),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    suffixIcon: const Icon(
                      Icons.arrow_drop_down_outlined,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  items: _items,
                  onChanged: (val) => print(val),
                  onSaved: (val) => print(val),
                ),
                Space(35.h),
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
                            style:
                                AppText.header2(context, Colors.black, 20.sp),
                          ),
                          const Space(2),
                          Text(
                            'Enter transaction PIN',
                            style:
                                AppText.body2Bold(context, Colors.black, 23.sp),
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
                  controller: transactionPinController,
                  obscureText: transactionPinToggle.state,
                  // validator: (value) => validatePassword(value),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Transaction pin is required';
                    }
                    return null;
                  },
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
                  onPressed: vm is Loading
                      ? null
                      : () {
                          if (formKey.currentState!.validate()) {
                            ref
                                .read(transferToWalletProvider.notifier)
                                .transferToWallet(
                                  currencyCode,
                                  toCurrencyController.text,
                                  int.parse(amountController.text),
                                  transactionPinController.text,
                                );
                            context.loaderOverlay.show();
                          }
                          // context.loaderOverlay.show();
                          // WalletDialog.transactionDialog(context,
                          //     transfered: "€ 400.00",
                          //     details: 'Dollar wallet to Euro wallet',
                          //     received: '£ 300.00');
                          // pushNewScreen(
                          //   context,
                          //   screen: const ViewAllWallet(),
                          //   withNavBar: true, // OPTIONAL VALUE. True by default.
                          //   pageTransitionAnimation: PageTransitionAnimation.fade,
                          // );
                          // context.navigate(AvailableBalance()

                          // );
                        },
                  buttonWidth: MediaQuery.of(context).size.width,
                ),
                Space(7.h),
                Center(
                  child: Text(
                    'Cancel',
                    style: AppText.header3(context, AppColors.appColor, 20.sp),
                  ),
                ),
                Space(80.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ToWalletTab extends HookConsumerWidget {
  ToWalletTab({Key? key}) : super(key: key);

  final passwordToggleStateProvider = StateProvider<bool>((ref) => true);
  @override
  Widget build(BuildContext context, ref) {
    final togglePassword = ref.watch(passwordToggleStateProvider.state);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Space(10.h),
          Center(
            child: Text(
              'Transfer from dollar wallet to other wallets',
              style: AppText.body2(context, Colors.grey[400]!, 17.sp),
            ),
          ),
          Space(25.h),
          Text(
            'Enter amount',
            style: AppText.body2(context, AppColors.appColor, 19.sp),
          ),
          Space(5.h),
          const WalletTextField(
            labelText: 'Click to type',
            obscureText: false,
            color: Colors.white,
            readOnly: false,
          ),
          Space(25.h),
          Text(
            'Select wallet account currency',
            style: AppText.body2(context, AppColors.appColor, 19.sp),
          ),
          Space(5.h),
          const WalletTextField(
            labelText: 'Select currency',
            obscureText: false,
            color: Colors.white,
            readOnly: false,
          ),
          Space(25.h),
          Center(
            child: Text(
              'Enter password',
              style: AppText.header3(context, AppColors.appColor, 20.sp),
            ),
          ),
          Space(5.h),
          Center(
            child: Text(
              'For security reasons, please enter your password',
              style: AppText.body2(context, AppColors.appColor, 16.sp),
            ),
          ),
          Space(5.h),
          WalletTextField(
            labelText: '',
            obscureText: true,
            readOnly: false,
            color: Colors.white,
            suffixIcon: GestureDetector(
              onTap: () {
                togglePassword.state = !togglePassword.state;
              },
              child: Padding(
                padding: EdgeInsets.only(bottom: 0.h),
                child: Icon(
                  togglePassword.state
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: AppColors.appColor,
                ),
              ),
            ),
          ),
          Space(10.h),
          CustomButton(
              buttonText: 'Transfer',
              bgColor: AppColors.appColor,
              borderColor: AppColors.appColor,
              textColor: Colors.white,
              onPressed: () {
                // pushNewScreen(
                //   context,
                //   screen: const ViewAllWallet(),
                //   withNavBar: true, // OPTIONAL VALUE. True by default.
                //   pageTransitionAnimation: PageTransitionAnimation.fade,
                // );
                // context.navigate(AvailableBalance()

                // );
              },
              buttonWidth: MediaQuery.of(context).size.width),
          Space(7.h),
          Center(
            child: Text(
              'Cancel',
              style: AppText.header3(context, AppColors.appColor, 20.sp),
            ),
          ),
          Space(20.h),
        ],
      ),
    );
  }
}
