import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/database/user_database.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/extension/string_extension.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent_tab_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/edit_info.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/profile_image/profile_image.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/get_profile_vm.dart';

import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../components/app text theme/app_text_theme.dart';
import 'widget/profile_methods.dart';
import 'widget/personal_info.dart';

enum Gender {
  male,
  female,
}

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${substring(1)}';
}

class PersonalInfo extends StatefulHookConsumerWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends ConsumerState<PersonalInfo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userValue = ref.watch(userProfileProvider).value;

    return Scaffold(
      backgroundColor: AppColors.appColor,
      appBar: AppBar(
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: const BackButton(color: Colors.white),
        actions: [
          TextButton(
              child: Text(
                'Edit',
                style: AppText.body2(context, Colors.white, 20.sp),
              ),
              onPressed: () {
                pushNewScreen(context,
                    screen: EditInfo(
                      userValue: userValue!,
                    ),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino);
              }),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     InkWell(
                  //       onTap: (() => Navigator.pop(context)),
                  //       child: const Icon(
                  //         Icons.arrow_back_ios_outlined,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //     const Spacer(),
                  //     TextButton(
                  //         child: Text(
                  //           'Edit',
                  //           style: AppText.body2(context, Colors.white, 20.sp),
                  //         ),
                  //         onPressed: () {
                  //           pushNewScreen(context,
                  //               screen: EditInfo(
                  //                 userValue: userValue!,
                  //               ),
                  //               pageTransitionAnimation:
                  //                   PageTransitionAnimation.fade);
                  //         }),
                  //   ],
                  // ),
                  const ProfileImage(
                    ignoreClick: false,
                    hasIcon: true,
                  ),
                  Space(10.h),
                  Text(
                    userName(userValue?.data.user.firstName!.capitalize(),
                        userValue?.data.user.lastName!.capitalize()),
                    style: AppText.body2(context, Colors.white, 25.sp),
                  ),
                  Space(5.h),
                ],
              ),
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(45.r)),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 50.h),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  child: ValueListenableBuilder<Box>(
                      valueListenable:
                          Hive.box<UserDataBase>("user").listenable(),
                      builder: (context, box, _) {
                        final user =
                            box.values.toList().cast<UserDataBase>().first;

                        return Column(
                          children: [
                            PersonalInfoCard(
                              color: Colors.black,
                              title: 'First Name',
                              subTitle: user.firstName.toString().capitalize(),
                            ),
                            Space(7.h),
                            const Divider(
                              color: Colors.black,
                              thickness: 0.4,
                            ),
                            Space(30.h),
                            PersonalInfoCard(
                              color: Colors.black,
                              title: 'Last Name',
                              subTitle: user.lastName.toString().capitalize(),
                            ),
                            Space(7.h),
                            const Divider(
                              color: Colors.black,
                              thickness: 0.4,
                            ),
                            Space(30.h),
                            PersonalInfoCard(
                              color: Colors.black,
                              title: 'Email',
                              subTitle: user.email.toString(),
                            ),
                            Space(7.h),
                            const Divider(
                              color: Colors.black,
                              thickness: 0.4,
                            ),
                            Space(30.h),
                            PersonalInfoCard(
                                color: Colors.black,
                                title: 'Phone Number',
                                subTitle: user.phoneNumer.toString()),
                            Space(7.h),
                            const Divider(
                              color: Colors.black,
                              thickness: 0.4,
                            ),
                            Space(30.h),
                            PersonalInfoCard(
                                color: Colors.black,
                                title: 'Date of Birth',
                                subTitle: date(user.dateOfBirth)
                                // ? "Unavailable"

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
                            ///
                            Space(30.h),
                            PersonalInfoCard(
                              color: Colors.black,
                              title: 'Gender',
                              subTitle: user.gender.toString(),
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

                            Space(30.h),
                            PersonalInfoCard(
                              color: Colors.black,
                              title: 'Address',
                              subTitle: user.address.toString(),
                            ),
                            Space(7.h),
                            const Divider(
                              color: Colors.black,
                              thickness: 0.4,
                            ),
                            Space(30.h),
                            PersonalInfoCard(
                              color: Colors.black,
                              title: 'Country',
                              subTitle: user.country.toString(),
                            ),
                            Space(7.h),
                            const Divider(
                              color: Colors.black,
                              thickness: 0.4,
                            ),
                            Space(60.h),
                          ],
                        );
                      }),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class UserAvatar extends StatelessWidget {
  final String initials;
  final String? imageUrl;

  final double radius;
  final double initialsSize;

  const UserAvatar({
    Key? key,
    this.radius = 20,
    this.initialsSize = 20,
    required this.initials,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return CircleAvatar(
      radius: radius,
      backgroundColor: const Color(0xfff5f5f5),
      backgroundImage: null,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: CachedNetworkImage(
          imageUrl: imageUrl ?? '',
          imageBuilder: (context, imageProvider) => Container(
            width: 120.0,
            height: 120.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          progressIndicatorBuilder: (_, __, ___) => const SizedBox(
            height: 5,
            width: 5,
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Text(
            initials,
            style: themeData.textTheme.caption!.copyWith(
              fontSize: initialsSize,
              color: const Color(0xff6F7070),
            ),
          ),
        ),
      ),
    );
  }
}
