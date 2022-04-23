import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/dropdown/custom_dropdown.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_textfield.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../components/app image/app_image.dart';
import '../../../components/app text theme/app_text_theme.dart';
import '../../../components/dialogs/wallet_dialog.dart';
import '../widget/wallet_view_widget.dart';

class Withdraw extends StatefulHookConsumerWidget {
  const Withdraw({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WithdrawState();
}

class _WithdrawState extends ConsumerState<Withdraw> {
  final passwordToggleStateProvider = StateProvider<bool>((ref) => true);
  final toggleSelectionProvider = StateProvider<String>((ref) => 'IBAN');

  final List<Map<String, dynamic>> _transfer = [
    {
      'value': 'Safe transfer',
      'label': 'Safe transfer',
      'textStyle': const TextStyle(color: Color(0xFF072777)),
      // 'icon': Icon(Icons.stop),
    },
    {
      'value': 'ABA number',
      'label': 'ABA number',
      // 'icon': Icon(Icons.fiber_manual_record),
      'textStyle': const TextStyle(color: Color(0xFF072777)),
    },
    {
      'value': 'Swift code/BIC',
      'label': 'Swift code/BIC',
      'textStyle': const TextStyle(color: Color(0xFF072777)),
      // 'enable': false,
      // 'icon': Icon(Icons.grade),
    },
    {
      'value': 'NUBAN',
      'label': 'NUBAN',
      'textStyle': const TextStyle(color: Color(0xFF072777)),
      // 'enable': false,
      // 'icon': Icon(Icons.grade),
    },
  ];

  final List<Map<String, dynamic>> _wallet = [
    {
      'value': '€ Euro',
      'label': '€ Euro',
      'textStyle': const TextStyle(color: Color(0xFF072777)),
      // 'icon': Icon(Icons.stop),
    },
    {
      'value': '£ Pounds',
      'label': '£ Pounds',
      'textStyle': const TextStyle(color: Color(0xFF072777)),
      // 'icon': Icon(Icons.fiber_manual_record),
      // 'textStyle': TextStyle(color: Colors.red),
    },
    {
      'value': 'NGN Naira',
      'label': 'NGN Naira',
      'textStyle': const TextStyle(color: Color(0xFF072777)),
      // 'enable': false,
      // 'icon': Icon(Icons.grade),
    },
    {
      'value': '\$ Dollar',
      'label': '\$ Dollar',
      'textStyle': const TextStyle(color: Color(0xFF072777)),
      // 'enable': false,
      // 'icon': Icon(Icons.grade),
    },
  ];
  @override
  Widget build(BuildContext context) {
    final togglePassword = ref.watch(passwordToggleStateProvider.state);
    final selection = ref.watch(toggleSelectionProvider.state);

    final selected = useState('');

    return Scaffold(
      body: WalletViewWidget(
        appBar: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
          child: Column(
            children: [
              Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
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
                        '\$ 2,400.00',
                        style: AppText.header1(context, Colors.white, 25.sp),
                      ),
                      Space(10.h),
                      Text(
                        'Available Balance',
                        style: AppText.body2(context, Colors.white, 16.sp),
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
              Space(40.h),
              Text(
                'Withdraw Money',
                style: AppText.body2(context, Colors.white, 25.sp),
              ),
              // const WalletOptionList()
            ],
          ),
        ),
        child: SizedBox(
          height: 700.h,
          child: Padding(
            padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 20.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Space(30.h),

                  Text(
                    'Enter an amount',
                    style: AppText.body2(context, AppColors.appColor, 19.sp),
                  ),
                  Space(5.h),
                  const WalletTextField(
                    keyboardType: TextInputType.number,
                    labelText: 'Click to type',
                    obscureText: false,
                    color: Colors.white,
                  ),
                  Space(25.h),
                  Text(
                    'Select a transfer method',
                    style: AppText.body2(context, AppColors.appColor, 19.sp),
                  ),

                  ///
                  ///
                  ///select transfer method
                  ///
                  ///
                  ///
                  Space(5.h),

                  SelectFormField(
                    type: SelectFormFieldType.dropdown, // or can be dialog
                    // initialValue: selectedItem,

                    style: AppText.body2(context, AppColors.appColor, 19.sp),
                    decoration: InputDecoration(
                      hintText: 'click to choose transfer method',
                      hintStyle:
                          AppText.body2(context, Colors.grey[400]!, 19.sp),
                      // floatingLabelBehavior: FloatingLabelBehavior.never,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0.h, horizontal: 10.w),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.appColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppColors.appColor, width: 1),
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
                    items: _transfer,
                    onChanged: (val) {
                      selected.value = val;
                    },
                    onSaved: (val) => print(val),
                  ),
                  if (selected.value == 'Swift code/BIC') ...[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Space(25.h),
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
                      ],
                    ),
                  ],

                  ///
                  ///
                  ///select wallet to withdraw from
                  ///
                  ///
                  ///

                  Space(25.h),
                  Text(
                    'Select a wallet to withdraw from',
                    style: AppText.body2(context, AppColors.appColor, 19.sp),
                  ),
                  Space(5.h),
                  SelectFormField(
                    type: SelectFormFieldType.dropdown, // or can be dialog
                    // initialValue: selectedItem,

                    style: AppText.body2(context, AppColors.appColor, 19.sp),
                    decoration: InputDecoration(
                      hintText: 'Click to choose wallet',
                      hintStyle:
                          AppText.body2(context, Colors.grey[400]!, 19.sp),
                      // floatingLabelBehavior: FloatingLabelBehavior.never,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0.h, horizontal: 10.w),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.appColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppColors.appColor, width: 1),
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
                    items: _wallet,
                    onChanged: (val) => print(val),
                    onSaved: (val) => print(val),
                  ),
                  Space(25.h),

                  ///
                  ///
                  ///
                  /// Safe Transfer Selection
                  ///
                  ///
                  ///
                  if (selected.value == 'Safe transfer') ...[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Enter Kayndrexsphere account number of recipient',
                          style:
                              AppText.body2(context, AppColors.appColor, 19.sp),
                        ),
                        Space(5.h),
                        const WalletTextField(
                          keyboardType: TextInputType.number,
                          labelText: 'Click to type',
                          obscureText: false,
                          color: Colors.white,
                        ),
                        Space(25.h),
                      ],
                    )

                    ///
                    ///
                    ///
                    /// ABA number Selection
                    ///
                    ///
                    ///
                  ] else if (selected.value == 'ABA number') ...[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Enter ABA amount',
                          style:
                              AppText.body2(context, AppColors.appColor, 19.sp),
                        ),
                        Space(5.h),
                        const WalletTextField(
                          keyboardType: TextInputType.number,
                          labelText: 'Click to type',
                          obscureText: false,
                          color: Colors.white,
                        ),
                        Space(25.h),
                        Text(
                          'Enter account name',
                          style:
                              AppText.body2(context, AppColors.appColor, 19.sp),
                        ),
                        Space(5.h),
                        const WalletTextField(
                          keyboardType: TextInputType.name,
                          labelText: '',
                          obscureText: false,
                          color: Colors.white,
                        ),
                        Space(25.h),
                        Text(
                          'Enter account number',
                          style:
                              AppText.body2(context, AppColors.appColor, 19.sp),
                        ),
                        Space(5.h),
                        const WalletTextField(
                          keyboardType: TextInputType.number,
                          labelText: '',
                          obscureText: false,
                          color: Colors.white,
                        ),
                        Space(25.h),
                        Text(
                          'Enter country you are sending to',
                          style:
                              AppText.body2(context, AppColors.appColor, 19.sp),
                        ),
                        Space(5.h),
                        const WalletTextField(
                          keyboardType: TextInputType.name,
                          labelText: '',
                          obscureText: false,
                          color: Colors.white,
                        ),
                        Space(25.h),
                        Text(
                          'Enter Swift code',
                          style:
                              AppText.body2(context, AppColors.appColor, 19.sp),
                        ),
                        Space(5.h),
                        const WalletTextField(
                          keyboardType: TextInputType.number,
                          labelText: '',
                          obscureText: false,
                          color: Colors.white,
                        ),
                        Space(25.h),
                      ],
                    )
                  ]

