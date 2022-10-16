import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/extension/string_extension.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent_tab_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/deactivate_account/deactivate_account.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/personal_info.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/profile_image/profile_image.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/security/security.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/view_all_id.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/get_profile_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../components/app image/app_image.dart';
import '../../../components/app text theme/app_text_theme.dart';

class MyProfile extends StatefulHookConsumerWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyProfileState();
}

class _MyProfileState extends ConsumerState<MyProfile> {
  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(userProfileProvider);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
          backgroundColor: AppColors.appColor,
          appBar: AppBar(
            elevation: 0.0,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            automaticallyImplyLeading: false,
            leading: const BackButton(color: Colors.white),
          ),
          body: SafeArea(
            bottom: false,
            child: Column(
              children: [
                Column(
                  children: [
                    const ProfileImage(
                      hasIcon: false,
                      ignoreClick: false,
                    ),
                    Space(10.h),
                    Text(
                      vm.maybeWhen(
                          data: (v) =>
                              '${v.data.user.firstName!.capitalize()} ${v.data.user.lastName!.capitalize()}',
                          orElse: () => ''),
                      style: AppText.body2(context, Colors.white, 25.sp),
                    ),
                    Space(5.h),
                  ],
                ),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(45.r)),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 30.w, right: 30.w, top: 55.h),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProfileCard(
                            color: Colors.black,
                            title: 'Personal information',
                            subTitle: 'See and edit your personal information',
                            image: AppImage.myProfile,
                            onPressed: () {
                              pushNewScreen(context,
                                  screen: const PersonalInfo(),
                                  withNavBar: false,
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.cupertino);
                            },
                          ),
                          Space(10.h),
                          const Divider(
                            color: Colors.black,
                            thickness: 0.4,
                          ),
                          Space(30.h),
                          ProfileCard(
                            color: Colors.black,
                            title: 'Upload ID',
                            subTitle: 'Upload your identification card',
                            image: AppImage.uploadId,
                            onPressed: () {
                              pushNewScreen(context,
                                  screen: const ViewIdentification(),
                                  withNavBar: false,
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.cupertino);
                            },
                          ),
                          Space(10.h),
                          const Divider(
                            color: Colors.black,
                            thickness: 0.4,
                          ),
                          // Space(30.h),
                          // ProfileCard(
                          //   color: Colors.black,
                          //   title: 'Transaction information',
                          //   subTitle:
                          //       'Edit your saved bank /card details Security',
                          //   image: AppImage.transaction,
                          //   onPressed: () {
                          //     pushNewScreen(
                          //       context,
                          //       withNavBar: false,
                          //       screen: const TransactionInformationScreen(),
                          //       pageTransitionAnimation:
                          //           PageTransitionAnimation.cupertino,
                          //     );
                          //   },
                          // ),
                          // Space(10.h),
                          // const Divider(
                          //   color: Colors.black,
                          //   thickness: 0.4,
                          // ),
                          Space(30.h),
                          ProfileCard(
                            color: Colors.black,
                            title: 'Security',
                            subTitle: 'Change your passwords at any time',
                            image: AppImage.securityProfile,
                            onPressed: () {
                              pushNewScreen(
                                context,
                                screen: const SecurityScreen(),
                                withNavBar: false,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                          ),
                          Space(10.h),
                          const Divider(
                            color: Colors.black,
                            thickness: 0.4,
                          ),
                          Space(30.h),
                          ProfileCard(
                            color: Colors.black,
                            title: 'Deactivate account',
                            subTitle: 'You can deactivate your account',
                            image: AppImage.deactivateAccount,
                            onPressed: () {
                              pushNewScreen(
                                context,
                                withNavBar: false,
                                screen: const DeactivateAccount(),
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                          ),
                          Space(10.h),
                          const Divider(
                            color: Colors.black,
                            thickness: 0.4,
                          ),
                        ],
                      ),
                    ),
                  ),
                ))
              ],
            ),
          )),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final String image;
  final Color color;
  final void Function()? onPressed;
  const ProfileCard(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.color,
      required this.onPressed,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const hoverColor = Colors.white;
    return InkWell(
      onTap: onPressed,
      hoverColor: hoverColor,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.05,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              image,
              color: color,
              height: 25,
              width: 25,
            ),
            Space(20.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppText.header2(context, Colors.black, 19.sp),
                ),
                Space(3.h),
                Text(
                  subTitle,
                  style: AppText.body2(context, Colors.black45, 15.sp),
                ),
              ],
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.black38,
              size: 15.sp,
            ),
          ],
        ),
      ),
    );
  }
}
