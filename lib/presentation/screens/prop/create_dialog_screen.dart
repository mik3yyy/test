import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/Dialog/create_dialog_res.dart';
import 'package:kayndrexsphere_mobile/presentation/components/AppSnackBar/snackbar/app_snackbar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/components/text%20field/text_form_field.dart';
import 'package:kayndrexsphere_mobile/presentation/components/widget/appbar_title.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/vm/create_dialog.vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/vm/get_contacts_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import 'package:loader_overlay/loader_overlay.dart';

class CreateDialogScreen extends HookConsumerWidget {
  final String contactEmail;
  CreateDialogScreen({Key? key, required this.contactEmail}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createDialog = ref.watch(createDialogProvider);
    FocusScopeNode currentFocus = FocusScope.of(context);
    final email = useTextEditingController(text: contactEmail);
    final message = useTextEditingController();
    ref.listen<RequestState>(createDialogProvider, (_, state) {
      if (state is Loading) {
        context.loaderOverlay.show();
      } else {
        context.loaderOverlay.hide();
      }
      if (state is Success<CreateDialogRes>) {
        Navigator.pop(context);
        Navigator.pop(context);
        ref.invalidate(allContactsProvider);
        AppSnackBar.showSuccessSnackBar(context,
            message: "contact added successfully");
      }
      if (state is Error) {
        AppSnackBar.showErrorSnackBar(context, message: state.error.toString());
      }
    });
    return Scaffold(
      backgroundColor: AppColors.appColor,
      appBar: AppBar(
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const AppBarTitle(title: "Create Dialog", color: Colors.white),
        automaticallyImplyLeading: false,
        leading: const BackButton(color: Colors.white),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const Space(20),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(45.r)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Space(200.h),
                        TextFormInput(
                            labelText: " Enter Email ",
                            controller: email,
                            capitalization: TextCapitalization.none,
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp('[ ]'))
                            ],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email address is required";
                              }

                              return null;
                            },
                            obscureText: false),
                        Space(30.h),
                        TextFormInput(
                            labelText: "Enter Dialog Title ",
                            controller: message,
                            capitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Dialog Title is required";
                              }

                              return null;
                            },
                            obscureText: false),
                        const Space(20),
                        Space(50.h),
                        CustomButton(
                          buttonWidth: 280.w,
                          buttonText: createDialog is Loading
                              ? loading(
                                  Colors.white,
                                )
                              : buttonText(context, "Create Dialog"),
                          bgColor: AppColors.appColor,
                          borderColor: AppColors.appColor,
                          textColor: Colors.white,
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }

                              ref
                                  .read(createDialogProvider.notifier)
                                  .createDialog(email.text, message.text);
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
