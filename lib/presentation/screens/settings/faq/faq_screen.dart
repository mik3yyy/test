import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
        title: Column(
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
        leading: const BackButton(color: Colors.white),
        // centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Column(children: [
        // const SizedBox(
        //   height: 50,
        // ),
        // const FaqHeader(),
        const SizedBox(
          height: 20,
        ),
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
                                return ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: data.data!.posts!.length,
                                  itemBuilder: (context, index) {
                                    final post = data.data!.posts![index];
                                    return InkWell(
                                      onTap: () {
                                        context.navigate(ViewSinglePostScreen(
                                          postId: post.postId!,
                                        ));
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            top: 22.w,
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
                                          // border: Border.all(width: 1)
                                        ),
                                        child: Row(
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
                                              size: 18.sp,
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
                          Space(50.h),
                          CustomButton(
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
                            buttonWidth: MediaQuery.of(context).size.width,
                            borderColor: AppColors.appColor,
                          ),
                        ],
                      ),
                    ),

                    // Column(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Image.asset(AppImage.noPostYetImg),
                    //     Space(32.h),
                    //     Text(
                    //       'No post added',
                    //       style: AppText.robotoStyle(
                    //           context, AppColors.textColor, 16, FontWeight.w600),
                    //     ),
                    //     Text(
                    //       'Click on forum to add post',
                    //       style: AppText.robotoStyle(
                    //           context, AppColors.textColor, 12, FontWeight.w300),
                    //     ),
                    //     Space(20.h),
                    //     Container(
                    //       padding: EdgeInsets.only(
                    //           top: 22.w, bottom: 22.w, left: 12.w, right: 12.w),
                    //       decoration: BoxDecoration(
                    //         color: AppColors.appBgColor,
                    //         border: Border(
                    //           bottom: BorderSide(
                    //             width: 1.sp,
                    //             color: const Color.fromRGBO(51, 51, 51, 0.1),
                    //           ),
                    //         ),
                    //         // border: Border.all(width: 1)
                    //       ),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           Text(
                    //             'Learn about Kayndrexsphere',
                    //             style: AppText.robotoStyle(
                    //               context,
                    //               AppColors.textColor,
                    //               14,
                    //               FontWeight.w500,
                    //             ),
                    //           ),
                    //           Icon(
                    //             Icons.arrow_forward_ios_outlined,
                    //             color: AppColors.arrowLeftColor,
                    //             size: 20.sp,
                    //           ),
                    //           const Divider(
                    //             color: Color.fromRGBO(7, 39, 119, 0.2),
                    //             thickness: 1.5,
                    //             height: 20,
                    //             // indent: 5.0,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     Space(200.h),
                    //     CustomButton(
                    //       buttonText: 'Forum',
                    //       bgColor: AppColors.appColor,
                    //       textColor: AppColors.whiteColor,
                    //       buttonWidth: MediaQuery.of(context).size.width,
                    //       borderColor: AppColors.appColor,
                    //     )

                    //   ],
                    // ),
                  ),
                )))
      ]),
    );

    // return GenericWidget(
    //   appbar: const FaqAppBar(),
    //   bgColor: AppColors.genericWidgetBgColor,
    //   child: Padding(
    //     padding: EdgeInsets.only(
    //       left: 25.w,
    //       right: 25.w,
    //       top: 20.h,
    //     ),
    //     child: SizedBox(
    //       height: 660.h,
    //       child: SingleChildScrollView(
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             vm.when(
    //                 data: (data) {
    //                   if (data.data!.posts!.isEmpty) {
    //                     return Column(
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: [
    //                         Image.asset(AppImage.noPostYetImg),
    //                         Space(32.h),
    //                         Text(
    //                           'No post added',
    //                           style: AppText.robotoStyle(context,
    //                               AppColors.textColor, 16, FontWeight.w600),
    //                         ),
    //                         Text(
    //                           'Click on forum to add post',
    //                           style: AppText.robotoStyle(context,
    //                               AppColors.textColor, 12, FontWeight.w300),
    //                         ),
    //                       ],
    //                     );
    //                   }
    //                   return ListView.separated(
    //                     shrinkWrap: true,
    //                     itemCount: data.data!.posts!.length,
    //                     itemBuilder: (context, index) {
    //                       final post = data.data!.posts![index];
    //                       return InkWell(
    //                         onTap: () {
    //                           context.navigate(ViewSinglePostScreen(
    //                             postId: post.postId!,
    //                           ));
    //                         },
    //                         child: Container(
    //                           padding: EdgeInsets.only(
    //                               top: 22.w,
    //                               bottom: 22.w,
    //                               left: 12.w,
    //                               right: 12.w),
    //                           decoration: BoxDecoration(
    //                             color: AppColors.appBgColor,
    //                             border: Border(
    //                               bottom: BorderSide(
    //                                 width: 1.sp,
    //                                 color:
    //                                     const Color.fromRGBO(51, 51, 51, 0.1),
    //                               ),
    //                             ),
    //                             // border: Border.all(width: 1)
    //                           ),
    //                           child: Row(
    //                             mainAxisAlignment:
    //                                 MainAxisAlignment.spaceBetween,
    //                             children: [
    //                               Text(
    //                                 post.title!,
    //                                 style: AppText.robotoStyle(
    //                                   context,
    //                                   AppColors.textColor,
    //                                   14,
    //                                   FontWeight.w500,
    //                                 ),
    //                               ),
    //                               Icon(
    //                                 Icons.arrow_forward_ios_outlined,
    //                                 color: AppColors.arrowLeftColor,
    //                                 size: 18.sp,
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                       );
    //                     },
    //                     separatorBuilder: (context, index) {
    //                       return const SizedBox(
    //                         height: 10.0,
    //                       );
    //                     },
    //                   );
    //                 },
    //                 loading: () => SizedBox(
    //                     height: 20.w,
    //                     width: 20.w,
    //                     child: const CircularProgressIndicator()),
    //                 error: (Object error, StackTrace? stackTrace) {
    //                   return Text(
    //                     error.toString(),
    //                     style:
    //                         AppText.header2(context, AppColors.appColor, 20.sp),
    //                   );
    //                 }),
    //             Space(50.h),
    //             CustomButton(
    //               onPressed: () {
    //                 pushNewScreen(
    //                   context,
    //                   screen: const AllForumScreen(),
    //                   pageTransitionAnimation: PageTransitionAnimation.fade,
    //                 );
    //               },
    //               buttonText: 'Forum',
    //               bgColor: AppColors.appColor,
    //               textColor: AppColors.whiteColor,
    //               buttonWidth: MediaQuery.of(context).size.width,
    //               borderColor: AppColors.appColor,
    //             ),
    //           ],
    //         ),
    //       ),

    //       // Column(
    //       //   mainAxisAlignment: MainAxisAlignment.center,
    //       //   children: [
    //       //     Image.asset(AppImage.noPostYetImg),
    //       //     Space(32.h),
    //       //     Text(
    //       //       'No post added',
    //       //       style: AppText.robotoStyle(
    //       //           context, AppColors.textColor, 16, FontWeight.w600),
    //       //     ),
    //       //     Text(
    //       //       'Click on forum to add post',
    //       //       style: AppText.robotoStyle(
    //       //           context, AppColors.textColor, 12, FontWeight.w300),
    //       //     ),
    //       //     Space(20.h),
    //       //     Container(
    //       //       padding: EdgeInsets.only(
    //       //           top: 22.w, bottom: 22.w, left: 12.w, right: 12.w),
    //       //       decoration: BoxDecoration(
    //       //         color: AppColors.appBgColor,
    //       //         border: Border(
    //       //           bottom: BorderSide(
    //       //             width: 1.sp,
    //       //             color: const Color.fromRGBO(51, 51, 51, 0.1),
    //       //           ),
    //       //         ),
    //       //         // border: Border.all(width: 1)
    //       //       ),
    //       //       child: Row(
    //       //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       //         children: [
    //       //           Text(
    //       //             'Learn about Kayndrexsphere',
    //       //             style: AppText.robotoStyle(
    //       //               context,
    //       //               AppColors.textColor,
    //       //               14,
    //       //               FontWeight.w500,
    //       //             ),
    //       //           ),
    //       //           Icon(
    //       //             Icons.arrow_forward_ios_outlined,
    //       //             color: AppColors.arrowLeftColor,
    //       //             size: 20.sp,
    //       //           ),
    //       //           const Divider(
    //       //             color: Color.fromRGBO(7, 39, 119, 0.2),
    //       //             thickness: 1.5,
    //       //             height: 20,
    //       //             // indent: 5.0,
    //       //           ),
    //       //         ],
    //       //       ),
    //       //     ),
    //       //     Space(200.h),
    //       //     CustomButton(
    //       //       buttonText: 'Forum',
    //       //       bgColor: AppColors.appColor,
    //       //       textColor: AppColors.whiteColor,
    //       //       buttonWidth: MediaQuery.of(context).size.width,
    //       //       borderColor: AppColors.appColor,
    //       //     )

    //       //   ],
    //       // ),
    //     ),
    //   ),
    // );
  }
}

// );

//

// Blandit tempus aenean consequat risus, congue.

// Odio volutpat sed fames augue. Duis pretium vitae non vulputate tristique vel, sagittis id. Id congue sed in.
