import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/set_default_as_wallet_res.dart';
import 'package:kayndrexsphere_mobile/presentation/components/AppSnackBar/snackbar/app_snackbar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/extension/format_currency.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/home.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent_tab_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/user_profile/user_profile_db.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/get_profile_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/add-fund-to-wallet/currency_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/get_account_details_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/set_wallet_as_default_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:skeletons/skeletons.dart';
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

class _AvailableWalletState extends ConsumerState<AvailableWallet>
    with WidgetsBindingObserver {
  bool isBackground = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    setState(() {
      isBackground = state == AppLifecycleState.inactive;
    });

    // final isBackground = state == AppLifecycleState.inactive;

    if (isBackground) {}

    /* if (isBackground) {
      // service.stop();
    } else {
      // service.start();
    }*/
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(userProfileProvider);
    final wallet = ref.watch(getAccountDetailsProvider);
    final savedUser = ref.watch(savedUserProvider);
    final walletCount = useState(0);
    var formatter = NumberFormat("#,##0.00");
    final currency = useTextEditingController();

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
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          backgroundColor: Colors.transparent,
          title: Text(
            'Wallets',
            style: AppText.header2(context, Colors.black, 20.sp),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        body: isBackground
            ? Container()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InnerPageLoadingIndicator(loadingStream: wallet.isRefreshing),
                  Container(
                    height: 40.h,
                    width: MediaQuery.of(context).size.width,
                    color: AppColors.appColor.withOpacity(0.1),
                    child: Center(
                      child: Text(
                        'Let\'s view your currency wallets',
                        style:
                            AppText.body2Medium(context, Colors.black54, 20.sp),
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
                          style: AppText.header2(
                              context, AppColors.appColor, 20.sp),
                        ),
                        const Space(10),
                        vm.maybeWhen(data: (data) {
                          return WalletCardView(
                              currencyCode:
                                  '${data.data.defaultWallet.currencyCode.toString()} wallet',
                              amount:
                                  '${data.data.defaultWallet.currencyCode.toString()} ${formatCurrency(data.data.defaultWallet.balance.toString())}');
                        },
                            // loading: () => SizedBox(
                            //     height: 20.w,
                            //     width: 20.w,
                            //     child: const CircularProgressIndicator()),
                            // error: (e, s) {
                            //   return Text(
                            //     e.toString(),
                            //     style: AppText.header2(
                            //         context, AppColors.appColor, 20.sp),
                            //   );
                            // },
                            orElse: () {
                          return WalletCardView(
                              currencyCode: '${savedUser.countryCode} wallet',
                              amount:
                                  '${savedUser.countryCode} ${formatCurrency(savedUser.balance.toString())}');
                        }),
                        const Space(20),
                        Text(
                          'Other wallets',
                          style: AppText.header2(
                              context, AppColors.appColor, 20.sp),
                        ),

                        ///
                        ///
                        /// LIST OF CREATED WALLETS
                        ///
                        const Space(10),
                        wallet.when(

                            /// CHECK FOR HERE
                            error: (error, stackTrace) =>
                                const LoadingWallets(),
                            loading: () => const LoadingWallets(),
                            data: (data) {
                              walletCount.value = data.data!.wallets!.length;

                              return RefreshIndicator(
                                onRefresh: () async {
                                  return ref.refresh(getAccountDetailsProvider);
                                },
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.42,
                                  child: ListView.separated(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(
                                            parent: BouncingScrollPhysics()),
                                    itemCount: data.data!.wallets!.length,
                                    itemBuilder: (context, index) {
                                      final walletList =
                                          data.data!.wallets![index];
                                      return Container(
                                        height: 80.h,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.only(
                                            left: 20.w, right: 20.w),
                                        decoration: BoxDecoration(
                                          color: AppColors.whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 1),
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
                                                  '${walletList.currencyCode.toString()} wallet',
                                                  style: AppText.header2(
                                                      context,
                                                      AppColors.appColor,
                                                      18.sp),
                                                ),
                                                Space(10.h),
                                                Text(
                                                  '${walletList.currencyCode.toString()} ${formatter.format(num.tryParse(walletList.balance ?? "0.0"))}',
                                                  style: AppText.header2(
                                                      context,
                                                      AppColors.appColor,
                                                      20.sp),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            OptionsModalSheet(
                                              balance:
                                                  walletList.balance.toString(),
                                              currencyCode: walletList
                                                  .currencyCode
                                                  .toString(),
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
                                ),
                              );
                            }),

                        Center(
                          child: CustomButton(
                              buttonText: buttonText(context, "Create Wallet"),
                              bgColor: AppColors.appColor,
                              borderColor: AppColors.appColor,
                              textColor: Colors.white,
                              onPressed: () {
                                pushNewScreen(context,
                                    screen: SelectCurrencyScreen(
                                      currencyCode: currency,
                                      routeName: 'createWallet',
                                    ),
                                    withNavBar: false,
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.slideRight);
                              },
                              buttonWidth: 320),
                        ),
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
  final String balance;
  final bool isDefault;
  const OptionsModalSheet(
      {Key? key,
      required this.currencyCode,
      required this.isDefault,
      required this.balance})
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
        ref.invalidate(userProfileProvider);
        context.loaderOverlay.hide();
      }

      if (value is Error) {
        context.loaderOverlay.hide();
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
                            '${widget.currencyCode} wallet',
                            style: AppText.body5(
                              context,
                              AppColors.textColor.withOpacity(0.67),
                              16.sp,
                            ),
                          ),
                        ),
                        isDefaultAction: true,
                        onPressed: () {},
                      ),
                    ),
                    //View Wallet
                    // Container(
                    //   color: Colors.white,
                    //   child: CupertinoActionSheetAction(
                    //     child: Padding(
                    //       padding: EdgeInsets.only(left: 30.w, right: 30.w),
                    //       child: Text(
                    //         'view wallet',
                    //         style: AppText.body5(
                    //           context,
                    //           AppColors.textColor,
                    //           16.sp,
                    //         ),
                    //       ),
                    //     ),
                    //     isDefaultAction: true,
                    //     onPressed: () {
                    //       // currencyController.text = dollar;
                    //       // Navigator.pop(context);
                    //     },
                    //   ),
                    // ),

                    widget.isDefault
                        ? const SizedBox.shrink()
                        : Container(
                            color: Colors.white,
                            child: CupertinoActionSheetAction(
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: 30.w, right: 30.w),
                                child: Text(
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

                                PreferenceManager.defaultWallet =
                                    widget.currencyCode.toString();
                                ref
                                    .read(setWalletAsDefaultProvider.notifier)
                                    .setWalletAsDefault(widget.currencyCode);
                                Navigator.pop(context);
                              },
                            ),
                          ),
                    //Remove wallet

                    // Container(
                    //   color: Colors.white,
                    //   child: CupertinoActionSheetAction(
                    //     child: Padding(
                    //       padding: EdgeInsets.only(left: 30.w, right: 30.w),
                    //       child: Opacity(
                    //         opacity: widget.balance == "0.0" ? 0.2 : 0.8,
                    //         child: Text(
                    //           'Remove Wallet',
                    //           style: AppText.body5(
                    //             context,
                    //             AppColors.textColor,
                    //             16.sp,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     isDefaultAction: true,
                    //     onPressed: () {
                    //       if (widget.balance == "0.0") {
                    //         return;
                    //       }
                    //       // currencyController.text = dollar;
                    //       // Navigator.pop(context);
                    //     },
                    //   ),
                    // ),
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
      child: Container(
        color: Colors.transparent,
        height: 50,
        width: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
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

class LoadingWallets extends StatelessWidget {
  const LoadingWallets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: AppColors.appColor.withOpacity(0.09),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          height: 400,
          child: ListView.separated(
            scrollDirection: Axis.vertical,
            itemCount: 3,
            itemBuilder: (context, index) {
              return const SkeletonAvatar(
                style: SkeletonAvatarStyle(
                    width: double.infinity,
                    height: 70,
                    borderRadius: BorderRadius.all(Radius.circular(2))),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 10);
            },
          ),
        ),
      ),
    );
  }
}

class WalletCardView extends StatelessWidget {
  final String currencyCode;
  final String amount;
  const WalletCardView(
      {Key? key, required this.currencyCode, required this.amount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                currencyCode,
                style: AppText.header2(context, AppColors.appColor, 18.sp),
              ),
              Space(10.h),
              Text(
                amount,
                style: AppText.header2(context, AppColors.appColor, 20.sp),
              ),
            ],
          ),
          const Spacer(),
          // OptionsModalSheet(
          //   balance:
          //       data.data.defaultWallet.balance.toString(),
          //   currencyCode: data
          //       .data.defaultWallet.currencyCode
          //       .toString(),
          //   isDefault: true,
          // )
        ],
      ),
    );
  }
}
