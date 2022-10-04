import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/model/statement_of_account/statement_of_account.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/widget/appbar_title.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/state_of_acct/tabs/view_all.dart';

class StatementRangeAccount extends HookConsumerWidget {
  final Data statement;
  const StatementRangeAccount({Key? key, required this.statement})
      : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        title: const AppBarTitle(title: "Account History", color: Colors.black),
        leading: const BackButton(color: Colors.black),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: statement.statements.isEmpty
          ? Center(
              child: Text(
                'No Statement',
                style: AppText.header2(context, Colors.black, 20.sp),
              ),
            )
          : Expanded(
              child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              itemCount: statement.statements.length,
              itemBuilder: (context, index) {
                final value = statement.statements[index];

                return StatementListCard(
                  statement: value,
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 15);
              },
            )),
    );
  }
}
