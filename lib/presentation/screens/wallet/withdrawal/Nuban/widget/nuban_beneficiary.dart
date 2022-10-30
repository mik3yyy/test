import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/Nuban/nuban_view_model.dart/get_beneficiary_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../../../components/app text theme/app_text_theme.dart';

class NubanBeneficiary extends StatefulHookConsumerWidget {
  final TextEditingController accountName;
  final ValueNotifier<String> acctName;
  final TextEditingController accountNumber;
  final TextEditingController bankName;
  final TextEditingController bankCode;
  const NubanBeneficiary(
      {Key? key,
      required this.accountName,
      required this.accountNumber,
      required this.bankCode,
      required this.acctName,
      required this.bankName})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NubanBeneficiaryState();
}

class _NubanBeneficiaryState extends ConsumerState<NubanBeneficiary> {
  @override
  Widget build(BuildContext context) {
    final beneficiaryVm = ref.watch(nubanBeneficiaryProvider);
    return beneficiaryVm.when(
      data: (value) {
        return value.data!.beneficiaries!.isEmpty
            ? const SizedBox.shrink()
            : Container(
                color: AppColors.appColor.withOpacity(0.09),
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Space(10.h),
                      SizedBox(
                        // color: Colors.red,
                        height: 100,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: value.data!.beneficiaries!.length,
                          itemBuilder: (context, index) {
                            final user = value.data!.beneficiaries![index];

                            String beneficiary() {
                              final name = user.accountName;

                              final newName = name?.split(" ");
                              final userName =
                                  "${newName?.first} ${newName?.last}";
                              return userName;
                            }

                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      widget.acctName.value =
                                          user.accountName.toString();
                                      widget.accountName.text =
                                          user.accountName.toString();
                                      widget.accountNumber.text =
                                          user.accountNumber.toString();
                                      widget.bankName.text =
                                          user.bankName.toString();
                                      widget.bankCode.text =
                                          user.bankCode.toString();
                                      // accountNoController.text = item
                                      //     .beneficiary!.accountNumber!;
                                      // friendNameController.text =
                                      //     '${item.beneficiary!.firstName} ${item.beneficiary!.lastName}';
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
                                      '${user.accountName?[0]}',
                                      style: AppText.body2(
                                          context, Colors.black45, 40.sp),
                                    )),
                                  ),
                                ),
                                Space(10.h),
                                Text(
                                  beneficiary(),
                                  style: AppText.body2(
                                      context, Colors.black, 16.sp),
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(width: 20.w);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
      },
      error: (Object error, StackTrace? stackTrace) {
        return Text(error.toString());
      },
      loading: () {
        //When enpoint is loading, it should display default ideas with overlay loading
        return const Center(
          child: CircularProgressIndicator(
            color: AppColors.appBgColor,
          ),
        );
      },
    );
  }
}
