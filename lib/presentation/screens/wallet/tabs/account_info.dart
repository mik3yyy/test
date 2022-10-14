import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/get_profile_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/transfer/widget/currency_transaction_build.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/transfer/widget/exchange_rate.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/currency_transactions_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/swiftcode/search_box.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class AccounInfoTab extends StatefulHookConsumerWidget {
  const AccounInfoTab({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AccounInfoTabState();
}

class _AccounInfoTabState extends ConsumerState<AccounInfoTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final remoteTransaction = ref.watch(remoteTransactionListProvider);
    final transaction = ref.watch(transactionsearchInputProvider);
    final user = ref.watch(userProfileProvider).value;

    return Padding(
      padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 15.h),
      child: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SearchBox(
                onTextEntered: (value) {
                  ref.read(transactionSearchQueryStateProvider.notifier).state =
                      value;
                },
              ),
              Space(20.h),
              const ExchangeRate(),
              const Space(30),
              remoteTransaction.when(
                  error: (error, stackTrace) {
                    return Text(error.toString());
                  },
                  loading: () => Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * 0.13,
                            horizontal:
                                MediaQuery.of(context).size.width * 0.3),
                        child: const CircularProgressIndicator.adaptive(
                          strokeWidth: 5,
                        ),
                      ),
                  data: (data) {
                    if (transaction.value == null) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * 0.13,
                            horizontal:
                                MediaQuery.of(context).size.width * 0.3),
                        child: const CircularProgressIndicator.adaptive(
                          strokeWidth: 5,
                        ),
                      );
                    } else if (data.data.transactions.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * 0.13,
                            horizontal:
                                MediaQuery.of(context).size.width * 0.2),
                        child: const Text("No transaction History"),
                      );
                    } else {
                      return RefreshIndicator(
                        onRefresh: () async {
                          return ref.refresh(currencyTransactionProvider(
                              user!.data.defaultWallet.currencyCode ?? ""));
                        },
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.49,
                          child: ListView.separated(
                            physics: const AlwaysScrollableScrollPhysics(
                                parent: BouncingScrollPhysics()),
                            itemCount: transaction.value!.length,
                            // itemCount: data.data!.transactions.length,
                            itemBuilder: (context, index) {
                              final value = transaction.value![index];
                              return CurrencyTransactionBuild(
                                transactions: value,
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}
