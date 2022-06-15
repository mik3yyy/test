import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/notification/viewmodel/get_notification_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class AllNotificationTabBarView extends StatefulHookConsumerWidget {
  const AllNotificationTabBarView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AllNotificationTabBarViewState();
}

class _AllNotificationTabBarViewState
    extends ConsumerState<AllNotificationTabBarView>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final notification = ref.watch(getNotificationProvider);
    return notification.when(
        error: (error, stackTrace) => Text(error.toString()),
        idle: () => const CircularProgressIndicator.adaptive(),
        loading: () => const Center(
            child: SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator.adaptive())),
        success: (data) {
          if (data!.data.notifications.isEmpty) {
            return Text(
              "You have notification",
              style: AppText.body3(
                context,
                AppColors.appColor,
              ),
            );
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                ref.refresh(getNotificationProvider);
              },
              child: SizedBox(
                height: 450.h,
                child: Scrollbar(
                  isAlwaysShown: true,
                  controller: _scrollController,
                  child: ListView.separated(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    itemCount: data.data.notifications.length,
                    itemBuilder: (BuildContext context, int index) {
                      final msg = data.data.notifications[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 32.0),
                        child: AllNotificationBuild(
                          notificationIcon:
                              Image.asset(AppImage.successNotificationIcon),
                          notificationMsg: msg.data!.message.toString(),
                          notificationTime: msg.timeAgo.toString(),
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
              ),
            );
          }
        });
  }

  @override
  bool get wantKeepAlive => true;
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
