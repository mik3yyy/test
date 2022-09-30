import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/route/navigator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent_tab_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/faq/add_new_post_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/faq/view_single_post_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/faq/vm/get_post_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/faq/vm/search_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/faq/widget/faq_app_bar.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class AllForumScreen extends HookConsumerWidget {
  const AllForumScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remoteVM = ref.watch(allPost);
    final postSearchInput = ref.watch(postInputProvider);

    return Scaffold(
      backgroundColor: AppColors.appColor,
      body: Column(
        children: [
          const Space(50),
          const FaqAppBar(),
          const Space(30),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(45.r)),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: 25.w,
                right: 25.w,
                top: 20.h,
              ),
              child: SizedBox(
                height: 680.h,
                child: SingleChildScrollView(
                  child: Column(
                    // shrinkWrap: true,
                    children: [
                      remoteVM.when(
                          data: (data) {
                            if (data.data!.posts!.isEmpty) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
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

                            if (postSearchInput.value == null) {
                              return const CircularProgressIndicator();
                            }
                            return ListView.separated(
                              shrinkWrap: true,
                              itemCount: postSearchInput.value!.length,
                              itemBuilder: (context, index) {
                                final post = postSearchInput.value![index];
                                return InkWell(
                                  onTap: () {
                                    context.navigate(ViewSinglePostScreen(
                                      postId: post.postId!,
                                    ));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        top: 22.h,
                                        bottom: 22.w,
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
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              post.title!,
                                              style: AppText.robotoStyle(
                                                context,
                                                AppColors.textColor,
                                                14,
                                                FontWeight.w500,
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              color: AppColors.arrowLeftColor,
                                              size: 20.sp,
                                            ),
                                          ],
                                        ),
                                        Space(19.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              DateFormat.yMMMEd()
                                                  .format(post.createdAt),
                                              // dateCreated,
                                              style: AppText.robotoStyle(
                                                context,
                                                AppColors.textColor,
                                                11,
                                                FontWeight.w400,
                                              ),
                                            ),
                                            Text(
                                              DateFormat.jm()
                                                  .format(post.createdAt),
                                              style: AppText.robotoStyle(
                                                context,
                                                AppColors.textColor,
                                                11,
                                                FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox();
                              },
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
                      CustomButton(
                        onPressed: () {
                          pushNewScreen(
                            context,
                            screen: const AddNewPostScreen(),
                            pageTransitionAnimation:
                                PageTransitionAnimation.fade,
                          );
                        },
                        buttonText: 'Add a Post',
                        bgColor: AppColors.appColor,
                        textColor: AppColors.whiteColor,
                        buttonWidth: MediaQuery.of(context).size.width,
                        borderColor: AppColors.appColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
