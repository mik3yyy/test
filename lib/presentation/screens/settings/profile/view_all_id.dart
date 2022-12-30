import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/widget/appbar_title.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent_tab_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/upload_id.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/get_id_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/id_build.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import 'package:skeletons/skeletons.dart';

import '../../../components/app text theme/app_text_theme.dart';

class ViewIdentification extends HookConsumerWidget {
  const ViewIdentification({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final identification = ref.watch(getAllIdentification);
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.grey.shade100,
        title: const AppBarTitle(title: "Identification", color: Colors.black),
        leading: const BackButton(color: Colors.black),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextButton(
              onPressed: () {
                pushNewScreen(
                  context,
                  withNavBar: false,
                  screen: const UploadId(
                    uploadId: UploadRoute.addId,
                  ),
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
              child: Text(
                "Add ID",
                style: AppText.body2Bold(context, AppColors.appColor, 20.sp),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
        ),
        child: Column(
          children: [
            const Space(20),
            identification.when(
                data: (data) {
                  if (data.data!.identifications.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Add Identification card",
                              style:
                                  AppText.body2(context, Colors.black45, 20.sp),
                            ),
                            const Space(30),
                            SizedBox(
                              width: 200,
                              child: TextButton(
                                onPressed: () {
                                  pushNewScreen(
                                    context,
                                    withNavBar: false,
                                    screen: const UploadId(
                                      uploadId: UploadRoute.addId,
                                    ),
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino,
                                  );
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: AppColors.appColor,
                                  disabledForegroundColor: Colors.grey,
                                ),
                                child: Text(
                                  "Add ID",
                                  style: AppText.body2(
                                      context, Colors.white, 20.sp),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Expanded(
                        child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics()),
                      itemCount: data.data!.identifications.length,
                      itemBuilder: (context, index) {
                        final id = data.data!.identifications[index];
                        return IDbuild(id: id);
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 20,
                        );
                      },
                    ));
                  }
                },

                ///CHECK FOR ERROR HERE
                error: (e, s) => const LoadingIDs(),
                loading: () => const LoadingIDs())
          ],
        ),
      ),
    );
  }
}

class LoadingIDs extends StatelessWidget {
  const LoadingIDs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: AppColors.appColor.withOpacity(0.09),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          height: 500,
          child: ListView.separated(
            scrollDirection: Axis.vertical,
            itemCount: 4,
            itemBuilder: (context, index) {
              return const SkeletonAvatar(
                style: SkeletonAvatarStyle(width: double.infinity, height: 90),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 20);
            },
          ),
        ),
      ),
    );
  }
}
