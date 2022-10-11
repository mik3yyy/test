import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/statement_of_account/download_statement.dart';
import 'package:kayndrexsphere_mobile/Data/model/statement_of_account/get_range_request.dart';
import 'package:kayndrexsphere_mobile/Data/model/statement_of_account/statement_of_account.dart';
import 'package:kayndrexsphere_mobile/presentation/components/AppSnackBar/snackbar/app_snackbar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/widget/appbar_title.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/get_profile_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/state_of_acct/check_date/check_date.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/state_of_acct/tabs/view_all.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/state_of_acct/vm/get_range/download_range.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class StatementRangeAccount extends HookConsumerWidget {
  final Data statement;
  final String startDate;
  final String endDate;
  const StatementRangeAccount(
      {Key? key,
      required this.statement,
      required this.startDate,
      required this.endDate})
      : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProfileProvider);
    final range = ref.watch(downloadRangeProvider);
    ref.listen<RequestState>(downloadRangeProvider, (_, value) {
      if (value is Success<DownloadStatement>) {
        AppSnackBar.showSuccessSnackBar(context,
            message: value.value?.message ??
                "Account Statement statement has been sent to your email");
      }

      if (value is Error) {
        AppSnackBar.showErrorSnackBar(context, message: value.error.toString());
      }
    });
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
          : Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                      style: AppText.header2(context, Colors.black45, 15.sp),
                      children: <TextSpan>[
                        const TextSpan(
                            text:
                                'Your account statement will be sent to your registered email -',
                            style: TextStyle(color: Colors.black45)),
                        TextSpan(
                            text: ' ${user.value?.data.user.email}',
                            style: AppText.header2(
                                context, AppColors.appColor, 15.sp))
                      ],
                    ),
                  ),
                  const Space(10),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                        onPressed: () {
                          var statementReq = StatementReq(
                              fromDate: formatDate(startDate),
                              toDate: formatDate(endDate));
                          ref
                              .read(downloadRangeProvider.notifier)
                              .downloadRange(
                                statementReq,
                              );
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: AppColors.appColor,
                          onSurface: AppColors.appColor,
                        ),
                        child: range is Loading
                            ? const SizedBox(
                                height: 15,
                                width: 15,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ))
                            : Text(
                                'Send to Email',
                                style: AppText.header2(
                                    context, Colors.white, 15.sp),
                              )),
                  ),
                  const Space(10),
                  Expanded(
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
                ],
              ),
            ),
    );
  }
}
