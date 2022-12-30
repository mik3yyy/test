import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/forum/model/req/create_post_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/forum/model/res/get_top_post_res.dart';
import 'package:kayndrexsphere_mobile/presentation/components/AppSnackBar/snackbar/app_snackbar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/components/widget/appbar_title.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/faq/vm/create_post_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/faq/vm/get_post_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import 'package:loader_overlay/loader_overlay.dart';

class AddNewPostScreen extends StatefulHookConsumerWidget {
  const AddNewPostScreen({Key? key}) : super(key: key);
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddNewPostScreenState();
}

class _AddNewPostScreenState extends ConsumerState<AddNewPostScreen> {
  final postTitle = TextEditingController();
  final postText = TextEditingController();

  @override
  void initState() {
    postTitle.addListener(() {
      setState(() {});
    });
    postText.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    postTitle.dispose();
    postText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(createPostVm);
    ref.listen<RequestState>(createPostVm, (T, value) {
      if (value is Success<GetPostsRes>) {
        context.loaderOverlay.hide();
        Navigator.of(context).pop();
        ref.invalidate(allPost);
        ref.invalidate(topPost);
        return AppSnackBar.showSuccessSnackBar(context,
            message: value.value!.message!);
      }
      if (value is Error) {
        context.loaderOverlay.hide();
        return AppSnackBar.showErrorSnackBar(context,
            message: value.error.toString());
      }
    });
    return LoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: const Center(
          child: SpinKitWave(
            color: AppColors.appColor,
            size: 50.0,
          ),
        ),
        child: Scaffold(
          backgroundColor: AppColors.appColor,
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.light,
            backgroundColor: Colors.transparent,
            title:
                const AppBarTitle(title: "Add New Post", color: Colors.white),
            leading: const BackButton(color: Colors.white),
            // centerTitle: true,
            automaticallyImplyLeading: false,
            elevation: 0,
          ),
          body: SafeArea(
            bottom: false,
            child: Column(
              children: [
                const Space(30),
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
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            'Add post',
                            style: AppText.robotoStyle(
                              context,
                              AppColors.textColor,
                              16,
                              FontWeight.w700,
                            ),
                          ),
                          Space(15.h),
                          ForumTextFormField(
                            hint: "Post Title",
                            height: 75.h,
                            maxLines: 5,
                            controller: postTitle,
                          ),
                          Space(14.h),
                          ForumTextFormField(
                            hint: "Post Body",
                            height: 250.h,
                            maxLines: 15,
                            controller: postText,
                          ),
                          Space(60.h),
                          CustomButton(
                            onPressed:
                                postText.text.isEmpty && postTitle.text.isEmpty
                                    ? null
                                    : () {
                                        var createPostReq = CreatePostReq(
                                          title: postTitle.text.trim(),
                                          text: postText.text.trim(),
                                        );
                                        ref
                                            .read(createPostVm.notifier)
                                            .createPost(createPostReq);
                                        context.loaderOverlay.show();
                                      },
                            buttonText: vm is Loading
                                ? loading(
                                    Colors.white,
                                  )
                                : buttonText(context, "Post"),
                            bgColor:
                                postText.text.isEmpty || postTitle.text.isEmpty
                                    ? AppColors.appColor.withOpacity(0.3)
                                    : AppColors.appColor,
                            textColor: AppColors.whiteColor,
                            buttonWidth: MediaQuery.of(context).size.width,
                            borderColor: postText.text.isEmpty ||
                                    postTitle.text.isEmpty == true
                                ? AppColors.appColor.withOpacity(0.3)
                                : AppColors.appColor,
                          ),
                          Space(20.h),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Cancel',
                              style: AppText.robotoStyle(
                                context,
                                AppColors.textColor,
                                14.sp,
                                FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ))
              ],
            ),
          ),
        )

        // GenericWidget(
        //   appbar: const FaqAppBar(),
        //   bgColor: AppColors.genericWidgetBgColor,
        //   child: Padding(
        //     padding: EdgeInsets.only(
        //       left: 25.w,
        //       right: 25.w,
        //       top: 20.h,
        //     ),
        //     child: SizedBox(
        //       height: 600.h,
        //       child: Column(
        //         children: [
        //           Text(
        //             'Add post',
        //             style: AppText.robotoStyle(
        //               context,
        //               AppColors.textColor,
        //               16,
        //               FontWeight.w700,
        //             ),
        //           ),
        //           Space(15.h),
        //           ForumTextFormField(
        //             hint: "Post Title",
        //             height: 75.h,
        //             maxLines: 5,
        //             controller: postTitle,
        //           ),
        //           Space(14.h),
        //           ForumTextFormField(
        //             hint: "Post Body",
        //             height: 250.h,
        //             maxLines: 15,
        //             controller: postText,
        //           ),
        //           Space(29.h),
        //           CustomButton(
        //             onPressed: postText.text.isEmpty && postTitle.text.isEmpty
        //                 ? null
        //                 : () {
        //                     var createPostReq = CreatePostReq(
        //                       title: postTitle.text.trim(),
        //                       text: postText.text.trim(),
        //                     );
        //                     ref
        //                         .read(createPostVm.notifier)
        //                         .createPost(createPostReq);
        //                     context.loaderOverlay.show();
        //                   },
        //             buttonText: vm is Loading
        //                 ? loading(
        //                     Colors.white,
        //                   )
        //                 : buttonText(context, "Post"),
        //             bgColor: postText.text.isEmpty || postTitle.text.isEmpty
        //                 ? AppColors.appColor.withOpacity(0.3)
        //                 : AppColors.appColor,
        //             textColor: AppColors.whiteColor,
        //             buttonWidth: MediaQuery.of(context).size.width,
        //             borderColor:
        //                 postText.text.isEmpty || postTitle.text.isEmpty == true
        //                     ? AppColors.appColor.withOpacity(0.3)
        //                     : AppColors.appColor,
        //           ),
        //           Space(20.h),
        //           InkWell(
        //             onTap: () {
        //               Navigator.of(context).pop();
        //             },
        //             child: Text(
        //               'Cancel',
        //               style: AppText.robotoStyle(
        //                 context,
        //                 AppColors.textColor,
        //                 14.sp,
        //                 FontWeight.w500,
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        );
  }
}

class ForumTextFormField extends StatelessWidget {
  const ForumTextFormField(
      {Key? key,
      required this.controller,
      required this.height,
      required this.maxLines,
      required this.hint})
      : super(key: key);

  final TextEditingController controller;
  final double height;
  final int maxLines;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.only(top: 12.r, left: 12.w, right: 12.w),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        border: Border(
          bottom: BorderSide(
            width: 1.sp,
            color: const Color.fromRGBO(51, 51, 51, 0.1),
          ),
        ),
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppText.robotoStyle(
            context,
            AppColors.textColor,
            14.sp,
            FontWeight.w400,
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}
