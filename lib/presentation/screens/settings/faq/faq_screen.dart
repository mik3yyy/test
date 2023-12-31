import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/forum/model/res/get_top_post_res.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/components/widget/appbar_title.dart';
import 'package:kayndrexsphere_mobile/presentation/route/navigator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent_tab_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/faq/all_forum_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/faq/view_single_post_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/faq/vm/get_post_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class FaqScreen extends HookConsumerWidget {
  const FaqScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(topPost);

    return Scaffold(
      backgroundColor: AppColors.appColor,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.transparent,
        title: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppBarTitle(title: "FAQ", color: Colors.white),
              Text(
                'Frequently asked questions',
                style: AppText.robotoStyle(
                  context,
                  AppColors.whiteColor,
                  14.sp,
                  FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        leading: const BackButton(color: Colors.white),
        // centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SafeArea(
        bottom: false,
        child: Column(children: [
          const SizedBox(
            height: 50,
          ),
          // const FaqHeader(),

          Expanded(
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(45.r)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 25.w,
                      right: 25.w,
                      top: 20.h,
                    ),
                    child: SizedBox(
                      height: 660.h,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            vm.when(
                                data: (data) {
                                  if (data.data!.posts!.isEmpty) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(AppImage.noPostYetImg),
                                        Space(32.h),
                                        Text(
                                          'No post added',
                                          style: AppText.robotoStyle(
                                              context,
                                              AppColors.textColor,
                                              16,
                                              FontWeight.w600),
                                        ),
                                        Text(
                                          'Click on forum to add post',
                                          style: AppText.robotoStyle(
                                              context,
                                              AppColors.textColor,
                                              12,
                                              FontWeight.w300),
                                        ),
                                      ],
                                    );
                                  }
                                  return RefreshIndicator(
                                    onRefresh: () async {
                                      return ref.refresh(topPost);
                                    },
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const AlwaysScrollableScrollPhysics(
                                              parent: BouncingScrollPhysics()),
                                      itemCount: data.data!.posts!.length,
                                      itemBuilder: (context, index) {
                                        final post = data.data!.posts![index];
                                        return InkWell(
                                          onTap: () {
                                            context
                                                .navigate(ViewSinglePostScreen(
                                              postId: post.postId!,
                                              title: post.title.toString(),
                                            ));
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                top: 15.w,
                                                bottom: 15.w,
                                                left: 12.w,
                                                right: 12.w),
                                            decoration: BoxDecoration(
                                              color: AppColors.appBgColor,
                                              border: Border(
                                                bottom: BorderSide(
                                                  width: 1.sp,
                                                  color: const Color.fromRGBO(
                                                      51, 51, 51, 0.1),
                                                ),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  post.title!,
                                                  style: AppText.robotoStyle(
                                                    context,
                                                    AppColors.textColor,
                                                    15.sp,
                                                    FontWeight.w500,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Colors.black38,
                                                  size: 15.sp,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const SizedBox(
                                          height: 10.0,
                                        );
                                      },
                                    ),
                                  );
                                },
                                loading: () => SizedBox(
                                    height: 20.w,
                                    width: 20.w,
                                    child: const CircularProgressIndicator()),
                                error: (Object error, StackTrace? stackTrace) {
                                  return Text(
                                    error.toString(),
                                    style: AppText.header2(
                                        context, AppColors.appColor, 20.sp),
                                  );
                                }),
                            Space(30.h),
                            vm is AsyncLoading<GetPostsRes>
                                ? SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                  )
                                : CustomButton(
                                    onPressed: () {
                                      pushNewScreen(
                                        context,
                                        withNavBar: false,
                                        screen: const AllForumScreen(),
                                        pageTransitionAnimation:
                                            PageTransitionAnimation.cupertino,
                                      );
                                    },
                                    buttonText: buttonText(context, "Forum"),
                                    bgColor: AppColors.appColor,
                                    textColor: AppColors.whiteColor,
                                    buttonWidth:
                                        MediaQuery.of(context).size.width,
                                    borderColor: AppColors.appColor,
                                  ),
                          ],
                        ),
                      ),
                    ),
                  )))
        ]),
      ),
    );
  }
}

// );

//

// Blandit tempus aenean consequat risus, congue.

// Odio volutpat sed fames augue. Duis pretium vitae non vulputate tristique vel, sagittis id. Id congue sed in.
