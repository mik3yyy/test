import 'dart:developer';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/res/saved_id.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/res/upload_id_res.dart';
import 'package:kayndrexsphere_mobile/presentation/components/AppSnackBar/snackbar/app_snackbar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent_tab_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/profile_image/profile_image.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/upload_id.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/get_id_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/update_id_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/dialog/dialog.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../../components/app image/app_image.dart';
import '../../../../components/app text theme/app_text_theme.dart';

class IDbuild extends StatefulHookConsumerWidget {
  final Identification id;
  const IDbuild({Key? key, required this.id}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _IDbuildState();
}

class _IDbuildState extends ConsumerState<IDbuild> {
  String? selectedId;
  @override
  Widget build(BuildContext context) {
    ref.listen<RequestState>(deleteIdProvider, (_, value) {
      if (value is Success<UploadIdRes>) {
        ref.refresh(getAllIdentification);

        // AppSnackBar.showSuccessSnackBar(context,
        //     message: value.value!.message.toString());
      }
      if (value is Error) {
        return AppSnackBar.showErrorSnackBar(context,
            message: value.error.toString());
      }
    });
    return Container(
        padding: const EdgeInsets.all(10),
        color: Colors.grey.shade100,
        child: Row(
          children: [
            SizedBox(
              height: 70,
              width: 100,
              child: KYNetworkImage(
                  url: widget.id.fileFront.toString(),
                  errorImage: Image.asset(
                    AppImage.profile,
                    scale: 7,
                    fit: BoxFit.cover,
                  ),
                  fit: BoxFit.fill),
            ),
            const Space(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("ID Type:",
                    style: AppText.body2(context, Colors.black45, 15.sp)),
                Text(widget.id.idType.toString()),
                const Space(10),
                Text("ID number:",
                    style: AppText.body2(context, Colors.black45, 15.sp)),
                Text(widget.id.idNo.toString())
              ],
            ),
            const Spacer(),
            selectedId == widget.id.id.toString()
                ? loading(
                    AppColors.appColor,
                  )
                : IconButton(
                    onPressed: () =>
                        AppDialog.viewIdOptions(context, viewId: () {
                          Navigator.pop(context);
                          AppDialog.viewId(context,
                              idNo: widget.id.idNo.toString(),
                              idType: widget.id.idType.toString(),
                              image: widget.id.fileFront.toString());
                        }, editID: () {
                          Navigator.pop(context);
                          pushNewScreen(context,
                              screen: UploadId(
                                uploadId: UploadRoute.editId,
                                id: widget.id.id.toString(),
                                idNumber: widget.id.idNo.toString(),
                                image: widget.id.fileFront.toString(),
                                idType: widget.id.idType.toString(),
                              ),
                              withNavBar: false,
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino);
                        }, deletedID: () async {
                          Navigator.pop(context);
                          final result = await showOkCancelAlertDialog(
                            context: context,
                            title: 'Warning',
                            message: 'Do you want to delete this ID?',
                          );

                          if (result == OkCancelResult.ok) {
                            setState(() {
                              selectedId = widget.id.id.toString();
                            });

                            ref
                                .read(deleteIdProvider.notifier)
                                .deleteID(id: widget.id.id.toString());
                          }

                          log("$result");
                        }),
                    icon: Icon(
                      Icons.more_vert_rounded,
                      color: Colors.grey.shade500,
                    ))
          ],
        ));
  }
}
