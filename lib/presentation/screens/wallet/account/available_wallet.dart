import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/set_default_as_wallet_res.dart';
import 'package:kayndrexsphere_mobile/presentation/components/AppSnackBar/snackbar/app_snackbar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/extension/format_currency.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent-tab-view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/get_profile_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/account/view_all_wallets.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/get_account_details_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/set_wallet_as_default_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../components/app text theme/app_text_theme.dart';

class AvailableWallet extends StatefulHookConsumerWidget {
  final BuildContext menuScreenContext;
  final Function onScreenHideButtonPressed;
  final bool hideStatus;
  const AvailableWallet(
      {Key? key,
      required this.menuScreenContext,
      required this.onScreenHideButtonPressed,
      required this.hideStatus})
      : super(key: key);

  @override
  ConsumerState<AvailableWallet> createState() => _AvailableWalletState();
}

currencySymbol(String currency) {
  if (currency == "NGN") {
    return 'N';
  } else if (currency == "USD") {
    return '\$';
  } else if (currency == "GBP") {
    return '£';
  } else if (currency == "EUR") {
    return '£';
  } else {
    return 'KDRX';
  }
}

currencyName(String currency) {
  if (currency == "NGN") {
    return 'Naira';
  } else if (currency == "USD") {
    return 'Dollar';
  } else if (currency == "GBP") {
    return 'Pounds';
  } else if (currency == "EUR") {
    return 'Euro';
  } else {
    return 'KDRX';
  }
}

class _AvailableWalletState extends ConsumerState<AvailableWallet> {
  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(getProfileProvider);
    final wallet = ref.watch(getAccountDetailsProvider);
    final walletCount = useState(0);

    ref.listen<RequestState>(setWalletAsDefaultProvider, (prev, value) {
      if (value is Success<SetWalletAsDefaultRes>) {
        context.loaderOverlay.hide();
      }

      if (value is Error) {
        context.loaderOverlay.hide();
        AppSnackBar.showSuccessSnackBar(context,
            message: "Wallet could not be set as default at the moment");
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
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Currency Wallets',
            style: AppText.header2(context, Colors.black, 20.sp),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 40.h,
              width: MediaQuery.of(context).size.width,
              color: AppColors.appColor.withOpacity(0.1),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 7.5, horizontal: 20),
                child: Text(
                  'Let\'s view your currency accounts',
                  style: AppText.body2Medium(context, Colors.black54, 20.sp),
                ),
              ),
            ),
            const Space(20),
            Padding(
              padding: EdgeInsets.only(left: 23.w, right: 23.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Default wallet',
                    style: AppText.header2(context, AppColors.appColor, 20.sp),
                  ),
                  const Space(10),
                  vm.when(
                      success: (data) {
                        return Container(
                          height: 80.h,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(left: 20.w, right: 20.w),
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(5.r),
                            // border: Border.all(
                            //     width: 1, color: AppColors.appColor),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                offset: Offset(
                                  2.0,
                                  2.0,
                                ),
                                blurRadius: 0.0,
                                spreadRadius: 2.0,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${currencyName(data!.data.defaultWallet.currencyCode.toString())} wallet',
                                    style: AppText.header2(
                                        context, AppColors.appColor, 18.sp),
                                  ),
                                  Space(10.h),
                                  Text(
                                    '${currencySymbol(data.data.defaultWallet.currencyCode.toString())} ${formatCurrency(data.data.defaultWallet.balance.toString())}',
                                    style: AppText.header2(
                                        context, AppColors.appColor, 20.sp),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              OptionsModalSheet(
                                currencyCode: data
                                    .data.defaultWallet.currencyCode
                                    .toString(),
                                isDefault: true,
                              )
                            ],
                          ),
                        );
                      },
                      loading: () => SizedBox(
                          height: 25.w,
                          width: 25.w,
                          child: const CircularProgressIndicator.adaptive()),
                      idle: () => SizedBox(
                          height: 25.w,
                          width: 25.w,
                          child: const CircularProgressIndicator.adaptive()),
                      error: (Object error, StackTrace stackTrace) {
                        print(error);
                        return Text(
                          error.toString(),
                          style: AppText.header2(
                              context, AppColors.appColor, 20.sp),
                        );
                      }),
                  const Space(20),
                  Text(
                    'Other wallets',
                    style: AppText.header2(context, AppColors.appColor, 20.sp),
                  ),

                  ///
                  ///
                  /// LIST OF CREATED WALLETS
                  ///
                  const Space(10),
                  wallet.when(
                      error: (error, stackTrace) => Text(error.toString()),
                      loading: () => const CircularProgressIndicator.adaptive(),
                      idle: () => const CircularProgressIndicator.adaptive(),
                      success: (data) {
                        walletCount.value = data!.data!.wallets!.length;
                        return SizedBox(
                          height: 400,
                          child: ListView.separated(
                            itemCount: data.data!.wallets!.length,
                            itemBuilder: (context, index) {
                              final walletList = data.data!.wallets![index];
                              return Container(
                                height: 80.h,
                                width: MediaQuery.of(context).size.width,
                                padding:
                                    EdgeInsets.only(left: 20.w, right: 20.w),
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(5.r),
                                  // border: Border.all(
                                  //     width: 1, color: AppColors.appColor),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                      offset: Offset(
                                        2.0,
                                        2.0,
                                      ),
                                      blurRadius: 0.0,
                                      spreadRadius: 2.0,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${currencyName(walletList.currencyCode.toString())} wallet',
                                          style: AppText.header2(context,
                                              AppColors.appColor, 18.sp),
                                        ),
                                        Space(10.h),
                                        Text(
                                          '${currencySymbol(walletList.currencyCode.toString())} ${formatCurrency(walletList.balance.toString())}',
                                          style: AppText.header2(context,
                                              AppColors.appColor, 20.sp),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    OptionsModalSheet(
                                      currencyCode:
                                          walletList.currencyCode.toString(),
                                      isDefault: false,
                                    )
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 10,
                              );
                            },
                          ),
                        );
                      }),
                  walletCount.value == 5
                      ? const SizedBox.shrink()
                      : CustomButton(
                          buttonText: 'Create Wallet',
                          bgColor: AppColors.appColor,
                          borderColor: AppColors.appColor,
                          textColor: Colors.white,
                          onPressed: () {
                            pushNewScreen(
                              context,
                              screen: const SelectWalletToCreate(),
                              withNavBar:
                                  true, // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation:
                                  PageTransitionAnimation.fade,
                            );
                            // context.navigate(AvailableBalance()

                            // );
                          },
                          buttonWidth: 320),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OptionsModalSheet extends StatefulHookConsumerWidget {
  final String currencyCode;
  final bool isDefault;
  const OptionsModalSheet(
      {Key? key, required this.currencyCode, required this.isDefault})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OptionsModalSheetState();
}

