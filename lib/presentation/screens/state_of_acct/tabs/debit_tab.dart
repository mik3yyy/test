import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:kayndrexsphere_mobile/Data/model/statement_of_account/statement_of_account.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/state_of_acct/tabs/credit_tab.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/state_of_acct/vm/debit_e_wallet.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/state_of_acct/vm/e_wallet_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/dialog/dialog.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../components/app text theme/app_text_theme.dart';

class DebitTabView extends HookConsumerWidget {
  const DebitTabView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _viewDebitStatement = ref.watch(debitStatement);
    final _remoteStatement = ref.watch(remoteStatement);
    return SizedBox(
        child: _remoteStatement.when(
            data: (data) {
              if (_viewDebitStatement.value == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  itemCount: _viewDebitStatement.value?.length ?? 0,
                  // itemCount: data.data!.transactions.length,
                  itemBuilder: (context, index) {
                    final value = _viewDebitStatement.value?[index];

                    // for (var date in data.data.statements!) {
                    //   if (data.data.statements!.contains(date))
                    //     print(
                    //         timeAgoSinceDate(date.createdAt!.toIso8601String()));
                    // }
                    return DebitStatementCard(statement: value);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 10);
                  },
                );
              }
            },
            error: (e, s) {
              return Center(
                child: TextButton.icon(
                    onPressed: () {
                      ref.invalidate(remoteStatement);
                    },
                    icon: const Icon(Icons.replay),
                    label: const Text("Retry")),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator())));
  }
}

class DebitStatementCard extends StatelessWidget {
  final Statement statement;
  const DebitStatementCard({Key? key, required this.statement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat("#,##0.00");
    DateTime date = statement.createdAt!;
    String dateCreated = DateFormat(' d, MMM yyyy').format(date);
    String formattedTime = DateFormat('kk:mm:a').format(date);
    return GestureDetector(
      onTap: () {
        AppDialog.showDetailsDialog(
          context,
          transactionType: statement.direction.toString(),
          status: statement.entity!.status.toString(),
          amount:
              "${statement.entity?.walletCurrencyCode} ${formatter.format(statement.amount)}",
          date: "$dateCreated,  $formattedTime",
          reference: statement.entity!.paymentRef.toString(),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 10),
        color: Colors.grey.shade100,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Space(13),
                Text(statement.direction.toString()),
                const Space(5),
                Text(
                  getDirection(statement.direction.toString()),
                  style: AppText.body3(
                      context, directionColor(statement.direction.toString())),
                ),
              ],
            ),
            const Spacer(),
            Text(
                "${statement.currencyCode} ${formatter.format(statement.amount)}"),
          ],
        ),
      ),
    );
  }
}
