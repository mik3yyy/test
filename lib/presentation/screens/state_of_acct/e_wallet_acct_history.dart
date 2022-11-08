import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/statement_of_account/get_range_request.dart';
import 'package:kayndrexsphere_mobile/presentation/components/AppSnackBar/snackbar/app_snackbar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/loading_util/loading_util.dart';
import 'package:kayndrexsphere_mobile/presentation/components/widget/appbar_title.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/home.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent_tab_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/state_of_acct/check_date/check_date.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/state_of_acct/statement_acct_range_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/state_of_acct/tabs/credit_tab.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/state_of_acct/tabs/debit_tab.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/state_of_acct/tabs/view_all.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/state_of_acct/vm/e_wallet_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/state_of_acct/vm/get_range/get_range_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../components/app text theme/app_text_theme.dart';

class EWalletAccountHistory extends StatefulHookConsumerWidget {
  const EWalletAccountHistory({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EWalletAccountHistoryState();
}

class _EWalletAccountHistoryState extends ConsumerState<EWalletAccountHistory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final startDate = useTextEditingController();
    final endDate = useTextEditingController();
    final _viewallStatement = ref.watch(remoteStatement);
    final range = ref.watch(accountRangeProvider);

    ref.listen<RequestState>(accountRangeProvider, (prev, value) {
      if (value is Loading<dynamic>) {
        ScreenView.showLoadingView(context);
      } else {
        ScreenView.hideLoadingView(context);
      }
      if (value is Success<dynamic>) {
        pushNewScreen(context,
            screen: StatementRangeAccount(
              startDate: startDate.text,
              endDate: endDate.text,
              statement: value.value!.data,
            ));
      }

      if (value is Error) {
        AppSnackBar.showErrorSnackBar(context, message: value.error.toString());
      }
    });
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        title: const AppBarTitle(
            title: "E-Wallet Account History", color: Colors.black),
        leading: const BackButton(color: Colors.black),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 23, right: 23),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InnerPageLoadingIndicator(
                  loadingStream: _viewallStatement is Loading),
              const Space(10),
              Row(
                children: [
                  Text(
                    'Select Range',
                    style: AppText.header2(context, Colors.black, 20.sp),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                        onPressed: () {
                          if ((startDate.text.isEmpty) ||
                              (endDate.text.isEmpty)) {
                            return;
                          } else {
                            var statementReq = StatementReq(
                                fromDate: formatDate(startDate.text),
                                toDate: formatDate(endDate.text));
                            ref
                                .read(accountRangeProvider.notifier)
                                .getRange(statementReq);
                          }
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
                                'Get range',
                                style: AppText.header2(
                                    context, Colors.white, 15.sp),
                              )),
                  ),
                ],
              ),
              const Space(20),
              Row(
                children: [
                  KYDatePicker(
                    controller: startDate,
                    hint: "Start date",
                    onTextEntered: (String value) {},
                  ),
                  const Spacer(),
                  KYDatePicker(
                    controller: endDate,
                    hint: "End date",
                    onTextEntered: (String value) {},
                  ),
                ],
              ),
              const Space(20),
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    margin: EdgeInsets.only(left: 9.w, right: 9.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28.r),
                        color: Colors.grey.shade200),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 2.h),
                    child: Container(
                        padding: EdgeInsets.only(left: 0.w, right: 0.w),
                        height: 50.h,
                        width: MediaQuery.of(context).size.width,
                        // color: Colors.black,
                        child: TabBar(
                          isScrollable: false,
                          controller: _tabController,
                          // unselectedLabelColor: Colors.white,

                          labelColor: Colors.white,
                          labelStyle:
                              AppText.body2(context, AppColors.appColor, 19.sp),
                          unselectedLabelStyle:
                              AppText.body2(context, Colors.black45, 19.sp),
                          unselectedLabelColor: Colors.black26,
                          labelPadding: EdgeInsets.zero,
                          indicatorPadding: EdgeInsets.zero,

                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.r),
                            color: AppColors.appColor,
                          ),
                          tabs: const [
                            Tab(
                              text: 'View all',
                            ),
                            Tab(
                              text: 'Credit',
                            ),
                            Tab(
                              text: 'Debit',
                            ),
                          ],
                        )),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  // height: 783.h,
                  // color: Colors.blue,
                  child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: const [
                        ViewAllStatement(),
                        CreditTabView(),
                        DebitTabView()
                      ]),
                ),
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}

class KYDatePicker extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  // final FocusNode focusNode;
  final ValueChanged<String> onTextEntered;
  const KYDatePicker(
      {Key? key,
      required this.controller,
      required this.hint,
      required this.onTextEntered})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.42,
      child: DateTimePicker(
        controller: controller,
        type: DateTimePickerType.date,
        dateMask: 'dd-MM-yyyy',
        firstDate: DateTime(1900),
        lastDate: DateTime(3100),
        decoration: InputDecoration(
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
          ),
          focusColor: AppColors.appBgColor,
          filled: true,
          fillColor: AppColors.appBgColor,
          hintText: hint,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText2
              ?.copyWith(color: Colors.grey),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
        ),
        onChanged: onTextEntered,
        validator: (val) {
          // if (val!.isEmpty) {
          //   return "select date";
          // }

          return null;
        },
      ),
    );
  }
}
