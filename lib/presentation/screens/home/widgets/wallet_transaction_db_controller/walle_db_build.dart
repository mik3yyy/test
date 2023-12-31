import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:kayndrexsphere_mobile/Data/database/transactions/wallet_transaction.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/dialog/dialog.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../../components/app image/app_image.dart';
import '../../../../components/app text theme/app_text_theme.dart';

class TransactionDbBuild extends StatelessWidget {
  final TransactionDataBase transaction;
  const TransactionDbBuild({Key? key, required this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime date = transaction.createdAt!;
    String dateCreated = DateFormat(' d, MMM yyyy').format(date);
    String formattedTime = DateFormat('kk:mm:a').format(date);
    var formatter = NumberFormat("#,##0.00");

    return GestureDetector(
      onTap: () {
        AppDialog.showDetailsDialog(
          context,
          transactionType: transaction.direction ?? "",
          status: "",
          amount:
              "${transaction.countryCode} ${formatter.format(transaction.amount ?? 0.0)}",
          date: "$dateCreated,  $formattedTime",
          reference: transaction.transactionRef.toString(),
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
              height: 60.h,
              width: 60.w,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orange.withOpacity(0.3)),
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
                  if (transaction.direction == "debit") ...[
                    Row(
                      children: [
                        Text(
                          'Debit',
                          style: AppText.body2(context, Colors.red, 18.sp),
                        ),
                        const Spacer(),
                        Text(
                          "${transaction.countryCode} ${formatter.format(transaction.amount)}",
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
                          "${transaction.countryCode} ${formatter.format(transaction.amount)}",
                          style: AppText.body2(context, Colors.green, 18.sp),
                        ),
                      ],
                    ),
                  ],
                  Space(10.h),
                  Row(
                    children: [
                      Text(
                        transaction.firstName.toString(),
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
      ),
    );
  }
}
