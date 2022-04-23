import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent-tab-view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/edit_info.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_view_widget.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../components/app image/app_image.dart';
import '../../../components/app text theme/app_text_theme.dart';
import 'widget/personal_info.dart';

class PersonalInfo extends StatefulHookConsumerWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends ConsumerState<PersonalInfo> {
  final List<String> _gender = ['Male', 'Female'];

  String val = 'Male';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WalletViewWidget(
        appBar: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
          child: Column(
            children: [
              Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: (() => Navigator.pop(context)),
                    child: const Icon(
                      Icons.arrow_back_ios_outlined,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      pushNewScreen(context,
                          screen: const EditInfo(),
                          pageTransitionAnimation:
                              PageTransitionAnimation.fade);
                    },
                    child: Text(
                      'Edit',
                      style: AppText.body2(context, Colors.white, 20.sp),
                    ),
                  ),
                ],
              ),
              CircleAvatar(
                radius: 50.0.r,
                backgroundImage: const AssetImage(
                  AppImage.image1,
                ),
              ),
              Space(20.h),
              Text(
                'Dave Willow',
                style: AppText.body2(context, Colors.white, 25.sp),
              ),
            ],
          ),
        ),
        child: SizedBox(
          height: 650.h,
          child: Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 55.h),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PersonalInfoCard(
                    color: Colors.black,
                    title: 'First Name',
                    subTitle: 'First Name',
                  ),
                  Space(7.h),
                  const Divider(
                    color: Colors.black,
                    thickness: 0.4,
                  ),
                  Space(30.h),
                  const PersonalInfoCard(
                    color: Colors.black,
                    title: 'Last Name',
                    subTitle: 'Last Name',
                  ),
                  Space(7.h),
                  const Divider(
                    color: Colors.black,
                    thickness: 0.4,
                  ),
                  Space(30.h),
                  const PersonalInfoCard(
                    color: Colors.black,
                    title: 'Email',
                    subTitle: 'Email',
                  ),
                  Space(7.h),
                  const Divider(
                    color: Colors.black,
                    thickness: 0.4,
                  ),
                  Space(30.h),
                  const PersonalInfoCard(
                    color: Colors.black,
                    title: 'Phone Number',
                    subTitle: 'Phone Number',
                  ),
                  Space(7.h),
                  const Divider(
                    color: Colors.black,
                    thickness: 0.4,
                  ),
                  Space(30.h),
                  const PersonalInfoCard(
                    color: Colors.black,
                    title: 'Date of Birth',
                    subTitle: 'Date of Birth',
                  ),
                  Space(7.h),
                  const Divider(
                    color: Colors.black,
                    thickness: 0.4,
                  ),

                  ///
                  ///
                  ///
                  ///
                  Row(
                    children: [
                      Text(
                        'Gender',
                        style: AppText.body2(context, Colors.black, 19.sp),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 60.h,
                          width: 50,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _gender.length,
                              itemBuilder: (context, index) {
                                final sex = _gender[index];

                                return Row(
                                  children: [
                                    Space(15.w),
                                    Radio<String>(
                                      value: val,
                                      groupValue: sex,
                                      onChanged: (value) {
                                        setState(() {
                                          val = value!;
                                        });
                                      },
                                    ),
                                    Text(
                                      sex,
                                      style: AppText.body2(
                                          context, Colors.black, 19.sp),
                                    ),
                                  ],
                                );
                              }),
                        ),
                      ),
                    ],
                  ),

                  ///
                  ///
                  ///
                  ///

                  Space(30.h),
                  const PersonalInfoCard(
                    color: Colors.black,
                    title: 'Address',
                    subTitle: 'Address',
                  ),
                  Space(7.h),
                  const Divider(
                    color: Colors.black,
                    thickness: 0.4,
                  ),
                  Space(30.h),
                  const PersonalInfoCard(
                    color: Colors.black,
                    title: 'Country',
                    subTitle: 'Country',
                  ),
                  Space(7.h),
                  const Divider(
                    color: Colors.black,
                    thickness: 0.4,
                  ),
                  Space(80.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
