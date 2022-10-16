import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kayndrexsphere_mobile/presentation/components/AppSnackBar/snackbar/app_snackbar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/components/widget/appbar_title.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent_tab_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/upload_id_terms.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/edit_form.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/validator.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class UploadId extends StatefulHookConsumerWidget {
  const UploadId({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UploadIdState();
}

class _UploadIdState extends ConsumerState<UploadId> {
  final formKey = GlobalKey<FormState>();
  final passwordToggleStateProvider = StateProvider<bool>((ref) => true);

  @override
  Widget build(BuildContext context) {
    final togglePassword = ref.watch(passwordToggleStateProvider.state);
    final idTypeController = useTextEditingController();
    final idNoController = useTextEditingController();
    FocusScopeNode currentFocus = FocusScope.of(context);
    final selectedImage = useState<String>("");

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        title: const AppBarTitle(title: "Upload ID", color: Colors.black),
        leading: const BackButton(color: Colors.black),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 10.h),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  onTap: () {},
                  child: EditForm(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    labelText: 'Id Type',
                    keyboardType: TextInputType.name,
                    controller: idTypeController,
                    obscureText: false,
                    validator: (value) => validateIdType(value),
                  ),
                ),
                Space(20.h),
                InkWell(
                  onTap: () {},
                  child: EditForm(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    labelText: 'ID number',
                    keyboardType: TextInputType.name,
                    controller: idNoController,
                    obscureText: togglePassword.state,
                    validator: (value) => validateIdNo(value),
                    suffixIcon: InkWell(
                      onTap: () {
                        togglePassword.state = !togglePassword.state;
                      },
                      child: Icon(
                        togglePassword.state
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),
                ),
                Space(30.h),
                Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: () async {
                      final _picker = ImagePicker();
                      final XFile? image =
                          await _picker.pickImage(source: ImageSource.gallery);

                      if (image == null) {
                        return;
                      }

                      selectedImage.value = image.path;
                    },
                    child: Text(
                      'Upload ID',
                      style:
                          AppText.header2(context, AppColors.appColor, 20.sp),
                    ),
                  ),
                ),
                Space(50.h),
                if (selectedImage.value == "") ...[
                  const SizedBox.shrink()
                ] else ...[
                  ImageIdB(
                    onTap: () {
                      selectedImage.value = "";
                    },
                    selectedImage: selectedImage.value,
                  )
                ],
                Space(110.h),
                CustomButton(
                    buttonText: buttonText(context, "Save"),
                    bgColor: AppColors.appColor,
                    borderColor: AppColors.appColor,
                    textColor: Colors.white,
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }

                        if (selectedImage.value.isEmpty) {
                          AppSnackBar.showInfoSnackBar(context,
                              message: "Add Image of ID");
                        } else {
                          pushNewScreen(context,
                              screen: UploadIDTerms(
                                idNumber: idNoController.text,
                                idType: idTypeController.text,
                                selectedImage: selectedImage.value,
                              ),
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino);
                          // ref.read(userIdProvider.notifier).uploadId(
                          //     selectedImage.value,
                          //     idTypeController.text,
                          //     idNoController.text);
                        }
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

class ImageIdB extends HookConsumerWidget {
  final String selectedImage;
  final VoidCallback onTap;
  const ImageIdB({Key? key, required this.selectedImage, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InkWell(
            onTap: onTap,
            child: Icon(
              Icons.cancel_outlined,
              color: Colors.grey.shade400,
            )),
        const Space(10),
        SizedBox(
          // color: Colors.red,
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: Image(
            image: FileImage(File(selectedImage)),
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
