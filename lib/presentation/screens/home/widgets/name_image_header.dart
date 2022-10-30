import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/database/user/user_database.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/res/profile_res.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/profile_image/profile_image.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import 'package:kayndrexsphere_mobile/presentation/components/extension/string_extension.dart';

import '../../../components/app text theme/app_text_theme.dart';

class NameAndImageHeader extends StatelessWidget {
  const NameAndImageHeader({
    Key? key,
    required this.defaultWallet,
    required this.savedUser,
  }) : super(key: key);

  final AsyncValue<ProfileRes> defaultWallet;
  final UserDataBase savedUser;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Hi ${defaultWallet.maybeMap(data: (v) => v.value.data.user.firstName?.capitalize(), orElse: () => savedValue(savedUser.firstName))}',
              style: AppText.header1(context, Colors.white, 25.sp),
            ),
            Space(10.h),
          ],
        ),
        const Spacer(),
        const ProfileImage(
            height: 50,
            width: 50,
            avatar: 30,
            ignoreClick: true,
            hasIcon: false),
        Space(10.w),
      ],
    );
  }
}

String savedValue(String? value) {
  if (value == null) {
    return "";
  } else {
    return value;
  }
}
