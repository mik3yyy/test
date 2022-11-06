import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:kayndrexsphere_mobile/Data/services/notification/withdrawal_request/withdrawal_req.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/notification/viewmodel/request_withdrawal_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class RequestNotificationTabBarView extends StatefulHookConsumerWidget {
  const RequestNotificationTabBarView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RequestNotificationTabBarViewState();
}

class _RequestNotificationTabBarViewState
    extends ConsumerState<RequestNotificationTabBarView>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    // final request = ref.watch(getWithdrawalNotificationProvider);

    final _remoteReqNots = ref.watch(remoteReqNotificationListProvider);
    final _notification = ref.watch(notificationReqSearchInputProvider);
    return _remoteReqNots.when(
        data: (data) {
          if (_notification.value == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (data.data.withdrawals.isEmpty) {
            return const Center(child: Text("No Notifications"));
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                ref.refresh(remoteReqNotificationListProvider);
              },
              child: SizedBox(
                height: 450.h,
                child: Scrollbar(
                  isAlwaysShown: true,
                  controller: _scrollController,
                  child: ListView.separated(
                    controller: _scrollController,
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    itemCount: _notification.value!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final notifications = _notification.value![index];

                      return Padding(
                        padding: const EdgeInsets.only(right: 32.0),
                        child: AllNotificationBuild(
                          data: notifications,
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
              ),
            );
          }
        },
        error: (e, s) {
          return Center(
            child: TextButton.icon(
                onPressed: () {
                  ref.refresh(remoteReqNotificationListProvider);
                },
                icon: const Icon(Icons.replay),
                label: const Text("Retry")),
          );
        },
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
  }

  @override
  bool get wantKeepAlive => true;
}

class AllNotificationBuild extends StatelessWidget {
  final Withdrawal? data;

  // final Color color;
  const AllNotificationBuild({
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime date = data!.createdAt!;
    String dateCreated = DateFormat(' d, MMM yyyy').format(date);
    String createdTime = DateFormat.jm().format(date);
    var formatter = NumberFormat('###,000');
    Color statusColor() {
      if (data!.status == "pending") {
        return Colors.blue;
      }
      if (data!.status == "success") {
        return Colors.green;
      }
      if (data!.status == "failed") {
        return Colors.red;
      } else {
        return Colors.grey;
      }
    }

    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Request to withdraw ${data!.currencyCode} ${formatter.format(data!.amount)}",
              style: AppText.body3(
                context,
                AppColors.appColor,
              ),
            ),
            Space(10.h),
            Row(
              children: [
                Text(
                  createdTime,
                  style: AppText.body3(
                    context,
                    AppColors.appColor.withOpacity(0.4),
                  ),
                ),
                Text(
                  dateCreated,
                  style: AppText.body3(
                    context,
                    AppColors.appColor.withOpacity(0.4),
                  ),
                ),
              ],
            ),
          ],
        ),
        const Spacer(),
        Container(
          padding: EdgeInsets.fromLTRB(6.w, 2.w, 6.w, 2.w),
          width: 50.w,
          height: 18.h,
          decoration: BoxDecoration(
              color: statusColor(), borderRadius: BorderRadius.circular(6.r)),
          child: Center(
            child: Text(
              data!.status.toString(),
              style: AppText.body2(
                context,
                AppColors.whiteColor,
                12.h,
              ),
            ),
          ),
        ),
      ],
    );
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
