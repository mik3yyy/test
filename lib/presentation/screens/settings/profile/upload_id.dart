import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent_tab_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/loading_verify.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/success_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/update_id_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/upload_pp_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/edit_form.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/pick_image_dialog.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/validator.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;

class UploadId extends StatefulHookConsumerWidget {
  // final bool hasIcon;
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
    final provider = PreferenceManager.idUrl;
    final vm = ref.watch(userIdProvider);
    final togglePassword = ref.watch(passwordToggleStateProvider.state);
    final idTypeController = useTextEditingController();
    final idNoController = useTextEditingController();

    ref.listen<RequestState>(userIdProvider, (_, value) {
      if (value is Success) {
        pushNewScreen(context,
            screen: const VerificationSuccess(),
            pageTransitionAnimation: PageTransitionAnimation.fade);
        return ref.refresh(userIdProvider);
      }
      if (value is Error) {
        // return AppSnackBar.showErrorSnackBar(context,
        //     message: value.error.toString());
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
        child: provider.isNotEmpty
            ? Form(
                key: formKey,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: EditForm(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        labelText: 'ID Type',
                        keyboardType: TextInputType.number,
                        controller: idTypeController,
                        obscureText: false,
                        validator: (value) => validateIdType(value),
                        suffixIcon: const Icon(
                          CupertinoIcons.chevron_down,
                          color: Colors.black,
                          size: 15,
                        ),
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
                      alignment: Alignment.bottomLeft,
                      child: InkWell(
                        onTap: () async {
                          PickImageDialog().pickImage(context, () {
                            getImage(ImageSource.camera);
                          }, () {
                            getImage(ImageSource.gallery);
                          });
                        },
                        child: Text(
                          'Change',
                          style: AppText.header2(
                              context, AppColors.appColor, 20.sp),
                        ),
                      ),
                    ),
                    Space(15.h),
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(File(provider)))),
                    ),
                    Space(40.h),
                    CustomButton(
                        buttonText: 'verify',
                        bgColor: AppColors.appColor,
                        borderColor: AppColors.appColor,
                        textColor: Colors.white,
                        onPressed: vm is Loading
                            ? null
                            : () async {
                                if (formKey.currentState!.validate()) {
                                  fieldFocusNode.unfocus();

                                  ref.read(userIdProvider.notifier).uploadId(
                                      provider,
                                      idTypeController.text,
                                      idNoController.text);
                                }
                              },
                        buttonWidth: MediaQuery.of(context).size.width),
                  ],
                ),
              )
            : Form(
                key: formKey,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: EditForm(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        labelText: 'Id Type',
                        keyboardType: TextInputType.number,
                        controller: idTypeController,
                        obscureText: false,
                        validator: (value) => validateIdType(value),
                        suffixIcon: const Icon(
                          CupertinoIcons.chevron_down,
                          color: Colors.black,
                          size: 15,
                        ),
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
                          PickImageDialog().pickImage(context, () {
                            getImage(ImageSource.camera);
                          }, () {
                            getImage(ImageSource.gallery);
                          });
                        },
                        child: Text(
                          'Upload ID',
                          style: AppText.header2(
                              context, AppColors.appColor, 20.sp),
                        ),
                      ),
                    ),
                    Space(200.h),
                    CustomButton(
                        buttonText: 'verify',
                        bgColor: AppColors.appColor,
                        borderColor: AppColors.appColor,
                        textColor: Colors.white,
                        onPressed: vm is Loading
                            ? null
                            : () async {
                                if (formKey.currentState!.validate()) {
                                  fieldFocusNode.unfocus();

                                  ref.read(userIdProvider.notifier).uploadId(
                                      provider,
                                      idTypeController.text,
                                      idNoController.text);
                                  pushNewScreen(context,
                                      screen: VerifyScreen(
                                        isloading: vm is Loading,
                                      ),
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.fade);
                                }
                              },
                        buttonWidth: MediaQuery.of(context).size.width),
                  ],
                ),
              ),
      ),
    );
  }

  void getImage(
    ImageSource imageSource,
  ) async {
    final _picker = ImagePicker();
    if (Platform.isAndroid) {}

    final XFile? image = await _picker.pickImage(source: imageSource);

    if (image == null) {
      return;
    }

    final imageFile = File(image.path);

    // selectedValue = imageFile;

    ref.read(userPhotoProvider.notifier).uploadProfilePhoto(image.path);

    final appDir = await path_provider.getApplicationDocumentsDirectory();

    // This is the saved image path
    // You can use it to display the saved image later
    final localPath = path.join(appDir.path, imageFile.path);
    PreferenceManager.avatarUrl = localPath;

    // print("I PRINTED PROFILEIMAGE $localPath");
  }
}
