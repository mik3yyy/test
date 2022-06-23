import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent-tab-view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/personal_info.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/security/security.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/transaction_information/transaction_information_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/upload_id.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/get_profile_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/safepay/safepay_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_view_widget.dart';
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
    final vm = ref.watch(getProfileProvider);

    return GenericWidget(
      appbar: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
        child: Column(
          children: [
            Space(20.h),
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
                Space(15.w),
              ],
            ),

            vm.maybeWhen(success: (data) {
              return CircleAvatar(
                radius: 50.0.r,
                backgroundImage: data!.data!.user!.profilePicture == ""
                    ? const AssetImage("images/person.png")
                    : AssetImage(data.data!.user!.profilePicture),

                // const AssetImage(
                //   AppImage.image1,
                // ),
              );
            }, orElse: () {
              return CircleAvatar(
                radius: 50.0.r,
                backgroundImage: const AssetImage("images/person.png"),

                // const AssetImage(
                //   AppImage.image1,
                // ),
              );
            }),

            Space(20.h),
            Text(
              vm.maybeWhen(
                  success: (v) =>
                      '${v!.data!.user!.firstName} ${v.data!.user!.lastName}',
                  orElse: () => ''),
              // firstName.inCaps + " " + secondName.inCaps,
              style: AppText.body2(context, Colors.white, 25.sp),
            ),

            // vm.when(error: (Object error, StackTrace stackTrace) {
            //   return Center(
            //     child: Text(error.toString()),
            //   );
            // }, loading: () {
            //   return const CircularProgressIndicator();
            // }, idle: () {
            //   return const CircularProgressIndicator();
            // }, success: (value) {
            //   final firstName = value!.data!.user!.firstName!.split(" ")[0];
            //   final secondName = value.data!.user!.lastName!.split(" ")[0];

            // return Text(
            //   firstName.inCaps + " " + secondName.inCaps,
            //   style: AppText.body2(context, Colors.white, 25.sp),
            // );
            // })
            // const WalletOptionList()
          ],
        ),
      ),
      bgColor: AppColors.whiteColor,
      child: SizedBox(
        height: 660.h,
        child: Padding(
          padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 55.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileCard(
                  color: Colors.black,
                  title: 'Personal information',
                  subTitle: 'See and edit your personal information',
                  image: AppImage.profile,
                  onPressed: () {
                    pushNewScreen(context,
                        screen: const PersonalInfo(),
                        pageTransitionAnimation: PageTransitionAnimation.fade);
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
                  subTitle: 'Verify yourself by providing an ID',
                  image: AppImage.upload,
                  onPressed: () {
                    pushNewScreen(context,
                        screen: UploadID(),
                        pageTransitionAnimation: PageTransitionAnimation.fade);
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
                  title: 'Transaction information',
                  subTitle: 'Edit your saved bank /card details Security',
                  image: AppImage.transactionInfo,
                  onPressed: () {
                    pushNewScreen(
                      context,
                      screen: const TransactionInformationScreen(),
                      pageTransitionAnimation: PageTransitionAnimation.fade,
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
                  title: 'Security',
                  subTitle: 'Change your passwords at any time',
                  image: AppImage.security,
                  onPressed: () {
                    pushNewScreen(
                      context,
                      screen: const SecurityScreen(),
                      pageTransitionAnimation: PageTransitionAnimation.fade,
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
                  image: AppImage.deactivate,
                  onPressed: () {
                    pushNewScreen(
                      context,
                      screen: const SafePayScreen(),
                      pageTransitionAnimation: PageTransitionAnimation.fade,
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
      ),
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
    // const hoverColor = Colors.white;
    return InkWell(
      onTap: onPressed,
      // hoverColor: hoverColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset(
            image,
            color: color,
            height: 20.h,
            width: 20.w,
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
    );
  }
}
