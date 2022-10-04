// import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/constant/constant.dart';
import 'package:kayndrexsphere_mobile/presentation/components/widget/appbar_title.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent_tab_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/profile.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/security/auth_security/auth_secure.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/security/change_password.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/security/enable_transaction_pin_modal.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/security/global/transaction_pin_toggle.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/security/transaction_pin/transaction_pin.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/get_profile_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';
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

  bool valueChanged = false;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProfileProvider).value;
    final toggle = ref.watch(toggleStateProvider.state);
    final togglePin = ref.watch(togglePinStateProvider.state);
    final setPin = ref.watch(setPinStateProvider.state);

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        title: const AppBarTitle(title: "Security", color: Colors.black),
        leading: const BackButton(color: Colors.black),
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

              ///ENABLE BIOMETRIC FOR AUTHENTICATION
              Row(
                children: [
                  Text(
                    'Biometric for Login',
                    style: AppText.header2(context, Colors.black, 19.sp),
                  ),
                  const Spacer(),
                  Switch.adaptive(
                      activeColor: Colors.greenAccent,
                      value: PreferenceManager.enableBioMetrics,
                      onChanged: (value) async {
                        toggle.state = !toggle.state;
                        PreferenceManager.enableBioMetrics = toggle.state;

                        if (toggle.state == true) {
                          showOkAlertDialog(
                            context: context,
                            message: 'Please restart the app for this changes',
                          );
                          final password = await ref
                              .read(credentialProvider.notifier)
                              .getCredential(Constants.userPassword);

                          ref.read(credentialProvider.notifier).storeCredential(
                              Constants.userEmail,
                              user == null ? "" : user.data.user.email!

                              // user.data.user.email.toString()
                              );
                          ref.read(credentialProvider.notifier).storeCredential(
                              Constants.userPassword, password!);
                        } else if (toggle.state == false) {
                          showOkAlertDialog(
                            context: context,
                            message: 'Please restart the app for this changes',
                          );

                          // ref
                          //     .read(credentialProvider.notifier)
                          //     .deleteCredential(Constants.userPassword);
                          // print("false");
                        }
                      }),
                ],
              ),

              ///ENABLE BIOMETRIC FOR TRANSACTIONS
              Row(
                children: [
                  Text(
                    'Biometric for Transactions',
                    style: AppText.header2(context, Colors.black, 18.sp),
                  ),
                  const Spacer(),
                  Switch.adaptive(
                      activeColor: Colors.greenAccent,
                      value: PreferenceManager.enableTransactionBioMetrics,
                      onChanged: (value) async {
                        togglePin.state = !togglePin.state;
                        // PreferenceManager.enableTransactionBioMetrics =
                        //     togglePin.state;

                        if (togglePin.state) {
                          showModalBottomSheet(
                              context: context,
                              isDismissible: true,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20))),
                              builder: (context) {
                                return EnableTransactionPin(
                                  isEnable: PreferenceManager
                                      .enableTransactionBioMetrics,
                                );
                              }).whenComplete(() {
                            if (setPin.state) {
                              setState(() {
                                PreferenceManager.enableTransactionBioMetrics =
                                    true;
                                togglePin.state = true;
                              });
                            } else {
                              setState(() {
                                PreferenceManager.enableTransactionBioMetrics =
                                    false;
                                togglePin.state = false;
                              });
                            }
                          });
                        } else if (togglePin.state == false) {
                          setState(() {
                            ref
                                .read(credentialProvider.notifier)
                                .deleteCredential(Constants.transactionPin);
                            PreferenceManager.enableTransactionBioMetrics =
                                false;
                          });
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
