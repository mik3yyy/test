import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/wallet_transactions.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/dialog/dialog.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../components/app image/app_image.dart';
import '../../../components/app text theme/app_text_theme.dart';

class TransactionBuild extends StatelessWidget {
  final Transaction transactions;
  const TransactionBuild({Key? key, required this.transactions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime date = transactions.createdAt!;
    String dateCreated = DateFormat(' d, MMM yyyy').format(date);
    String formattedTime = DateFormat('kk:mm:a').format(date);
    var formatter = NumberFormat("#,##0.00");

    return GestureDetector(
      onTap: () {
        AppDialog.showDetailsDialog(
          context,
          transactionType: transactions.direction ?? "",
          status: "",
          amount:
              "${transactions.currencyCode} ${formatter.format(transactions.amount)}",
          date: "$dateCreated,  $formattedTime",
          reference: transactions.transactionRef.toString(),
        );
      },
      child: Container(
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
              height: 50.h,
              width: 50.w,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orange.withOpacity(0.3)),
              child: Center(
                child: SvgPicture.asset(
                  AppImage.transferIcon,
                  height: 15.h,
                  width: 15.w,
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
                          style: AppText.body2(context, Colors.red, 16.sp),
                        ),
                        const Spacer(),
                        Text(
                          "${transactions.currencyCode} ${formatter.format(transactions.amount)}",
                          style: AppText.body2(context, Colors.red, 16.sp),
                        ),
                      ],
                    ),
                  ] else ...[
                    Row(
                      children: [
                        Text(
                          "Credit",
                          style: AppText.body2(context, Colors.green, 16.sp),
                        ),
                        const Spacer(),
                        Text(
                          "${transactions.currencyCode} ${formatter.format(transactions.amount)}",
                          style: AppText.body2(context, Colors.green, 16.sp),
                        ),
                      ],
                    ),
                  ],
                  Space(10.h),
                  Row(
                    children: [
                      Text(
                        transactions.user!.firstName.toString(),
                        style: AppText.body2(context, Colors.black, 16.sp),
                      ),
                      const Spacer(),
                      Text(
                        dateCreated,
                        style: AppText.body2(context, Colors.black, 16.sp),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
