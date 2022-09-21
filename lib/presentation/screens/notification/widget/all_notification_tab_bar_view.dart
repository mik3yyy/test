import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/notification/viewmodel/get_notification_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class AllNotificationTabBarView extends StatefulHookConsumerWidget {
  const AllNotificationTabBarView({
    Key? key,
  }) : super(key: key);

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
    final remoteNotification = ref.watch(remoteNotificationListProvider);
    final notification = ref.watch(notificationSearchInputProvider);

    return remoteNotification.when(
        data: (data) {
          if (notification.value == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (data.data.notifications.isEmpty) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.13,
                  horizontal: MediaQuery.of(context).size.width * 0.3),
              child: const Text("No Notifications"),
            );
          } else {
            return SizedBox(
              height: 500.h,
              child: Scrollbar(
                isAlwaysShown: true,
                controller: _scrollController,
                child: RefreshIndicator(
                  onRefresh: () async {
                    // ref.refresh(getNotificationProvider);
                    ref.refresh(remoteNotificationListProvider);
                  },
                  child: ListView.separated(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    itemCount: notification.value!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final msg = notification.value![index];
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
        },
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
        error: (e, s) => Text(e.toString()));
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
