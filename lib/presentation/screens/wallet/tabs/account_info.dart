import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class AccounInfoTab extends StatelessWidget {
  const AccounInfoTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 15.h),
      child: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                  height: 55.h,
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.r),
                          ),
                        ),
                        filled: true,
                        hintStyle:
                            AppText.body2(context, Colors.black26, 19.sp),
                        hintText: "Search account number",
                        suffixIcon: const Icon(Icons.search),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: -4.h, horizontal: 10.w),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: AppColors.appColor),
                          borderRadius: BorderRadius.circular(25.7),
                        ),
                        fillColor: Colors.transparent),
                  )),
              Space(10.h),
              Container(
                height: 50.h,
                width: MediaQuery.of(context).size.width,
                color: AppColors.appColor.withOpacity(0.05),
                child: Center(
                  child: Text(
                    'Dollar exchange rate (\$1)',
                    style: AppText.header2(context, Colors.black38, 20.sp),
                  ),
                ),
              ),
              Container(
                height: 50.h,
                width: MediaQuery.of(context).size.width,
                color: AppColors.appColor.withOpacity(0.2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 30.h,
                          width: 30.w,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(width: 2, color: Colors.black)),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 2.5),
                            child: Center(
                              child: Text(
                                'N',
                                textAlign: TextAlign.center,
                                style: AppText.header2(
                                    context, AppColors.appColor, 20.sp),
                              ),
                            ),
                          ),
                        ),
                        Space(7.w),
                        Padding(
                          padding: const EdgeInsets.only(top: 2.5),
                          child: Text(
                            '450',
                            style: AppText.header2(
                                context, AppColors.appColor, 20.sp),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 30.h,
                          width: 30.w,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(width: 2, color: Colors.black)),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 2.5),
                            child: Center(
                              child: Text(
                                'E',
                                style: AppText.header2(
                                    context, AppColors.appColor, 20.sp),
                              ),
                            ),
                          ),
                        ),
                        Space(7.w),
                        Padding(
                          padding: const EdgeInsets.only(top: 2.5),
                          child: Text(
                            '130',
                            style: AppText.header2(
                                context, AppColors.appColor, 20.sp),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 30.h,
                          width: 30.w,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(width: 2, color: Colors.black)),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 2.5),
                            child: Center(
                              child: Text(
                                'E',
                                style: AppText.header2(
                                    context, AppColors.appColor, 20.sp),
                              ),
                            ),
                          ),
                        ),
                        Space(7.w),
                        Padding(
                          padding: const EdgeInsets.only(top: 2.5),
                          child: Text(
                            '100',
                            style: AppText.header2(
                                context, AppColors.appColor, 20.sp),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

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
                        width: 260.w,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Amount Transferred',
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
                                  'Recipient Name',
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
                        width: 260.w,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Amount Transferred',
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
                                  'Recipient Name',
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
      ),
    );
  }
}
