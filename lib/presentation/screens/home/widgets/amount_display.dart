import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:kayndrexsphere_mobile/Data/database/user/user_database.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/res/profile_res.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/widgets/user_wallets.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/name_image_header.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../components/app text theme/app_text_theme.dart';

class AmountDisplay extends StatefulHookConsumerWidget {
  final AsyncValue<ProfileRes> defaultWallet;
  final UserDataBase savedUser;
  final TextEditingController currency;
  final bool isBackGround;
  const AmountDisplay(
      {Key? key,
      required this.defaultWallet,
      required this.savedUser,
      this.isBackGround = false,
      required this.currency})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AmountDisplayState();
}

class _AmountDisplayState extends ConsumerState<AmountDisplay> {
  final toggleAmountProvider =
      StateProvider<bool>((ref) => PreferenceManager.revealBalance);
  @override
  Widget build(BuildContext context) {
    final toggleAmount = ref.watch(toggleAmountProvider.state);
    var formatter = NumberFormat("#,##0.00");
    return Container(
      height: 150.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: AppColors.bottomSheet,
      ),
      child: Column(
        children: [
          const Space(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              widget.defaultWallet.maybeWhen(data: (data) {
                return Text(
                  '${data.data.defaultWallet.currencyCode.toString()} wallet',
                  style: AppText.header2(context, AppColors.appColor, 18.sp),
                );
              }, orElse: () {
                return Text(
                  "${savedValue(widget.savedUser.countryCode)} wallet",
                  style: AppText.header2(context, AppColors.appColor, 18.sp),
                );
              }),
              SelectWalletList(
                currency: widget.currency,
                routeName: "homeScreen",
              ),
              Space(85.w),
              InkWell(
                onTap: () {
                  toggleAmount.state = !toggleAmount.state;
                  PreferenceManager.revealBalance = toggleAmount.state;
                },
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Icon(
                    PreferenceManager.revealBalance
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: PreferenceManager.revealBalance
                        ? AppColors.appColor
                        : Colors.grey.shade400,
                    size: 20,
                  ),
                ),
              ),
              Space(20.w)
            ],
          ),
          const Space(15),
          (PreferenceManager.revealBalance) || (widget.isBackGround)
              ? Text(
                  '****',
                  style: AppText.header1(context, AppColors.appColor, 40.sp),
                )
              : Text(
                  widget.defaultWallet.maybeWhen(
                      data: (v) =>
                          '${v.data.defaultWallet.currencyCode.toString()} ${formatter.format(num.tryParse(v.data.defaultWallet.balance ?? "0.0"))}',
                      orElse: () =>
                          '${widget.savedUser.countryCode ?? ""} ${formatter.format(num.tryParse(widget.savedUser.balance ?? "0.0"))}'),
                  style: AppText.header1(context, AppColors.appColor, 40.sp),
                ),
          Space(8.h),
          Text(
            'Kayndrexsphere Account Number: ${widget.defaultWallet.maybeWhen(data: (v) => v.data.user.accountNumber, orElse: () => widget.savedUser.accountNumber ?? "0000")}',
            style: AppText.body2(context, AppColors.appColor, 17.sp),
          ),
        ],
      ),
    );
  }
}
