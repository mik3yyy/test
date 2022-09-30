import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:kayndrexsphere_mobile/Data/model/statement_of_account/statement_of_account.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/state_of_acct/vm/e_wallet_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/dialog/dialog.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class ViewAllStatement extends HookConsumerWidget {
  const ViewAllStatement({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _viewallStatement = ref.watch(remoteStatement);
    return SizedBox(
        child: _viewallStatement.when(
            data: (data) {
              return RefreshIndicator(
                onRefresh: () async {
                  return ref.refresh(remoteStatement);
                },
                child: ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  itemCount: data.data.statements.length,
                  // itemCount: data.data!.transactions.length,
                  itemBuilder: (context, index) {
                    final value = data.data.statements[index];

                    // for (var date in data.data.statements) {
                    //   if (data.data.statements.contains(date))
                    //     print(
                    //         timeAgoSinceDate(date.createdAt!.toIso8601String()));
                    // }
                    return StatementListCard(
                      statement: value,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 15);
                  },
                ),
              );
            },
            error: (e, s) {
              return Center(
                child: TextButton.icon(
                    onPressed: () {
                      ref.refresh(remoteStatement);
                    },
                    icon: const Icon(Icons.replay),
                    label: const Text("Retry")),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator())));
  }
}

class StatementListCard extends StatelessWidget {
  final Statement statement;
  const StatementListCard({Key? key, required this.statement})
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
          accountName: "",
          accountNo: "",
          status: statement.entity!.status.toString(),
          amount:
              "${statement.entity?.walletCurrencyCode} ${formatter.format(statement.amount)}",
          date: "$dateCreated,  $formattedTime",
          reference: statement.entity!.paymentRef.toString(),
        );
      },
      child: Container(
        // height: 70,
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
                  getStatus(statement.entity!.status.toString()),
                  style: AppText.body3(context,
                      statusColor(statement.entity!.status.toString())),
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

String getStatus(String status) {
  if (status.isEmpty) {
    return "pending";
  } else {
    return status;
  }
}

Color statusColor(String status) {
  if (status.isEmpty) {
    return Colors.blue;
  } else if (status == "completed") {
    return Colors.green;
  } else {
    return Colors.red;
  }
}
