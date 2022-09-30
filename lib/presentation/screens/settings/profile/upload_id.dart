import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/res/upload_id_res.dart';
import 'package:kayndrexsphere_mobile/presentation/components/AppSnackBar/snackbar/app_snackbar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/loading_util/loading_util.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/update_id_vm.dart';
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
  final fieldFocusNode = FocusNode();
  final passwordToggleStateProvider = StateProvider<bool>((ref) => true);

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(userIdProvider);
    final togglePassword = ref.watch(passwordToggleStateProvider.state);
    final idTypeController = useTextEditingController();
    final idNoController = useTextEditingController();
    FocusScopeNode currentFocus = FocusScope.of(context);
    final selectedImage = useState<String>("");

    ref.listen<RequestState>(userIdProvider, (_, value) {
      if (value is Loading) {
        ScreenView.showLoadingView(context);
      } else {
        ScreenView.hideLoadingView(context);
      }

      if (value is Success<UploadIdRes>) {
        ref.refresh(userIdProvider);
        Navigator.pop(context);
        return AppSnackBar.showSuccessSnackBar(context,
            message: value.value!.message.toString());
        // pushNewScreen(context,
        //     screen: const VerificationSuccess(),
        //     pageTransitionAnimation: PageTransitionAnimation.fade);

      }
      if (value is Error) {
        return AppSnackBar.showErrorSnackBar(context,
            message: value.error.toString());
      }
    });
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        title: Text(
          'Upload ID',
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
      body: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
        child: Form(
          key: formKey,
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
                  keyboardType: TextInputType.number,
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
                    style: AppText.header2(context, AppColors.appColor, 20.sp),
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
                  buttonText: vm is Loading ? "Please wait..." : 'Verify',
                  bgColor: AppColors.appColor,
                  borderColor: AppColors.appColor,
                  textColor: Colors.white,
                  onPressed: vm is Loading
                      ? null
                      : () async {
                          if (formKey.currentState!.validate()) {
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }

                            if (selectedImage.value.isEmpty) {
                              return;
                            } else {
                              ref.read(userIdProvider.notifier).uploadId(
                                  selectedImage.value,
                                  idTypeController.text,
                                  idNoController.text);
                            }

                            // pushNewScreen(context,
                            //     screen: VerifyScreen(
                            //       isloading: vm is Loading,
                            //     ),
                            //     pageTransitionAnimation:
                            //         PageTransitionAnimation.fade);
                          }
                        },
                  buttonWidth: MediaQuery.of(context).size.width),
            ],
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
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }
}
