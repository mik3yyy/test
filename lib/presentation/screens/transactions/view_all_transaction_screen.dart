import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/home.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/wallet_transactions.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class ViewAllTransactionScreen extends HookConsumerWidget {
  const ViewAllTransactionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsVm = ref.watch(walletTransactionProvider);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.textColor,
          ),
        ),
        title: Text(
          'All Transactions',
          style: AppText.header3(context, AppColors.textColor, 25.sp),
        ),
        elevation: 0,
        backgroundColor: AppColors.whiteColor,
      ),
      body: SizedBox(
        child: transactionsVm.when(
            error: (error, stackTrace) => Text(error.toString()),
            idle: () => const Center(
                  child: CircularProgressIndicator.adaptive(
                    strokeWidth: 5,
                  ),
                ),
            loading: () => const Center(
                  child: CircularProgressIndicator.adaptive(
                    strokeWidth: 5,
                  ),
                ),
            success: (data) {
              if (data!.data!.transactions.isEmpty) {
                return const Center(
                  child: Text("You have no transactions"),
                );
              } else {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        padding:
                            EdgeInsets.only(left: 25.w, right: 25.w, top: 20.h),
                        physics: const AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics()),
                        itemCount: data.data!.transactions.length,
                        itemBuilder: (context, index) {
                          final transactions = data.data!.transactions[index];
                          return TransactionBuild(
                            transactions: transactions,
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: 20.h);
                        },
                      ),
                    ),
                    const Space(80)
                  ],
                );
              }
            }),
      ),
    );
  }
}
