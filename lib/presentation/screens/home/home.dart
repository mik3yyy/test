import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/set_default_as_wallet_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/wallet_transactions.dart';
import 'package:kayndrexsphere_mobile/presentation/components/AppSnackBar/snackbar/app_snackbar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/extension/string_extension.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/widgets/user_wallets.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/uplload_profileimage.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/transactions/view_all_transaction_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/account/available_wallet.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/add-fund-to-wallet/add_funds_to_wallet_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/refreshToken/refresh_token_controller.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/vm/sign_in_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/currency_transactions_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/set_wallet_as_default_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/wallet_transactions.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_view_widget.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/withdrawal_method.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../components/app image/app_image.dart';
import '../../components/app text theme/app_text_theme.dart';
import '../settings/profile/vm/get_profile_vm.dart';
import '../wallet/transfer/transfer.dart';
import 'widgets/bottomNav/persistent-tab-view.dart';

class HomePage extends StatefulHookConsumerWidget {
  final BuildContext menuScreenContext;
  final Function onScreenHideButtonPressed;
  final bool hideStatus;
  const HomePage(
      {Key? key,
      required this.menuScreenContext,
      required this.onScreenHideButtonPressed,
      required this.hideStatus})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final toggleAmountProvider = StateProvider<bool>((ref) => true);
  final currency = [
    "Dollar",
    "Pounds",
    "Euro",
    "Naira",
  ];

  String setValue = 'Dollar';

  @override
  void initState() {
    super.initState();

    ref.read(refreshControllerProvider.notifier).refreshToken();

    // ref.read(genericController.notifier).getAbaBeneficiaries();
    // ref.read(genericController.notifier).getIbanBeneficiaries();
    // ref.read(genericController.notifier).getNotification();
    // ref.read(genericController.notifier).withdrawalNotificationRequest();
  }

