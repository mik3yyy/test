import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/res/upload_id_res.dart';
import 'package:kayndrexsphere_mobile/presentation/components/AppSnackBar/snackbar/app_snackbar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/components/widget/appbar_title.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent_tab_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/profile_image/profile_image.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/upload_id_terms.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/get_id_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/update_id_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/edit_form.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/validator.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

enum UploadRoute { addId, editId }

class UploadId extends StatefulHookConsumerWidget {
  final UploadRoute uploadId;
  final String idNumber;
  final String id;
  final String idType;
  final String image;
  const UploadId(
      {Key? key,
      required this.uploadId,
      this.id = "",
      this.idNumber = "",
      this.idType = "",
      this.image = ""})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UploadIdState();
}

class _UploadIdState extends ConsumerState<UploadId> {
  final formKey = GlobalKey<FormState>();
  final passwordToggleStateProvider = StateProvider<bool>((ref) => true);

  @override
  Widget build(BuildContext context) {
    final editId = ref.watch(editIdProvider);
    final togglePassword = ref.watch(passwordToggleStateProvider.state);
    final idTypeController = useTextEditingController(text: widget.idType);
    final idNoController = useTextEditingController(text: widget.idNumber);
    FocusScopeNode currentFocus = FocusScope.of(context);
    final selectedImage = useState<String>("");

    ref.listen<RequestState>(editIdProvider, (_, value) {
      if (value is Success<UploadIdRes>) {
        ref.refresh(getAllIdentification);
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
                EditForm(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  labelText: 'Id Type',
                  keyboardType: TextInputType.name,
                  controller: idTypeController,
                  obscureText: false,
                  validator: (value) => validateIdType(value),
                ),
                Space(20.h),
                EditForm(
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
                Space(30.h),

                /// UPLOAD ID BUTTON
                UploadIDButton(selectedImage: selectedImage),
                Space(50.h),
                if (widget.uploadId == UploadRoute.editId) ...[
                  if (selectedImage.value == "") ...[
                    SizedBox(
                      height: 200,
                      width: 300,
                      child: KYNetworkImage(
                          url: widget.image,
                          errorImage: Image.asset(
                            AppImage.profile,
                            scale: 7,
                            fit: BoxFit.cover,
                          ),
                          fit: BoxFit.fill),
                    ),
                  ] else ...[
                    ImageIdB(
                      onTap: () {
                        selectedImage.value = "";
                      },
                      selectedImage: selectedImage.value,
                    )
                  ],
                ] else ...[
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
                ],

                Space(110.h),
                CustomButton(
                    buttonText: editId is Loading
                        ? loading(
                            Colors.white,
                          )
                        : buttonText(context, "Save"),
                    bgColor: AppColors.appColor,
                    borderColor: AppColors.appColor,
                    textColor: Colors.white,
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        String image() {
                          if (selectedImage.value.isEmpty) {
                            return widget.image;
                          } else {
                            return selectedImage.value;
                          }
                        }

                        if (widget.uploadId == UploadRoute.addId) {
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
                          }
                        } else {
                          ref.read(editIdProvider.notifier).editID(
                              filePath: image(),
                              id: widget.id,
                              isEdit:
                                  selectedImage.value.isEmpty ? false : true,
                              idNo: idNoController.text,
                              idType: idTypeController.text);
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

class UploadIDButton extends StatelessWidget {
  final ValueNotifier<String> selectedImage;
  const UploadIDButton({
    Key? key,
    required this.selectedImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: GestureDetector(
        onTap: () async {
          final _picker = ImagePicker();
          final XFile? image =
              await _picker.pickImage(source: ImageSource.gallery);

          if (image == null) {
            return;
          }

          CroppedFile? croppedFile = await ImageCropper().cropImage(
              sourcePath: image.path,
              aspectRatio: const CropAspectRatio(ratioX: 14, ratioY: 10),
              compressQuality: 100);

          if (croppedFile == null) {
            return;
          } else {
            selectedImage.value = croppedFile.path;
          }
        },
        child: Text(
          'Upload ID',
          style: AppText.header2(context, AppColors.appColor, 20.sp),
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
