import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent-tab-view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/edit_info.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/get_profile_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/uplload_profileimage.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_view_widget.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../../Data/model/profile/res/profile_res.dart';
import '../../../components/app text theme/app_text_theme.dart';
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
  final List<String> _gender = ['male', 'female'];

  String val = 'female';
  Gender gender = Gender.female;
  String? _radioSelected;

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(getProfileProvider);

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
      success: (ProfileRes? value) {
        final firstName = value!.data!.user!.firstName!.split(" ")[0];
        final secondName = value.data!.user!.lastName!.split(" ")[0];

        // String date = value.data!.user!.dateOfBirth.toString();
        // String transactionDate = DateFormat(' d, MMM yyyy').format(date);

        // String dob = DateFormat('dd-MM-yyyy')
        //     .format(DateTime.tryParse(date.toString())!);

        return GenericWidget(
          appbar: Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
            child: Column(
              children: [
                Space(20.h),
                Row(
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
                const UploadImage(),
                // CircleAvatar(
                //   radius: 50.0.r,
                //   backgroundImage: const AssetImage(
                //     AppImage.image1,
                //   ),
                // ),
                Space(20.h),
                Text(
                  firstName.inCaps + " " + secondName.inCaps,
                  style: AppText.body2(context, Colors.white, 25.sp),
                ),
              ],
            ),
          ),
          bgColor: AppColors.whiteColor,
          child: SizedBox(
            height: 660.h,
            child: Padding(
              padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 55.h),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PersonalInfoCard(
                      color: Colors.black,
                      title: 'First Name',
                      subTitle: value.data!.user!.firstName == null
                          ? "Unavailable"
                          : firstName.inCaps,
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
                      subTitle: value.data!.user!.lastName == null
                          ? "Unavailable"
                          : secondName.inCaps,
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
                      subTitle: value.data!.user!.email == null
                          ? "Unavailable"
                          : value.data!.user!.email.toString(),
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
                      subTitle: value.data!.user!.phoneNumber == null
                          ? "Unavailable"
                          : value.data!.user!.phoneNumber.toString(),
                    ),
                    Space(7.h),
                    const Divider(
                      color: Colors.black,
                      thickness: 0.4,
                    ),
                    Space(30.h),
                    PersonalInfoCard(
                      color: Colors.black,
                      title: 'Date of Birth',
                      subTitle: value.data!.user!.dateOfBirth == null
                          ? "Unavailable"
                          : DateFormat(' d, MMM yyyy').format(DateTime.tryParse(
                              value.data!.user!.dateOfBirth)!),
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
                                        value: value.data!.user!.gender ?? sex,
                                        groupValue: sex,
                                        onChanged: (value) {},
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
                    PersonalInfoCard(
                      color: Colors.black,
                      title: 'Address',
                      subTitle: value.data!.user!.address == null
                          ? "Unavailable"
                          : value.data!.user!.address.toString(),
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
                      subTitle: value.data!.user!.countryName == null
                          ? "Unavailable"
                          : value.data!.user!.countryName.toString(),
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
        );
      },
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
