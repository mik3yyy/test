import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/contact/contact_res.dart';
import 'package:kayndrexsphere_mobile/presentation/components/AppSnackBar/snackbar/app_snackbar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/components/text%20field/text_form_field.dart';
import 'package:kayndrexsphere_mobile/presentation/components/widget/appbar_title.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent_tab_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/create_dialog_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/vm/create_account_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/vm/get_contacts_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/vm/get_dialog_messages_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class AddContactScreen extends HookConsumerWidget {
  AddContactScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addContact = ref.watch(addContactProvider);
    FocusScopeNode currentFocus = FocusScope.of(context);
    final screenH = MediaQuery.of(context).size.height;
    final emailController = useTextEditingController();
    ref.listen<RequestState>(addContactProvider, (_, state) {
      if (state is Success<ContactRes>) {
        ref.invalidate(allContactsProvider);
        ref.invalidate(alldialogsProvider);
        pushNewScreen(context,
            screen: CreateDialogScreen(contactId: state.value?.data?.id ?? 0),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.slideRight);

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
        title: const AppBarTitle(title: "Add Contact", color: Colors.white),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Space(60),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error,
                            color: Colors.black45,
                          ),
                          const Space(20),
                          Flexible(
                            child: Text(
                              """Enter E-wallet account number of your friend connects you directly with them.
                               """,
                              style:
                                  AppText.body2(context, Colors.black45, 19.sp),
                            ),
                          ),
                        ],
                      ),
                      const Space(100),
                      Form(
                        key: formKey,
                        child: TextFormInput(
                            labelText: " Enter E-Wallet account number",
                            controller: emailController,
                            textLength: 8,
                            capitalization: TextCapitalization.none,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp('[ ]'))
                            ],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "E-Wallet account number is required";
                              }

                              return null;
                            },
                            obscureText: false),
                      ),
                      Space(screenH / 5),
                      Space(50.h),
                      CustomButton(
                        buttonWidth: 280.w,
                        buttonText: addContact is Loading
                            ? loading(
                                Colors.white,
                              )
                            : buttonText(context, "Add contact"),
                        bgColor: AppColors.appColor,
                        borderColor: AppColors.appColor,
                        textColor: Colors.white,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }

                            ref
                                .read(addContactProvider.notifier)
                                .addContact(emailController.text);
                          }
                        },
                      )
                    ],
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
