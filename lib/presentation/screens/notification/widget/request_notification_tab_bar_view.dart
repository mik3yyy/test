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
  const RequestNotificationTabBarView({Key? key}) : super(key: key);

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
    final request = ref.watch(getWithdrawalNotificationProvider);

    return request.when(
        error: (error, stackTrace) => Text(error.toString()),
        idle: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
        loading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
        success: (data) {
          if (data!.data!.withdrawals!.isEmpty) {
            return Center(
              child: Text(
                "You have notification",
                style: AppText.body3(
                  context,
                  AppColors.appColor,
                ),
              ),
            );
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                ref.refresh(getWithdrawalNotificationProvider);
              },
              child: SizedBox(
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
                    itemCount: data.data!.withdrawals!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final notification = data.data!.withdrawals![index];

                      return Padding(
                        padding: const EdgeInsets.only(right: 32.0),
                        child: AllNotificationBuild(
                          data: notification,
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
        });
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
            Space(7.h),
            Row(
              children: [
                Text(
                  createdTime,
                  style: AppText.body3(
                    context,
                    AppColors.appColor,
                  ),
                ),
                Text(
                  dateCreated,
                  style: AppText.body3(
                    context,
                    AppColors.appColor,
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