  @override
  Widget build(BuildContext context) {
    final toggleAmount = ref.watch(toggleAmountProvider.state);
    final accountNo = ref.watch(signInProvider);
    final transactions = ref.watch(walletTransactionProvider);
    final defaultWallet = ref.watch(userProfileProvider);
    // final wallet = ref.watch(getAccountDetailsProvider);
    var formatter = NumberFormat("#,##0.00");
    final currency = useTextEditingController();
    final newUser = PreferenceManager.isFirstLaunch;

    ref.listen<RequestState>(setWalletAsDefaultProvider, (prev, value) {
      if (value is Success<SetWalletAsDefaultRes>) {
        ref.refresh(userProfileProvider);

        ref.refresh(currencyTransactionProvider(
            value.value!.data!.wallet!.currencyCode!));
      }

      if (value is Error) {
        AppSnackBar.showSuccessSnackBar(context,
            message: "Wallet could not be set as default at the moment");
      }
    });

    return GenericWidget(
      appbar: Padding(
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
        ),
        child: Column(
          children: [
            Space(20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Hi ${accountNo.maybeMap(success: (v) => v.value!.data!.user.firstName.capitalize(), orElse: () => '')}',
                      style: AppText.header1(context, Colors.white, 25.sp),
                    ),
                    Space(10.h),
                    newUser
                        ? Text(
                            'Thanks for signing up with us',
                            style: AppText.body2(context, Colors.white, 18.sp),
                          )
                        : const SizedBox.shrink()
                  ],
                ),
                const Spacer(),
                const SizedBox(
                  height: 60,
                  width: 60,
                  child: UploadImage(
                    hasIcon: false,
                  ),
                ),
                Space(10.w),
              ],
            ),
            Space(30.h),
            Container(
              height: 150.h,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: AppColors.bottomSheet,
              ),
              child: Column(
                children: [
                  const Space(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      defaultWallet.maybeWhen(data: (data) {
                        return Text(
                          '${currencyName(data.data.defaultWallet.currencyCode.toString())} wallet',
                          style: AppText.header2(
                              context, AppColors.appColor, 18.sp),
                        );
                      }, orElse: () {
                        return Text(
                          '-----',
                          style: AppText.header2(
                              context, AppColors.appColor, 18.sp),
                        );
                      }),
                      SelectWalletList(
                        currency: currency,
                        routeName: "homeScreen",
                      ),
                      Space(85.w),
                      InkWell(
                        onTap: () {
                          toggleAmount.state = !toggleAmount.state;
                          PreferenceManager.revealBalance = toggleAmount.state;
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Icon(
                            PreferenceManager.revealBalance
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: PreferenceManager.revealBalance
                                ? AppColors.appColor
                                : Colors.grey.shade400,
                            size: 20,
                          ),
                        ),
                      ),
                      Space(20.w)
                    ],
                  ),
                  const Space(15),
                  PreferenceManager.revealBalance
                      ? Text(
                          '****',
                          style: AppText.header1(
                              context, AppColors.appColor, 40.sp),
                        )
                      : Text(
                          defaultWallet.maybeWhen(
                              data: (v) =>
                                  '${currencySymbol(v.data.defaultWallet.currencyCode.toString())} ${formatter.format(v.data.defaultWallet.balance)}',
                              orElse: () => '----'),
                          style: AppText.header1(
                              context, AppColors.appColor, 40.sp),
                        ),
                  Space(8.h),
                  Text(
                    'Kayndrexsphere Account Number: ${accountNo.maybeWhen(success: (v) => v!.data!.user.accountNumber, orElse: () => '')}',
                    style: AppText.body2(context, AppColors.appColor, 17.sp),
                  ),
                ],
              ),
            )
            // Space(30.h),
            // const WalletOptionList()
          ],
        ),
      ),
      bgColor: const Color(
        0xfff9f9f9,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.65,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 0.w, right: 0.w, top: 0.h),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 10, top: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(45.r)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset:
                            const Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MenuCards(
                            title: 'Transfer',
                            image: AppImage.transfer,
                            firstColor: AppColors.appColor.withOpacity(0.65),
                            secondColor: AppColors.appColor,
                            onPressed: () {
                              pushNewScreen(
                                context,
                                screen: const Transfer(),
                                withNavBar:
                                    false, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation:
                                    PageTransitionAnimation.fade,
                              );
                            },
                          ),
                          MenuCards(
                            title: 'Add funds',
                            image: AppImage.addFunds,
                            firstColor:
                                const Color(0xff00848C).withOpacity(0.6),
                            secondColor: const Color(0xff00404E),
                            onPressed: () {
                              pushNewScreen(
                                context,
                                screen: AddFundsToWalletScreen(
                                  menuScreenContext: widget.menuScreenContext,
                                  hideStatus: widget.hideStatus,
                                  onScreenHideButtonPressed: () {
                                    setState(() {
                                      // widget.hideStatus = !_hideNavBar;
                                    });
                                  },
                                  route: "HomeScreen",
                                ),
                                withNavBar:
                                    true, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation:
                                    PageTransitionAnimation.fade,
                              );
                            },
                          ),
                          MenuCards(
                            title: 'Withdraw',
                            image: AppImage.withdraw,
                            firstColor:
                                const Color(0xff1E6342).withOpacity(0.6),
                            secondColor: const Color(0xff00351C),
                            onPressed: () {
                              pushNewScreen(
                                context, screen: const WithdrawalMethodScreen(),
                                withNavBar:
                                    false, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation:
                                    PageTransitionAnimation.fade,
                              );
                            },
                          ),
                        ],
                      ),
                      Space(30.w),
                      SizedBox(
                        width: 370.w,
                        child: Row(
                          children: [
                            Text(
                              'Transactions',
                              style: AppText.body2Bold(
                                  context, Colors.black26, 21.sp),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                // context
                                //     .navigate(const ViewAllTransactionScreen());
                                pushNewScreen(
                                  context,
                                  screen: const ViewAllTransactionScreen(),
                                  withNavBar:
                                      false, // OPTIONAL VALUE. True by default.
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.fade,
                                );
                              },
                              child: Text(
                                'View all',
                                style: AppText.body2Bold(
                                    context, Colors.black54, 21.sp),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Space(30.h),
                transactions.when(
                    error: (error, stackTrace) => Text(error.toString()),
                    idle: () => const Center(
                          child: CircularProgressIndicator.adaptive(
                            strokeWidth: 5,
                          ),
                        ),
                    loading: () => Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.1,
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.3),
                          child: const CircularProgressIndicator.adaptive(
                            strokeWidth: 5,
                          ),
                        ),
                    success: (data) {
                      if (data!.data!.transactions.isEmpty) {
                        return const Center(
                          child: Text("You have no transactions"),
                        );
                      } else {
                        return RefreshIndicator(
                          onRefresh: () async {
                            ref.refresh(walletTransactionProvider);
                          },
                          child: SizedBox(
                            height: 300.h,
                            child: ListView.separated(
                              physics: const AlwaysScrollableScrollPhysics(
                                  parent: BouncingScrollPhysics()),
                              itemCount: data.data!.transactions.length < 5
                                  ? data.data!.transactions.length
                                  : 5,
                              // itemCount: data.data!.transactions.length,
                              itemBuilder: (context, index) {
                                final transactions =
                                    data.data!.transactions[index];
                                return TransactionBuild(
                                  transactions: transactions,
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(height: 20.h);
                              },
                            ),
                          ),
                        );
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildItem(String currencyValue) {
    return DropdownMenuItem(
        value: currencyValue,
        child: Text(
          currencyValue,
          style: AppText.body2Bold(context, AppColors.appColor, 19.sp),
        ));
  }
}

class MenuCards extends StatelessWidget {
  final String title;
  final String image;
  final Color firstColor;
  final Color secondColor;

  final void Function()? onPressed;
  const MenuCards(
      {Key? key,
      required this.title,
      required this.image,
      required this.firstColor,
      required this.secondColor,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 120.h,
        width: 110.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          // color: AppColors.appColor,
          gradient: RadialGradient(
            colors: [firstColor, secondColor],
            radius: 0.75,
            focal: Alignment.topLeft,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Space(5.h),
            SvgPicture.asset(
              image,
              color: Colors.white,
              height: 30.h,
              width: 30.w,
            ),
            Space(25.h),
            Text(
              title,
              style: AppText.header2(context, Colors.white, 15.sp),
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionBuild extends StatelessWidget {
  final Transaction transactions;
  const TransactionBuild({Key? key, required this.transactions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime date = transactions.createdAt!;
    String dateCreated = DateFormat(' d, MMM yyyy').format(date);
    var formatter = NumberFormat("#,##0.00");
    String currencyCode() {
      if (transactions.currencyCode == CurrencyCode.eur) {
        return "EUR";
      }
      if (transactions.currencyCode == CurrencyCode.gbp) {
        return "GBP";
      }
      if (transactions.currencyCode == CurrencyCode.ngn) {
        return "NGN";
      }
      if (transactions.currencyCode == CurrencyCode.usd) {
        return "USD";
      } else {
        return '';
      }
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 60.h,
            width: 60.w,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Colors.orange.withOpacity(0.3)),
            child: Center(
              child: SvgPicture.asset(
                AppImage.transferIcon,
                height: 20.h,
                width: 20.w,
              ),
            ),
          ),
          Space(10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (transactions.direction == Direction.debit) ...[
                  Row(
                    children: [
                      Text(
                        'Debit',
                        style: AppText.body2(context, Colors.red, 18.sp),
                      ),
                      const Spacer(),
                      Text(
                        "${currencyCode()} ${formatter.format(transactions.amount)}",
                        style: AppText.body2(context, Colors.red, 18.sp),
                      ),
                    ],
                  ),
                ] else ...[
                  Row(
                    children: [
                      Text(
                        "Credit",
                        style: AppText.body2(context, Colors.green, 18.sp),
                      ),
                      const Spacer(),
                      Text(
                        "${currencyCode()} ${formatter.format(transactions.amount)}",
                        style: AppText.body2(context, Colors.green, 18.sp),
                      ),
                    ],
                  ),
                ],
                Space(10.h),
                Row(
                  children: [
                    Text(
                      transactions.user!.firstName.toString(),
                      style: AppText.body2(context, Colors.black, 18.sp),
                    ),
                    const Spacer(),
                    Text(
                      dateCreated,
                      style: AppText.body2(context, Colors.black, 18.sp),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
