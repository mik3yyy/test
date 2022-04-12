import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/vm/get_currency_vm.dart';

import '../../../components/app text theme/app_text_theme.dart';
import '../../../components/color/value.dart';

Future<dynamic> currencyBuild(
    BuildContext context, TextEditingController controller) {
  return showDialog(
    useSafeArea: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Center(
        child: Column(
          children: [
            Text(
              "Select Currency",
              style: AppText.header2(context, AppColors.appColor, 20.sp),
              textAlign: TextAlign.center,
            ),
            Divider(
              height: 10.h,
              thickness: 1,
            ),
            Divider(
              height: 10.h,
              thickness: 1,
            ),
          ],
        ),
      ),
      content: HookConsumer(
        builder: ((context, ref, child) {
          final vm = ref.watch(getCurrencyProvider);
          return vm.when(
            error: (Object error, StackTrace stackTrace) {
              return Center(
                child: Text(error.toString()),
              );
            },
            idle: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            success: (value) {
              return SizedBox(
                height: 600.h,
                width: double.maxFinite,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: value!.data!.currencies!.length,
                  itemBuilder: (BuildContext context, int index) {
                    final currency = value.data!.currencies![index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                            currency.name.toString(),
                            style: AppText.header2(
                                context, AppColors.appColor, 20.sp),
                            textAlign: TextAlign.center,
                          ),
                          onTap: () {
                            controller.text = currency.code.toString();
                            Navigator.pop(context);
                          },
                        ),
                        Divider(
                          height: 10.h,
                          thickness: 1,
                        ),
                      ],
                    );
                  },
                ),
              );
            },
          );
        }),
      ),
    ),
  );
}
