import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class RequestNotificationTabBarView extends StatelessWidget {
  RequestNotificationTabBarView({Key? key}) : super(key: key);

  final List<RequestNotificationListDetails> _allNotificationDetails = [
    RequestNotificationListDetails(
      notificationStatus: 'Granted',
      notificationMsg: "Request to withdraw \$3, 000 from Alpha account",
      notificationTime: "1 hour ago",
      color: AppColors.appColor,
    ),
    RequestNotificationListDetails(
      notificationStatus: 'Decline',
      notificationMsg:
          "Request to withdraw payment of ₦100,000.00 from Beta account",
      notificationTime: "2 days ago",
      color: AppColors.errorColor,
    ),
    RequestNotificationListDetails(
      notificationStatus: 'Granted',
      notificationMsg: "Request to withdraw \$3, 000 from Alpha account",
      notificationTime: "1 hour ago",
      color: AppColors.appColor,
    ),
    RequestNotificationListDetails(
      notificationStatus: 'Decline',
      notificationMsg:
          "Request to withdraw payment of ₦100,000.00 from Beta account",
      notificationTime: "2 days ago",
      color: AppColors.declineColor,
    ),
    RequestNotificationListDetails(
      notificationStatus: 'Granted',
      notificationMsg: "Request to withdraw \$3, 000 from Alpha account",
      notificationTime: "1 hour ago",
      color: AppColors.appColor,
    ),
    RequestNotificationListDetails(
      notificationStatus: 'Decline',
      notificationMsg:
          "Request to withdraw payment of ₦100,000.00 from Beta account",
      notificationTime: "2 days ago",
      color: AppColors.declineColor,
    ),
  ];

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450.h,
      child: Scrollbar(
        //TODO: To fix the scroll, it's not showing
        isAlwaysShown: true,
        controller: _scrollController,
        child: ListView.separated(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          itemCount: _allNotificationDetails.length,
          itemBuilder: (BuildContext context, int index) {
            final item = _allNotificationDetails[index];
            return Padding(
              padding: const EdgeInsets.only(right: 32.0),
              child: AllNotificationBuild(
                notificationStatus: item.notificationStatus,
                color: item.color,
                notificationMsg: item.notificationMsg,
                notificationTime: item.notificationTime,
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              color: AppColors.notificationDividerColor,
              thickness: 1.5,
              height: 20,
              // indent: 5.0,
            );
          },
        ),
      ),
    );
  }
}

class AllNotificationBuild extends StatelessWidget {
  final String notificationStatus;
  final String notificationMsg;
  final String notificationTime;
  final Color color;
  const AllNotificationBuild({
    required this.notificationStatus,
    required this.notificationMsg,
    required this.notificationTime,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          notificationMsg,
          style: AppText.body3(
            context,
            AppColors.appColor,
          ),
        ),
        Space(7.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              notificationTime,
              style: AppText.body3(
                context,
                AppColors.appColor,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(6.w, 2.w, 6.w, 2.w),
              width: 50.w,
              height: 18.h,
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(6.r)),
              child: Center(
                child: Text(
                  notificationStatus,
                  style: AppText.body2(
                    context,
                    AppColors.whiteColor,
                    12.h,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );

    // Row(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     notificationIcon,
    //     Space(13.w),
    //     Expanded(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    // Text(
    //   notificationMsg,
    //   style: AppText.body3(
    //     context,
    //     AppColors.appColor,
    //   ),
    // ),
    //           Space(5.h),
    // Text(
    //   notificationTime,
    //   style: AppText.body3(
    //     context,
    //     AppColors.appColor,
    //   ),
    // ),
    //         ],
    //       ),
    //     ),
    //   ],
    // );
  }
}

class RequestNotificationListDetails {
  final String notificationStatus;
  final String notificationMsg;
  final String notificationTime;
  final Color color;

  RequestNotificationListDetails({
    required this.notificationStatus,
    required this.notificationMsg,
    required this.notificationTime,
    required this.color,
  });
}
