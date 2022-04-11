import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class AccounInfoTab extends StatelessWidget {
  const AccounInfoTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        child: Column(
          children: [
            SizedBox(
                height: 55.h,
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25.r),
                        ),
                      ),
                      filled: true,
                      hintStyle: AppText.body2(context, Colors.black26, 19.sp),
                      hintText: "Search account number",
                      suffixIcon: const Icon(Icons.search),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: -4.h, horizontal: 10.w),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColors.appColor),
                        borderRadius: BorderRadius.circular(25.7),
                      ),
                      fillColor: Colors.transparent),
                )),
            Space(10.h),

            //* Successful card

            Container(
              margin: EdgeInsets.only(top: 15.h, bottom: 15.h),
              height: 220.h,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    stops: [0.10, 0.1],
                    colors: [Colors.greenAccent, Colors.white]),
                border: Border.all(width: 1, color: const Color(0xffDDDDDD)),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 23.w, right: 9.w),
                child: Row(
                  children: [
                    SizedBox(
                      width: 240.w,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Amount\nTransferred',
                                style: AppText.body2(
                                    context, AppColors.appColor, 17.sp),
                              ),
                              const Spacer(),
                              Text(
                                '\$ 20000',
                                style: AppText.body2(
                                    context, AppColors.appColor, 17.sp),
                              )
                            ],
                          ),
                          Space(
                            20.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Recipient\nName',
                                style: AppText.body2(
                                    context, AppColors.appColor, 17.sp),
                              ),
                              const Spacer(),
                              Text(
                                'Folashade Kemi',
                                style: AppText.body2(
                                    context, AppColors.appColor, 17.sp),
                              )
                            ],
                          ),
                          Space(
                            20.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Acc.No',
                                style: AppText.body2(
                                    context, AppColors.appColor, 17.sp),
                              ),
                              const Spacer(),
                              Text(
                                '3422358973',
                                style: AppText.body2(
                                    context, AppColors.appColor, 17.sp),
                              )
                            ],
                          ),
                          Space(
                            20.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Date',
                                style: AppText.body2(
                                    context, AppColors.appColor, 17.sp),
                              ),
                              const Spacer(),
                              Text(
                                '12 April 2022',
                                style: AppText.body2(
                                    context, AppColors.appColor, 17.sp),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    RotatedBox(
                      quarterTurns: -1,
                      child: Text(
                        'Successful',
                        style:
                            AppText.body2(context, AppColors.appColor, 17.sp),
                      ),
                    )
                  ],
                ),
              ),
            ),

            // Space(10.h),

            //* Failed card

            Container(
              margin: EdgeInsets.only(top: 15.h, bottom: 15.h),
              height: 220.h,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    stops: [0.10, 0.1],
                    colors: [Colors.red, Colors.white]),
                border: Border.all(width: 1, color: const Color(0xffDDDDDD)),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 23.w, right: 9.w),
                child: Row(
                  children: [
                    SizedBox(
                      width: 240.w,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Amount\nTransferred',
                                style: AppText.body2(
                                    context, AppColors.appColor, 17.sp),
                              ),
                              const Spacer(),
                              Text(
                                '\$ 20000',
                                style: AppText.body2(
                                    context, AppColors.appColor, 17.sp),
                              )
                            ],
                          ),
                          Space(
                            20.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Recipient\nName',
                                style: AppText.body2(
                                    context, AppColors.appColor, 17.sp),
                              ),
                              const Spacer(),
                              Text(
                                'Folashade Kemi',
                                style: AppText.body2(
                                    context, AppColors.appColor, 17.sp),
                              )
                            ],
                          ),
                          Space(
                            20.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Acc.No',
                                style: AppText.body2(
                                    context, AppColors.appColor, 17.sp),
                              ),
                              const Spacer(),
                              Text(
                                '3422358973',
                                style: AppText.body2(
                                    context, AppColors.appColor, 17.sp),
                              )
                            ],
                          ),
                          Space(
                            20.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Date',
                                style: AppText.body2(
                                    context, AppColors.appColor, 17.sp),
                              ),
                              const Spacer(),
                              Text(
                                '12 April 2022',
                                style: AppText.body2(
                                    context, AppColors.appColor, 17.sp),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    RotatedBox(
                      quarterTurns: -1,
                      child: Text(
                        'Failed',
                        style:
                            AppText.body2(context, AppColors.appColor, 17.sp),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