                  ///
                  ///
                  ///
                  /// Swift code/BIC Selection
                  ///
                  ///
                  ///
                  else if (selected.value == 'Swift code/BIC') ...[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        selection.state == 'IBAN'
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Enter IBAN number',
                                    style: AppText.body2(
                                        context, AppColors.appColor, 19.sp),
                                  ),
                                  Space(5.h),
                                  const WalletTextField(
                                    keyboardType: TextInputType.number,
                                    labelText: 'Click to type',
                                    obscureText: false,
                                    color: Colors.white,
                                  ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Enter SEPA number',
                                    style: AppText.body2(
                                        context, AppColors.appColor, 19.sp),
                                  ),
                                  Space(5.h),
                                  const WalletTextField(
                                    keyboardType: TextInputType.number,
                                    labelText: 'Click to type',
                                    obscureText: false,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                        Space(25.h),
                        Text(
                          'Enter account name',
                          style:
                              AppText.body2(context, AppColors.appColor, 19.sp),
                        ),
                        Space(5.h),
                        const WalletTextField(
                          keyboardType: TextInputType.name,
                          labelText: '',
                          obscureText: false,
                          color: Colors.white,
                        ),
                        Space(25.h),
                        Text(
                          'Enter account number',
                          style:
                              AppText.body2(context, AppColors.appColor, 19.sp),
                        ),
                        Space(5.h),
                        const WalletTextField(
                          keyboardType: TextInputType.number,
                          labelText: '',
                          obscureText: false,
                          color: Colors.white,
                        ),
                        Space(25.h),
                        Text(
                          'Enter country you are sending to',
                          style:
                              AppText.body2(context, AppColors.appColor, 19.sp),
                        ),
                        Space(5.h),
                        const WalletTextField(
                          keyboardType: TextInputType.name,
                          labelText: '',
                          obscureText: false,
                          color: Colors.white,
                        ),
                        Space(25.h),
                        Text(
                          'Enter Swift code',
                          style:
                              AppText.body2(context, AppColors.appColor, 19.sp),
                        ),
                        Space(5.h),
                        const WalletTextField(
                          keyboardType: TextInputType.number,
                          labelText: '',
                          obscureText: false,
                          color: Colors.white,
                        ),
                        Space(25.h),
                      ],
                    )
                  ]

                  ///
                  ///
                  /// NUBAN Selection
                  ///
                  ///
                  else if (selected.value == 'NUBAN') ...[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Enter NUBAN number',
                          style:
                              AppText.body2(context, AppColors.appColor, 19.sp),
                        ),
                        Space(5.h),
                        const WalletTextField(
                          keyboardType: TextInputType.number,
                          labelText: 'Click to type',
                          obscureText: false,
                          color: Colors.white,
                        ),
                        Space(10.h),
                        Text(
                          'GTBank John Doe',
                          style:
                              AppText.body2(context, Colors.greenAccent, 17.sp),
                        ),
                        Space(20.h),
                        Text(
                          'Enter account name',
                          style:
                              AppText.body2(context, AppColors.appColor, 19.sp),
                        ),
                        Space(5.h),
                        const WalletTextField(
                          keyboardType: TextInputType.name,
                          labelText: '',
                          obscureText: false,
                          color: Colors.white,
                        ),
                        Space(25.h),
                      ],
                    )
                  ],

                  Center(
                    child: Text(
                      'Enter password',
                      style:
                          AppText.header3(context, AppColors.appColor, 20.sp),
                    ),
                  ),
                  Space(5.h),
                  Center(
                    child: Text(
                      'For security reasons, please enter your password',
                      style: AppText.body2(context, AppColors.appColor, 18.sp),
                    ),
                  ),
                  Space(5.h),
                  WalletTextField(
                    labelText: '',
                    obscureText: true,
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
                      buttonText: 'Withdraw to Bank',
                      bgColor: AppColors.appColor,
                      borderColor: AppColors.appColor,
                      textColor: Colors.white,
                      onPressed: () {
                        WalletDialog.transactionDialog(context,
                            transfered: "€ 400.00",
                            details: 'Dollar wallet to Euro wallet',
                            received: '£ 300.00');
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
                  Space(100.h),
                ],
              ),
            ),
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
