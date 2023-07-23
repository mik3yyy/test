import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/new_sign_in_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/res/security_question_req.dart';
import 'package:kayndrexsphere_mobile/presentation/components/AppSnackBar/snackbar/app_snackbar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/loading_util/loading_util.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/components/text%20field/text_form_field.dart';
import 'package:kayndrexsphere_mobile/presentation/components/widget/appbar_title.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/security/security_question/vm.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class SecurityQuestionView extends StatefulHookConsumerWidget {
  const SecurityQuestionView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SecurityQuestionViewState();
}

class _SecurityQuestionViewState extends ConsumerState<SecurityQuestionView> {
  final formKey = GlobalKey<FormState>();
  bool isObscured = true;
  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    final securityQues = ref.watch(securityQuestionProvider);
    final question = useTextEditingController();
    final answer = useTextEditingController();
    final hint = useTextEditingController();

    ref.listen<RequestState>(securityQuestionProvider, (T, value) {
      if (value is Loading<GenericRes>) {
        ScreenView.showLoadingView(context);
      } else {
        ScreenView.hideLoadingView(context);
      }
      if (value is Success<GenericRes>) {
        Navigator.pop(context);
        return AppSnackBar.showSuccessSnackBar(context,
            message: value.value!.message.toString());
      }
      if (value is Error) {
        return AppSnackBar.showErrorSnackBar(context,
            message: value.error.toString());
      }
    });

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.grey.shade100,
        title:
            const AppBarTitle(title: "Security Question", color: Colors.black),
        leading: const BackButton(color: Colors.black),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 30.w,
            right: 30.w,
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Space(20.h),
                //old password
                TextFormInput(
                  keyboardType: TextInputType.emailAddress,
                  capitalization: TextCapitalization.none,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  labelText: 'Enter Question',
                  controller: question,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Question is required';
                    }

                    return null;
                  },
                  obscureText: false,
                ),
                Space(32.h),

                // new password
                TextFormInput(
                  keyboardType: TextInputType.emailAddress,
                  capitalization: TextCapitalization.none,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  labelText: 'Enter Answer',
                  controller: answer,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Answer is required';
                    }

                    return null;
                  },
                  obscureText: false,
                ),
                Space(32.h),

                // confirm password
                TextFormInput(
                  keyboardType: TextInputType.text,
                  capitalization: TextCapitalization.none,
                  labelText: 'Enter Hint',
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp('[ ]'))
                  ],
                  controller: hint,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Hint is required';
                    }

                    return null;
                  },
                  obscureText: false,
                ),
                Space(150.h),
                CustomButton(
                    buttonText: securityQues is Loading
                        ? loading(
                            Colors.white,
                          )
                        : buttonText(context, "Save"),
                    bgColor: AppColors.appColor,
                    borderColor: AppColors.appColor,
                    textColor: Colors.white,
                    onPressed: securityQues is Loading
                        ? null
                        : () {
                            if (formKey.currentState!.validate()) {
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                              var securityQues = SecurityQuesReq(
                                  question: question.text,
                                  answer: answer.text,
                                  hint: hint.text);
                              ref
                                  .read(securityQuestionProvider.notifier)
                                  .securityQuestion(securityQues);
                            }
                          },
                    buttonWidth: MediaQuery.of(context).size.width),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
