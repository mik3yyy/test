import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:math' as math;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/convert_currency_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/currency_transactions.dart';
import 'package:kayndrexsphere_mobile/presentation/components/AppSnackBar/snackbar/app_snackbar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/expandable_widget/expanded.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent_tab_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/edit_form.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/validator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/add-fund-to-wallet/currency_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/convert_currency_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/currency_transactions_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';
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
    final fromCurrency = useTextEditingController();
    final toCurrency = useTextEditingController();
    final fromExchangeCurrency = useTextEditingController();

    final remoteTransaction = ref.watch(remoteTransactionListProvider);
    final transaction = ref.watch(transactionsearchInputProvider);
    final rate = useState("0.0");
    final from = useState("0.0");
    final convert = ref.watch(conversionProvider);
    // final listState = useState("");

    ref.listen<RequestState>(conversionProvider, (previous, value) {
      if (value is Success<ConvertCurrencyRes>) {
        rate.value = value.value!.data.rates.rate.toString();
      }

      if (value is Error) {
        AppSnackBar.showErrorSnackBar(context, message: value.error.toString());
      }
    });

    return Padding(
      padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 15.h),
      child: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                  height: 55.h,
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.r),
                          ),
                        ),
                        filled: true,
                        hintStyle:
                            AppText.body2(context, Colors.black26, 19.sp),
                        hintText: "Search account number",
                        suffixIcon: const Icon(Icons.search),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: -4.h, horizontal: 10.w),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: AppColors.appColor),
                          borderRadius: BorderRadius.circular(25.7),
                        ),
                        fillColor: Colors.transparent),
                    onChanged: (value) {
                      // _filterClients(value);
                      // listState.value = value;

                      ref
                          .read(transactionSearchQueryStateProvider.notifier)
                          .state = value;
                    },
                  )),
              Space(10.h),
              ExpandableTheme(
                data: const ExpandableThemeData(
                  iconColor: Colors.blue,
                  useInkWell: true,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ExpandableNotifier(
                      child: ScrollOnExpand(
                        child: Column(
                          children: [
                            ExpandablePanel(
                              theme: const ExpandableThemeData(
                                headerAlignment:
                                    ExpandablePanelHeaderAlignment.center,
                                tapBodyToExpand: false,
                                tapBodyToCollapse: false,
                                hasIcon: false,
                              ),
                              header: Container(
                                padding: EdgeInsets.only(
                                    left: 19.w,
                                    top: 10.w,
                                    bottom: 10.w,
                                    right: 19.w),
                                decoration: const BoxDecoration(
                                  color: AppColors.appColor,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'View Exchange rates',
                                      style: AppText.body2Medium(
                                          context, Colors.white, 20.sp),
                                    ),
                                    const ExpandableIcon(
                                      theme: ExpandableThemeData(
                                        expandIcon: Icons.expand_more_outlined,
                                        collapseIcon:
                                            Icons.expand_less_outlined,
                                        iconColor: AppColors.whiteColor,
                                        iconSize: 28.0,
                                        iconRotationAngle: math.pi / 2,
                                        iconPadding: EdgeInsets.only(right: 5),
                                        hasIcon: false,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              collapsed: Container(),
                              expanded: Padding(
                                padding:
                                    EdgeInsets.only(left: 19.w, right: 19.w),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Space(10.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            pushNewScreen(context,
                                                screen: SelectCurrencyScreen(
                                                  currencyCode: fromCurrency,
                                                  routeName: 'addFunds',
                                                ),
                                                pageTransitionAnimation:
                                                    PageTransitionAnimation
                                                        .slideRight);
                                          },
                                          child: SizedBox(
                                            width: 100.w,
                                            child: EditForm(
                                              enabled: false,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              labelText: 'From',

                                              // textAlign: TextAlign.start,
                                              controller: fromCurrency,
                                              obscureText: false,

                                              validator: (value) =>
                                                  validateCurrency(value),
                                              suffixIcon: const Icon(
                                                CupertinoIcons.chevron_down,
                                                color: Color(0xffA8A8A8),
                                                size: 15,
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            pushNewScreen(context,
                                                screen: SelectCurrencyScreen(
                                                  currencyCode: toCurrency,
                                                  routeName: "addFunds",
                                                ),
                                                pageTransitionAnimation:
                                                    PageTransitionAnimation
                                                        .slideRight);
                                          },
                                          child: SizedBox(
                                            width: 100.w,
                                            child: EditForm(
                                              enabled: false,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              labelText: 'To',

                                              // textAlign: TextAlign.start,
                                              controller: toCurrency,
                                              obscureText: false,
                                              validator: (value) =>
                                                  validateCurrency(value),
                                              suffixIcon: const Icon(
                                                CupertinoIcons.chevron_down,
                                                color: Color(0xffA8A8A8),
                                                size: 15,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Space(10),
                                            Text("Exchange Rate",
                                                style: AppText.body2(context,
                                                    Colors.black38, 15.sp)),
                                            const Space(10),
                                            convert is Loading
                                                ? const Center(
                                                    child: SizedBox(
                                                      height: 18,
                                                      width: 18,
                                                      child:
                                                          CircularProgressIndicator(
                                                        strokeWidth: 4,
                                                      ),
                                                    ),
                                                  )
                                                : Text(rate.value,
                                                    style: AppText.body2(
                                                        context,
                                                        Colors.black,
                                                        20.sp)),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Space(14.h),
                                    CustomButton(
                                      buttonText: convert is Loading
                                          ? loading()
                                          : buttonText(
                                              context, "Get Exchange Rate"),
                                      bgColor: AppColors.appColor,
                                      textColor: AppColors.whiteColor,
                                      borderColor:
                                          AppColors.appColor.withOpacity(0.3),
                                      buttonWidth:
                                          MediaQuery.of(context).size.width,
                                      onPressed: convert is Loading
                                          ? null
                                          : () {
                                              if (fromCurrency.text.isEmpty &&
                                                  toCurrency.text.isEmpty) {
                                                return;
                                              } else {
                                                ref
                                                    .read(conversionProvider
                                                        .notifier)
                                                    .conversion(
                                                        fromCurrency.text,
                                                        toCurrency.text);
                                              }
                                            },
                                    ),
                                    Space(14.h),
                                    InkWell(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width: 150.w,
                                            child: EditForm(
                                              enabled: true,
                                              keyboardType:
                                                  TextInputType.number,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              labelText: convert is Loading
                                                  ? "---"
                                                  : 'Enter amount',

                                              // textAlign: TextAlign.start,
                                              controller: fromExchangeCurrency,
                                              obscureText: false,
                                              validator: (value) => null,

                                              onChanged: (value) {
                                                final res =
                                                    (num.tryParse(value) ?? 0) *
                                                        (num.tryParse(
                                                                rate.value) ??
                                                            0);

                                                from.value = res.toString();
                                              },
                                            ),
                                          ),
                                          // Text(
                                          //   // salesPrice.toString(),
                                          //   ((num.tryParse(from.value) ?? 0) *
                                          //           (num.tryParse(rate.value) ??
                                          //               0))
                                          //       .toString(),
                                          //   style: TextStyle(
                                          //     color: const Color(0xFF2C2C2C),
                                          //     fontSize: 14.sp,
                                          //     fontWeight: FontWeight.w700,
                                          //   ),
                                          // ),
                                          Text(
                                            from.value,
                                            style: AppText.body2(
                                                context, Colors.black, 20.sp),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Space(18.h),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
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
                          return ref.refresh(remoteTransactionListProvider);
                        },
                        child: SizedBox(
                          height: 500.h,
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

class CurrencyTransactionBuild extends StatelessWidget {
  final Transactions transactions;
  const CurrencyTransactionBuild({Key? key, required this.transactions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime date = transactions.createdAt!;
    String dateCreated = DateFormat(' d, MMM yyyy').format(date);
    var formatter = NumberFormat("#,##0.00");
    final currency = PreferenceManager.defaultWallet;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 60.h,
            width: 60.w,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Colors.orange.withOpacity(0.3)),
            child: Center(
              child: SvgPicture.asset(
                AppImage.transferIcon,
                height: 20.h,
                width: 20.w,
              ),
            ),
          ),
          Space(10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (transactions.direction == "debit") ...[
                  Row(
                    children: [
                      Text(
                        'Debit',
                        style: AppText.body2(context, Colors.red, 18.sp),
                      ),
                      const Spacer(),
                      Text(
                        "$currency ${formatter.format(transactions.amount)}",
                        style: AppText.body2(context, Colors.red, 18.sp),
                      ),
                    ],
                  ),
                ] else ...[
                  Row(
                    children: [
                      Text(
                        "Credit",
                        style: AppText.body2(context, Colors.green, 18.sp),
                      ),
                      const Spacer(),
                      Text(
                        "${transactions.currencyCode} ${formatter.format(transactions.amount)}",
                        style: AppText.body2(context, Colors.green, 18.sp),
                      ),
                    ],
                  ),
                ],
                Space(10.h),
                Row(
                  children: [
                    Text(
                      transactions.user!.firstName.toString(),
                      style: AppText.body2(context, Colors.black, 18.sp),
                    ),
                    const Spacer(),
                    Text(
                      dateCreated,
                      style: AppText.body2(context, Colors.black, 18.sp),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
