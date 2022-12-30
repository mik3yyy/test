import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/get_account_details_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../components/app text theme/app_text_theme.dart';
import '../../wallet/vm/set_wallet_as_default_vm.dart';

class SelectWalletList extends StatefulHookConsumerWidget {
  final TextEditingController currency;
  final String routeName;
  const SelectWalletList(
      {Key? key, required this.currency, required this.routeName})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectWalletListState();
}

class _SelectWalletListState extends ConsumerState<SelectWalletList> {
  @override
  Widget build(BuildContext context) {
    final wallet = ref.watch(getAccountDetailsProvider);
    return InkWell(
      child: const Icon(
        Icons.keyboard_arrow_down,
        color: AppColors.appColor,
      ),
      onTap: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            builder: (context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Space(20),
                  Text(
                    'Set Default Wallet',
                    style: AppText.header2(context, AppColors.appColor, 20.sp),
                  ),
                  const Space(10),
                  wallet.when(
                      error: (error, stackTrace) => Text(error.toString()),
                      loading: () => const CircularProgressIndicator.adaptive(),
                      data: (data) {
                        double _getSized() {
                          if (data.data!.wallets!.length == 1) {
                            return 200;
                          } else if (data.data!.wallets!.length == 2) {
                            return 250;
                          } else if (data.data!.wallets!.length == 3) {
                            return 300;
                          } else if (data.data!.wallets!.length == 4) {
                            return 350;
                          } else if (data.data!.wallets!.length == 5) {
                            return 400;
                          } else {
                            return 600;
                          }
                        }

                        // return Column(
                        //   // mainAxisSize: MainAxisSize.min,
                        //   children: List.generate(data.data!.wallets!.length,
                        //       (index) {
                        //     final walletList = data.data!.wallets![index];
                        //     return Padding(
                        //       padding:
                        //           const EdgeInsets.only(top: 10, bottom: 10),
                        //       child: Container(
                        //         height: 50.h,
                        //         width: MediaQuery.of(context).size.width,
                        //         padding:
                        //             EdgeInsets.only(left: 20.w, right: 20.w),
                        //         decoration: BoxDecoration(
                        //           color: AppColors.whiteColor,
                        //           borderRadius: BorderRadius.circular(5.r),
                        //           boxShadow: const [
                        //             BoxShadow(
                        //               color: Color.fromRGBO(255, 255, 255, 1),
                        //               offset: Offset(
                        //                 2.0,
                        //                 2.0,
                        //               ),
                        //               blurRadius: 0.0,
                        //               spreadRadius: 2.0,
                        //             ),
                        //           ],
                        //         ),
                        //         child: Center(
                        //           child: Text(
                        //             '${walletList.currencyCode.toString()} wallet',
                        //             style: AppText.header2(
                        //                 context, AppColors.appColor, 17.sp),
                        //           ),
                        //         ),
                        //       ),
                        //     );
                        //   }),
                        // );

                        return SizedBox(
                          height: _getSized(),
                          child: ListView.separated(
                            physics: const AlwaysScrollableScrollPhysics(
                                parent: BouncingScrollPhysics()),
                            itemCount: data.data!.wallets!.length,
                            itemBuilder: (context, index) {
                              final walletList = data.data!.wallets![index];
                              return InkWell(
                                onTap: () {
                                  if (widget.routeName == "transferScreen") {
                                    widget.currency.text =
                                        walletList.currencyCode.toString();

                                    Navigator.pop(context);
                                  } else {
                                    PreferenceManager.defaultWallet =
                                        walletList.currencyCode.toString();
                                    ref
                                        .read(
                                            setWalletAsDefaultProvider.notifier)
                                        .setWalletAsDefault(
                                            walletList.currencyCode.toString());
                                    Navigator.pop(context);
                                  }
                                },
                                child: Container(
                                  height: 50.h,
                                  width: MediaQuery.of(context).size.width,
                                  padding:
                                      EdgeInsets.only(left: 20.w, right: 20.w),
                                  decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    borderRadius: BorderRadius.circular(5.r),
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
                                  child: Center(
                                    child: Text(
                                      '${walletList.currencyCode.toString()} wallet',
                                      style: AppText.header2(
                                          context, AppColors.appColor, 18.sp),
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 15,
                              );
                            },
                          ),
                        );
                      }),
                  if (Platform.isAndroid) ...[Space(75.h)] else ...[Space(80.h)]
                ],
              );
            });
      },
    );
  }
}
