import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/home.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/wallet_transactions.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_view_widget.dart';

class ViewAllTransactionScreen extends HookConsumerWidget {
  const ViewAllTransactionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsVm = ref.watch(walletTransactionProvider);
    return GenericWidget(
      appbar: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 40.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'All Transactions',
              style: AppText.body2(context, AppColors.whiteColor, 25.sp),
            ),
          ],
        ),
      ),
      // bgColor: AppColors.whiteColor,
      bgColor: const Color.fromRGBO(249, 249, 249, 1),

      child: SizedBox(
        height: 700.h,
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
                return ListView.separated(
                  padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 45.h),
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
                );
              }
            }),
      ),
    );
  }
}
