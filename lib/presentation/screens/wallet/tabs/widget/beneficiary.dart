import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/user_saved_beneficary_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import 'package:skeletons/skeletons.dart';

import '../../../../components/app text theme/app_text_theme.dart';

class BeneficiaryView extends StatefulHookConsumerWidget {
  final TextEditingController accountNoController;
  final TextEditingController friendNameController;
  const BeneficiaryView(
      {Key? key,
      required this.accountNoController,
      required this.friendNameController})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BeneficiaryViewState();
}

class _BeneficiaryViewState extends ConsumerState<BeneficiaryView> {
  @override
  Widget build(BuildContext context) {
    final beneficiaryVm = ref.watch(usersavedWalletBeneficirayProvider);
    return beneficiaryVm.maybeWhen(
        data: (value) {
          return value.data!.walletBeneficiaries!.isEmpty
              ? const SizedBox.shrink()
              : Container(
                  color: AppColors.appColor.withOpacity(0.09),
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Space(10.h),
                        SizedBox(
                          // color: Colors.red,
                          height: 100,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: value.data!.walletBeneficiaries!.length,
                            itemBuilder: (context, index) {
                              final item =
                                  value.data!.walletBeneficiaries![index];

                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        widget.accountNoController.text =
                                            item.beneficiary!.accountNumber!;
                                        widget.friendNameController.text =
                                            '${item.beneficiary!.firstName} ${item.beneficiary!.lastName}';
                                      });
                                    },
                                    child: Container(
                                      height: 80.h,
                                      width: 80.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey.shade100,
                                      ),
                                      child: Center(
                                          child: Text(
                                        '${item.beneficiary!.firstName?[0]}',
                                        style: AppText.body2(
                                            context,
                                            AppColors.appColor.withOpacity(0.5),
                                            40.sp),
                                      )),
                                    ),
                                  ),
                                  Space(10.h),
                                  Expanded(
                                    child: Text(
                                      '${item.beneficiary!.firstName} ${item.beneficiary!.lastName}',
                                      style: AppText.body2(
                                          context, AppColors.appColor, 16.sp),
                                    ),
                                  ),
                                ],
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(width: 20.w);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        },
        // error: (Object error, StackTrace? stackTrace) {
        //   return Text(error.toString());
        // },
        loading: () => const LoadingBeneficiary(),
        orElse: () => const LoadingBeneficiary());
  }
}

class LoadingBeneficiary extends StatelessWidget {
  const LoadingBeneficiary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.appColor.withOpacity(0.09),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          // color: Colors.red,
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, index) {
              return SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  shape: BoxShape.circle,
                  height: 80.h,
                  width: 80.w,
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(width: 20.w);
            },
          ),
        ),
      ),
    );
  }
}
