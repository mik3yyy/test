import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent_tab_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/transaction_build.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/transactions/view_all_transaction_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/wallet_transactions.dart';

import '../../../../components/app text theme/app_text_theme.dart';

class DashBoardTransactionList extends HookConsumerWidget {
  const DashBoardTransactionList({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(walletTransactionProvider);
    return transactions.when(
        error: (error, stackTrace) => Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.1,
              ),
              child: TextButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.grey.shade500,
                  disabledForegroundColor: Colors.grey,
                ),
                onPressed: () {
                  ref.invalidate(walletTransactionProvider);
                },
                icon: const Icon(Icons.restart_alt),
                label: const Text('Retry'),
              ),
            ),
        loading: () => loading(context),
        data: (data) {
          if (data.data!.transactions.isEmpty) {
            return const Center(
              child: Text("No transaction History"),
            );
          } else {
            return RefreshIndicator(onRefresh: () async {
              ref.invalidate(walletTransactionProvider);
            }, child: LayoutBuilder(builder: (context, constraints) {
              // final height = constraints.maxHeight;
              final width = constraints.maxWidth;

              return SizedBox(
                height: width * 0.73,
                child: ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  itemCount: data.data!.transactions.length < 5
                      ? data.data!.transactions.length
                      : 5 + 1,
                  // itemCount: data.data!.transactions.length,
                  itemBuilder: (context, index) {
                    final transactions = data.data!.transactions[index];
                    if (index != 5) {
                      return TransactionBuild(
                        transactions: transactions,
                      );
                    } else {
                      return Column(
                        children: [
                          SizedBox(
                            child: TextButton(
                                onPressed: () => pushNewScreen(
                                      context,
                                      screen: const ViewAllTransactionScreen(),
                                      withNavBar:
                                          false, // OPTIONAL VALUE. True by default.
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.cupertino,
                                    ),
                                style: TextButton.styleFrom(
                                    backgroundColor:
                                        AppColors.appColor.withOpacity(0.06)),
                                child: Text(
                                  'View more',
                                  style: AppText.body2(
                                      context, AppColors.appColor, 18.sp),
                                )),
                          ),
                          const SizedBox(
                            height: 45,
                          )
                        ],
                      );
                    }
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 20.h);
                  },
                ),
              );
            }));
          }
        });
  }
}

Widget loading(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.1,
        horizontal: MediaQuery.of(context).size.width * 0.3),
    child: const CircularProgressIndicator.adaptive(
      strokeWidth: 5,
    ),
  );
}
