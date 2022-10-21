import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/res/upload_id_res.dart';
import 'package:kayndrexsphere_mobile/presentation/components/AppSnackBar/snackbar/app_snackbar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/widget/appbar_title.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/get_id_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/update_id_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../components/app text theme/app_text_theme.dart';

class UploadIDTerms extends StatefulHookConsumerWidget {
  final String idType;
  final String idNumber;
  final String selectedImage;
  const UploadIDTerms(
      {Key? key,
      required this.idType,
      required this.idNumber,
      required this.selectedImage})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UploadIDTermsState();
}

class _UploadIDTermsState extends ConsumerState<UploadIDTerms> {
  bool toggle = false;
  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(userIdProvider);
    ref.listen<RequestState>(userIdProvider, (_, value) {
      if (value is Success<UploadIdRes>) {
        ref.refresh(getAllIdentification);
        Navigator.pop(context);
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
        title: const AppBarTitle(title: "Upload Terms", color: Colors.black),
        leading: const BackButton(color: Colors.black),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 10.h),
        child: Column(
          children: [
            Text(
                "By uploading your ID you will be able to identify yourself or provide confirmation of certain personal information for both online and offline public and private services across the world. However, you authorise Kayndrexsphere.com, directly or through third parties, to make any inquiries we consider necessary to validate your identity. This may include asking you for further information or documentation, requiring you to provide a taxpayer or national identification number, requiring you to take steps to confirm ownership of your email or financial instruments, ordering a credit report or verifying information against third party databases or through other sources.",
                textAlign: TextAlign.justify,
                style: AppText.uploadTerms(context, Colors.black, 18.sp)),
            const Space(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                    activeColor: AppColors.appColor,
                    checkColor: AppColors.whiteColor,
                    side: BorderSide(width: 0.8.w, color: AppColors.appColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.r),
                    ),
                    value: toggle,
                    onChanged: (value) {
                      setState(() {
                        toggle = value!;
                      });
                    }),
                Expanded(
                  child: Text(
                    "By clicking on the checkbox you agree to the terms stated above.",
                    style: AppText.body2(context, AppColors.hintColor, 16.sp),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
            const Space(40),
            SizedBox(
              width: 200,
              child: TextButton(
                  onPressed: vm is Loading
                      ? null
                      : () {
                          if (toggle == false) {
                            AppSnackBar.showInfoSnackBar(context,
                                message: "Accept the terms");
                          } else {
                            ref.read(userIdProvider.notifier).uploadId(
                                widget.selectedImage,
                                widget.idType,
                                widget.idNumber);
                          }
                        },
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: AppColors.appColor,
                    onSurface: Colors.grey,
                  ),
                  child: vm is Loading
                      ? loading(
                          Colors.white,
                        )
                      : buttonText(context, "I Agree")),
            )
          ],
        ),
      ),
    );
  }
}
