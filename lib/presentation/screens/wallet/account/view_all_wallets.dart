import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/create_wallet_res.dart';
import 'package:kayndrexsphere_mobile/presentation/components/AppSnackBar/snackbar/app_snackbar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/create_wallet_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../components/app text theme/app_text_theme.dart';
import '../vm/get_account_details_vm.dart';
import '../withdrawal/widget/withdrawal_method_widget.dart';

class SelectWalletToCreate extends StatefulHookConsumerWidget {
  const SelectWalletToCreate({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectWalletToCreateState();
}

final List<AllWallets> _allWalletList = [
  AllWallets(currencyName: 'Dollar Wallet', currencyCode: 'USD'),
  AllWallets(currencyName: 'Pound Wallet', currencyCode: 'GBP'),
  AllWallets(currencyName: 'Euro Wallet', currencyCode: 'EUR'),
  AllWallets(currencyName: 'Naira Wallet', currencyCode: 'NGN'),
];

class _SelectWalletToCreateState extends ConsumerState<SelectWalletToCreate> {
  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(createWalletProvider);
    String currencyCode = '';

    ref.listen<RequestState>(createWalletProvider, (T, value) {
      if (value is Success<CreateWalletRes>) {
        context.loaderOverlay.hide();
        ref.refresh(getAccountDetailsProvider);
        //TODO: popview is not working, navigating back to previous screen
        // context.popView();
        // pushNewScreen(
        //   //TODO: To replace with add fund screen, when add fund screen is merged
        //   // context, screen: const AvailableWallet(),
        //   context, screen: const ABAWithdrawal(),
        //   withNavBar: true, // OPTIONAL VALUE. True by default.
        //   pageTransitionAnimation: PageTransitionAnimation.fade,
        // );
        return AppSnackBar.showErrorSnackBar(context,
            message: value.value!.message.toString());
      }
      if (value is Error) {
        context.loaderOverlay.hide();
        return AppSnackBar.showErrorSnackBar(context,
            message: value.error.toString());
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
        backgroundColor: AppColors.appBgColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Create Wallet',
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
          child: Column(
            children: [
              Container(
                height: 40.h,
                width: MediaQuery.of(context).size.width,
                color: AppColors.appColor.withOpacity(0.1),
                child: Padding(
                  padding: EdgeInsets.only(right: 210.w),
                  child: Center(
                    child: Text(
                      'Select wallet to create',
                      style: AppText.body2(context, Colors.black54, 20.sp),
                    ),
                  ),
                ),
              ),
              Space(20.h),
              ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.only(right: 20.w, left: 20.w),
                itemCount: _allWalletList.length,
                itemBuilder: (context, index) {
                  final item = _allWalletList[index];
                  return WithdrawMethod(
                      method: item.currencyName,
                      onPressed: vm is Loading
                          ? null
                          : () {
                              setState(() {
                                currencyCode = item.currencyCode;
                              });
                              ref
                                  .read(createWalletProvider.notifier)
                                  .createWallet(currencyCode);
                              context.loaderOverlay.show();
                            });
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 20.h,
                  );
                },
              ),
              // Padding(
              //   padding: EdgeInsets.only(right: 20.w, left: 20.w),
              //   child:

              //   Column(
              //     children: [
              // WithdrawMethod(
              //     method: "Dollar wallet",
              //     onPressed: () {
              //       pushNewScreen(
              //         context, screen: const AvailableWallet(),
              //         withNavBar: true, // OPTIONAL VALUE. True by default.
              //         pageTransitionAnimation: PageTransitionAnimation.fade,
              //       );
              //     }),
              //       Space(20.h),
              //       WithdrawMethod(
              //           method: "Pound wallet",
              //           onPressed: () {
              //             pushNewScreen(
              //               context, screen: const ABAWithdrawal(),
              //               withNavBar: true, // OPTIONAL VALUE. True by default.
              //               pageTransitionAnimation: PageTransitionAnimation.fade,
              //             );
              //           }),
              //       Space(20.h),
              //       WithdrawMethod(
              //           method: "Euro wallet",
              //           onPressed: () {
              //             pushNewScreen(
              //               context, screen: const NubanWithdraw(),
              //               withNavBar: true, // OPTIONAL VALUE. True by default.
              //               pageTransitionAnimation: PageTransitionAnimation.fade,
              //             );
              //           }),
              //       Space(20.h),
              //       WithdrawMethod(
              //           method: "Naira wallet",
              //           onPressed: () {
              //             pushNewScreen(
              //               context, screen: const SwiftCodeView(),
              //               withNavBar: true, // OPTIONAL VALUE. True by default.
              //               pageTransitionAnimation: PageTransitionAnimation.fade,
              //             );
              //           }),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class AllWallets {
  final String currencyName;
  final String currencyCode;

  AllWallets({required this.currencyName, required this.currencyCode});
}
