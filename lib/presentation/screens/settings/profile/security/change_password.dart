import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/constant/constant.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/req/change_password_req.dart';
import 'package:kayndrexsphere_mobile/presentation/components/AppSnackBar/snackbar/app_snackbar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/text%20field/text_form_field.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/change_password_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../components/app text theme/app_text_theme.dart';
import '../../../../components/reusable_widget.dart/custom_button.dart';
import 'auth_security/auth_secure.dart';

class ChangePassword extends HookConsumerWidget {
  ChangePassword({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final pinToggleStateProvider = StateProvider<bool>((ref) => true);
  final pinConfirmToggleStateProvider = StateProvider<bool>((ref) => true);
  final oldPinToggleStateProvider = StateProvider<bool>((ref) => true);

  final fieldFocusNode = FocusNode();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final confirmController = useTextEditingController();
    final controller = useTextEditingController();
    final oldPasswordController = useTextEditingController();
    final togglePassword = ref.watch(pinToggleStateProvider.state);
    final toggleConfirmPin = ref.watch(pinConfirmToggleStateProvider.state);
    final toggleOldPin = ref.watch(oldPinToggleStateProvider.state);
    final vn = ref.watch(changePasswordProvider);
    ref.listen<RequestState>(changePasswordProvider, (T, value) {
      if (value is Success) {
        context.loaderOverlay.hide();
        Navigator.pop(context);
        ref.refresh(changePasswordProvider);

        return AppSnackBar.showSuccessSnackBar(context,
            message: 'Password changed successfully');
      }
      if (value is Error) {
        context.loaderOverlay.hide();
        return AppSnackBar.showErrorSnackBar(context,
            message: value.error.toString());
      }
    });
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: const Center(
        child: SpinKitWave(
          color: AppColors.appColor,
          size: 50.0,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      height: 40.h,
                      width: MediaQuery.of(context).size.width,
                      color: AppColors.appColor.withOpacity(0.1),
                      child: Padding(
                        padding: EdgeInsets.only(right: 240.w),
                        child: Center(
                          child: Text(
                            'Change password',
                            style:
                                AppText.body2(context, Colors.black54, 20.sp),
                          ),
                        ),
                      ),
                    ),
                    Space(20.h),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
                      child: Column(
                        children: [
                          //old password
                          TextFormInput(
                            enabled: vn is Loading ? false : true,
                            labelText: 'Old Password',
                            controller: oldPasswordController,
                            capitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password is requied";
                              }
                              if (value.length < 8) {
                                return 'Password must at least be 8 characters';
                              }
                              return null;
                            },
                            obscureText: toggleOldPin.state,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                toggleOldPin.state = !toggleOldPin.state;
                              },
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 0.h),
                                child: Icon(
                                  toggleOldPin.state
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: AppColors.appColor,
                                ),
                              ),
                            ),
                          ),
                          Space(32.h),

                          // new password
                          TextFormInput(
                            enabled: vn is Loading ? false : true,
                            labelText: 'New Password',
                            controller: controller,
                            capitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password is requied";
                              }
                              if (value.length < 8) {
                                return 'Password must at least be 8 characters';
                              }
                              return null;
                            },
                            obscureText: togglePassword.state,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                togglePassword.state = !togglePassword.state;
                              },
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 0.h),
                                child: Icon(
                                  togglePassword.state
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: AppColors.appColor,
                                ),
                              ),
                            ),
                          ),
                          Space(32.h),

                          // confirm password
                          TextFormInput(
                            enabled: vn is Loading ? false : true,
                            labelText: 'Re-enter new password',
                            controller: confirmController,
                            capitalization: TextCapitalization.none,
                            focusNode: fieldFocusNode,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Confirm Password is required';
                              } else if (controller.text !=
                                  confirmController.text) {
                                return 'Password doesn\'t match';
                              }

                              return null;
                            },
                            obscureText: toggleConfirmPin.state,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                toggleConfirmPin.state =
                                    !toggleConfirmPin.state;
                              },
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 0.h),
                                child: Icon(
                                  toggleConfirmPin.state
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: AppColors.appColor,
                                ),
                              ),
                            ),
                          ),
                          Space(150.h),
                          CustomButton(
                              buttonText:
                                  vn is Loading ? "Please wait ..." : 'Save',
                              bgColor: AppColors.appColor,
                              borderColor: AppColors.appColor,
                              textColor: Colors.white,
                              onPressed: vn is Loading
                                  ? null
                                  : () {
                                      if (formKey.currentState!.validate()) {
                                        fieldFocusNode.unfocus();
                                        ChangePasswordReq changePassword =
                                            ChangePasswordReq(
                                          oldPassword:
                                              oldPasswordController.text,
                                          newPassword: controller.text,
                                          confirmPassword:
                                              confirmController.text,
                                        );
                                        ref
                                            .read(credentialProvider.notifier)
                                            .storeCredential(
                                                Constants.userPassword,
                                                controller.text);

                                        ref
                                            .read(
                                                changePasswordProvider.notifier)
                                            .changePassword(changePassword);
                                        context.loaderOverlay.show();
                                      }
                                    },
                              buttonWidth: MediaQuery.of(context).size.width),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