class _OptionsModalSheetState extends ConsumerState<OptionsModalSheet> {
  @override
  Widget build(BuildContext context) {
    ref.listen<RequestState>(setWalletAsDefaultProvider, (prev, value) {
      if (value is Success<SetWalletAsDefaultRes>) {
        ref.read(getProfileProvider.notifier).getProfile();
        context.loaderOverlay.hide();

        AppSnackBar.showSuccessSnackBar(context,
            message:
                "${value.value!.data!.wallet!.currencyCode} is set to default");
      }
    });

    return GestureDetector(
      onTap: () {
        showCupertinoModalPopup(
            context: context,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(left: 25.w, right: 25.w),
                child: CupertinoActionSheet(
                  actions: [
                    //WalletName
                    Container(
                      color: Colors.white,
                      child: CupertinoActionSheetAction(
                        child: Padding(
                          padding: EdgeInsets.only(left: 30.w, right: 30.w),
                          child: Text(
                            //TODO: To convert the symbol to name E.G NGN = Naira
                            '${widget.currencyCode} wallet',
                            style: AppText.body5(
                              context,
                              AppColors.textColor.withOpacity(0.67),
                              16.sp,
                            ),
                          ),
                        ),
                        isDefaultAction: true,
                        onPressed: () {
                          // currencyController.text = dollar;
                          // Navigator.pop(context);
                        },
                      ),
                    ),
                    //View Wallet
                    Container(
                      color: Colors.white,
                      child: CupertinoActionSheetAction(
                        child: Padding(
                          padding: EdgeInsets.only(left: 30.w, right: 30.w),
                          child: Text(
                            //TODO: To change the font when add_fund_ui is merged
                            'view wallet',
                            style: AppText.body5(
                              context,
                              AppColors.textColor,
                              16.sp,
                            ),
                          ),
                        ),
                        isDefaultAction: true,
                        onPressed: () {
                          // currencyController.text = dollar;
                          // Navigator.pop(context);
                        },
                      ),
                    ),
                    //Transfer to another wallet
                    Container(
                      color: Colors.white,
                      child: CupertinoActionSheetAction(
                        child: Padding(
                          padding: EdgeInsets.only(left: 30.w, right: 30.w),
                          child: Text(
                            'Transfer to another wallet',
                            style: AppText.body5(
                              context,
                              AppColors.textColor,
                              16.sp,
                            ),
                          ),
                        ),
                        isDefaultAction: true,
                        onPressed: () {
                          // currencyController.text = dollar;
                          // Navigator.pop(context);
                        },
                      ),
                    ),
                    //Make wallet default
                    widget.isDefault
                        ? const SizedBox.shrink()
                        : Container(
                            color: Colors.white,
                            child: CupertinoActionSheetAction(
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: 30.w, right: 30.w),
                                child: Text(
                                  //TODO: To change the font when add_fund_ui is merged
                                  'Make wallet default',
                                  style: AppText.body5(
                                    context,
                                    AppColors.textColor,
                                    16.sp,
                                  ),
                                ),
                              ),
                              isDefaultAction: true,
                              onPressed: () {
                                context.loaderOverlay.show();
                                ref
                                    .read(setWalletAsDefaultProvider.notifier)
                                    .setWalletAsDefault(widget.currencyCode);
                                Navigator.pop(context);

                                // currencyController.text = dollar;
                                // Navigator.pop(context);
                              },
                            ),
                          ),
                    //Remove wallet
                    Container(
                      color: Colors.white,
                      child: CupertinoActionSheetAction(
                        child: Padding(
                          padding: EdgeInsets.only(left: 30.w, right: 30.w),
                          child: Text(
                            'Remove Wallet',
                            style: AppText.body5(
                              context,
                              AppColors.textColor,
                              16.sp,
                            ),
                          ),
                        ),
                        isDefaultAction: true,
                        onPressed: () {
                          // currencyController.text = dollar;
                          // Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                  cancelButton: CupertinoActionSheetAction(
                    child: Text(
                      "Close",
                      style: AppText.body5(
                        context,
                        AppColors.textColor,
                        16.sp,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            });
      },
      child: SizedBox(
        child: Row(
          children: const [
            Icon(
              Icons.circle_outlined,
              color: Colors.black,
              size: 6,
            ),
            Space(3),
            Icon(
              Icons.circle_outlined,
              color: Colors.black,
              size: 6,
            ),
            Space(3),
            Icon(
              Icons.circle_outlined,
              color: Colors.black,
              size: 6,
            ),
          ],
        ),
      ),
    );
  }
}
