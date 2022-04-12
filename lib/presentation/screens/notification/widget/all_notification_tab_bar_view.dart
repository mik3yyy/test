import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class AllNotificationTabBarView extends StatelessWidget {
  AllNotificationTabBarView({Key? key}) : super(key: key);

  final List<AllNotificationListDetails> _allNotificationDetails = [
    AllNotificationListDetails(
      notificationIcon: Image.asset(AppImage.successNotificationIcon),
      notificationMsg: "Deposited N50,000.00 to Beta ",
      notificationTime: "1 hour ago",
    ),
    AllNotificationListDetails(
      notificationIcon: Image.asset(AppImage.successNotificationIcon),
      notificationMsg:
          "Request to withdraw payment of ₦100,000.00 from Beta account",
      notificationTime: "2 days ago",
    ),
    AllNotificationListDetails(
      notificationIcon: Image.asset(AppImage.successNotificationIcon),
      notificationMsg: "Successful Transfer of N4,000.00 from Alpha to Beta",
      notificationTime: "2 hours ago",
    ),
    AllNotificationListDetails(
      notificationIcon: Image.asset(AppImage.successNotificationIcon),
      notificationMsg: "Annual alpha bonus Activated",
      notificationTime: "2 days ago",
    ),
    AllNotificationListDetails(
      notificationIcon: Image.asset(AppImage.successNotificationIcon),
      notificationMsg: "Congratultions! you have successfully unlocked Delta ",
      notificationTime: "2 days ago",
    ),
    AllNotificationListDetails(
      notificationIcon: Image.asset(AppImage.failedNotificationIcon),
      notificationMsg: "Request to withdraw \$3, 000 from Alpha account",
      notificationTime: "2 days ago",
    ),
    AllNotificationListDetails(
      notificationIcon: Image.asset(AppImage.phoneContactImg1),
      notificationMsg: "New message from John Doe",
      notificationTime: "2 days ago",
    ),
    AllNotificationListDetails(
      notificationIcon: Image.asset(AppImage.successNotificationIcon),
      notificationMsg: "Congratultions! you have successfully unlocked Delta ",
      notificationTime: "2 days ago",
    ),
    AllNotificationListDetails(
      notificationIcon: Image.asset(AppImage.failedNotificationIcon),
      notificationMsg: "Request to withdraw \$3, 000 from Alpha account",
      notificationTime: "2 days ago",
    ),
    AllNotificationListDetails(
      notificationIcon: Image.asset(AppImage.successNotificationIcon),
      notificationMsg: "Congratultions! you have successfully unlocked Delta ",
      notificationTime: "2 days ago",
    ),
    AllNotificationListDetails(
      notificationIcon: Image.asset(AppImage.failedNotificationIcon),
      notificationMsg: "Request to withdraw \$3, 000 from Alpha account",
      notificationTime: "2 days ago",
    ),
    AllNotificationListDetails(
      notificationIcon: Image.asset(AppImage.successNotificationIcon),
      notificationMsg: "Congratultions! you have successfully unlocked Delta ",
      notificationTime: "2 days ago",
    ),
    AllNotificationListDetails(
      notificationIcon: Image.asset(AppImage.failedNotificationIcon),
      notificationMsg: "Request to withdraw \$3, 000 from Alpha account",
      notificationTime: "2 days ago",
    ),
  ];

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450.h,
      child: Scrollbar(
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
                notificationIcon: item.notificationIcon,
                notificationMsg: item.notificationMsg,
                notificationTime: item.notificationTime,
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: Divider(
                color: AppColors.notificationDividerColor,
                thickness: 1.5,
                height: 20,
                // indent: 5.0,
              ),
            );
          },
        ),
      ),
    );
  }
}

class AllNotificationBuild extends StatelessWidget {
  final Widget notificationIcon;
  final String notificationMsg;
  final String notificationTime;
  const AllNotificationBuild({
    required this.notificationIcon,
    required this.notificationMsg,
    required this.notificationTime,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        notificationIcon,
        Space(13.w),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notificationMsg,
                style: AppText.body3(
                  context,
                  AppColors.appColor,
                ),
              ),
              Space(5.h),
              Text(
                notificationTime,
                style: AppText.body3(
                  context,
                  AppColors.appColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AllNotificationListDetails {
  final Widget notificationIcon;
  final String notificationMsg;
  final String notificationTime;

  AllNotificationListDetails({
    required this.notificationIcon,
    required this.notificationMsg,
    required this.notificationTime,
  });
}
