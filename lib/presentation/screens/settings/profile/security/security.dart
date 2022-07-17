import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/constant/constant.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/res/profile_res.dart';
import 'package:kayndrexsphere_mobile/presentation/components/AppSnackBar/snackbar/app_snackbar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent-tab-view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/profile.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/security/auth_security/auth_secure.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/security/change_password.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/security/transaction_pin/transaction_pin.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/user_provider.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../../components/app image/app_image.dart';
import '../../../../components/app text theme/app_text_theme.dart';

class SecurityScreen extends StatefulHookConsumerWidget {
  const SecurityScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends ConsumerState<SecurityScreen> {
  final toggleStateProvider = StateProvider<bool>((ref) {
    return false;
  });
  @override
  Widget build(BuildContext context) {
    final user = locator.get<ProfileRes>();

    final bio = PreferenceManager.enableBioMetrics;
    final toggle = ref.watch(toggleStateProvider.state);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Security',
          style: AppText.header2(context, Colors.black, 20.sp),
        ),
        leading: InkWell(
          onTap: (() => Navigator.pop(context)),
          child: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
          child: Column(
            children: [
              Space(20.h),
              ProfileCard(
                color: Colors.black,
                title: 'Password',
                subTitle: 'Change your already existing password',
                image: AppImage.setPassword,
                onPressed: () {
                  pushNewScreen(
                    context,
                    screen: ChangePassword(),
                    pageTransitionAnimation: PageTransitionAnimation.fade,
                  );
                },
              ),
              Space(10.h),
              const Divider(
                color: Colors.black,
                thickness: 0.4,
              ),
              Space(20.h),
              ProfileCard(
                color: Colors.black,
                title: 'Transaction PIN',
                subTitle: 'Change or Retrieve forgotten transaction PIN',
                image: AppImage.transactionPin,
                onPressed: () {
                  pushNewScreen(
                    context,
                    screen: const ChangeTransactionPin(),
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
              Row(
                children: [
                  Text(
                    'Enable biometrics for authentication',
                    style: AppText.header2(context, Colors.black, 20.sp),
                  ),
                  const Spacer(),
                  Switch.adaptive(
                      activeColor: Colors.greenAccent,
                      value: bio,
                      onChanged: (value) async {
                        toggle.state = !toggle.state;
                        PreferenceManager.enableBioMetrics = toggle.state;

                        if (toggle.state == true) {
                          AppSnackBar.showMessage(context,
                              "Please restart the app for this changes");
                          final password = await ref
                              .read(credentialProvider.notifier)
                              .getCredential(Constants.userPassword);
                          ref.read(credentialProvider.notifier).storeCredential(
                              Constants.userEmail, user.data.user.email);
                          ref.read(credentialProvider.notifier).storeCredential(
                              Constants.userPassword, password!);
                        } else if (toggle.state == false) {
                          AppSnackBar.showMessage(context,
                              "Please restart the app for this changes");
                          ref.read(credentialProvider.notifier).clear();
                          // print("false");
                        }
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// class SecurityScreen extends StatelessWidget {
//   const SecurityScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         title: Text(
//           'Security',
//           style: AppText.header2(context, Colors.black, 20.sp),
//         ),
//         leading: InkWell(
//           onTap: (() => Navigator.pop(context)),
//           child: const Icon(
//             Icons.arrow_back_ios_outlined,
//             color: Colors.black,
//           ),
//         ),
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//         elevation: 0,
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
//           child: Column(
//             children: [
//               Space(20.h),
//               ProfileCard(
//                 color: Colors.black,
//                 title: 'Password',
//                 subTitle: 'Change your already existing password',
//                 image: AppImage.password,
//                 onPressed: () {
//                   pushNewScreen(
//                     context,
//                     screen: ChangePassword(),
//                     pageTransitionAnimation: PageTransitionAnimation.fade,
//                   );
//                 },
//               ),
//               Space(10.h),
//               const Divider(
//                 color: Colors.black,
//                 thickness: 0.4,
//               ),
//               Space(20.h),
//               ProfileCard(
//                 color: Colors.black,
//                 title: 'Transaction PIN',
//                 subTitle: 'Add or Reset your transaction PIN',
//                 image: AppImage.transactionPin,
//                 onPressed: () {
//                   pushNewScreen(
//                     context,
//                     screen: const ChangeTransactionPin(),
//                     pageTransitionAnimation: PageTransitionAnimation.fade,
//                   );
//                 },
//               ),
//               Space(10.h),
//               const Divider(
//                 color: Colors.black,
//                 thickness: 0.4,
//               ),
//                Row(
//                 children: [
//                   Text(
//                     'Add to beneficiaries',
//                     style: AppText.header2(context, Colors.black, 20.sp),
//                   ),
//                   const Spacer(),
//                   Switch.adaptive(
//                       activeColor: Colors.greenAccent,
//                       value: toggle.state,
//                       onChanged: (value) {
//                         toggle.state = !toggle.state;
//                       }),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
