import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/presentation/components/AppSnackBar/snackbar/app_snackbar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/faq/vm/create_post_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/faq/vm/get_post_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class ViewSinglePostScreen extends StatefulHookConsumerWidget {
  //TODO: To implement search functionality for the forum
  final String postId;
  const ViewSinglePostScreen({required this.postId, Key? key})
      : super(key: key);

  @override
  _ViewSinglePostScreenState createState() => _ViewSinglePostScreenState();
}

class _ViewSinglePostScreenState extends ConsumerState<ViewSinglePostScreen> {
  bool isLikeTap = false;
  bool isUnLikeTap = false;
  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(fetchSinglePost(widget.postId));
    final isLike = PreferenceManager.isPostLike;
    final isUnLike = PreferenceManager.isPostUnLike;

    ref.listen<RequestState>(reactToPostVm, (T, value) {
      if (value is Success) {
        if (isLikeTap == true) {
          setState(() {
            PreferenceManager.isPostLike = true;
            PreferenceManager.isPostUnLike = false;
          });
        }
        if (isUnLikeTap == true) {
          setState(() {
            PreferenceManager.isPostUnLike = true;
            PreferenceManager.isPostLike = false;
          });
        }

        ref.refresh(fetchSinglePost(widget.postId));
      }
      if (value is Error) {
        return AppSnackBar.showErrorSnackBar(context,
            message: value.error.toString());
      }
    });

    ref.listen<RequestState>(unReactToPostVm, (T, value) {
      if (value is Success) {
        setState(() {
          PreferenceManager.isPostLike = false;
          PreferenceManager.isPostUnLike = false;
        });

        ref.refresh(fetchSinglePost(widget.postId));
      }
      if (value is Error) {
        return AppSnackBar.showErrorSnackBar(context,
            message: value.error.toString());
      }
    });
    return Scaffold(
      backgroundColor: AppColors.genericWidgetBgColor,
      appBar: AppBar(
        elevation: 0.2,
        backgroundColor: AppColors.appBgColor,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: (() => Navigator.pop(context)),
          child: Icon(
            Icons.arrow_back_ios_outlined,
            color: AppColors.textColor,
            size: 30.sp,
          ),
        ),
        title: Text(
          vm.maybeWhen(data: (v) => v.data!.title!, orElse: () => ''),
          style: AppText.robotoStyle(
              context, AppColors.textColor, 16, FontWeight.w700),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(
                top: 15.w, bottom: 15.w, left: 16.w, right: 16.w),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              border: Border(
                bottom: BorderSide(
                  width: 1.sp,
                  color: const Color.fromRGBO(51, 51, 51, 0.1),
                ),
              ),
              // border: Border.all(width: 1)
            ),
            child: Text(
              vm.maybeWhen(data: (v) => v.data!.text!, orElse: () => ''),
              style: AppText.robotoStyle(
                context,
                AppColors.textColor,
                14,
                FontWeight.w400,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                top: 15.w, bottom: 15.w, left: 16.w, right: 16.w),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              border: Border(
                bottom: BorderSide(
                  width: 1.sp,
                  color: const Color.fromRGBO(51, 51, 51, 0.1),
                ),
                top: BorderSide(
                  width: 1.sp,
                  color: const Color.fromRGBO(51, 51, 51, 0.1),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isLikeTap = !isLikeTap;
                          isUnLikeTap = false;
                        });
                        if (isLike == false) {
                          ref
                              .read(reactToPostVm.notifier)
                              .reactToPost(widget.postId, 'like');
                        } else {
                          ref
                              .read(unReactToPostVm.notifier)
                              .unReactToPost(widget.postId);
                        }
                      },
                      child: Icon(
                        isLike == false
                            ? Icons.thumb_up_alt_outlined
                            : Icons.thumb_up,
                        color: AppColors.greenColor,
                      ),
                    ),
                    Space(8.w),
                    Text(
                      vm.maybeWhen(
                          data: (v) => "${v.data!.noOfLikes!}",
                          orElse: () => '0'),
                      style: AppText.robotoStyle(
                        context,
                        AppColors.textColor,
                        14,
                        FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Space(100.w),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isUnLikeTap = !isUnLikeTap;
                          isLikeTap = false;
                        });
                        if (isUnLike == false) {
                          ref
                              .read(reactToPostVm.notifier)
                              .reactToPost(widget.postId, 'dislike');
                        } else {
                          ref
                              .read(unReactToPostVm.notifier)
                              .unReactToPost(widget.postId);
                        }
                      },
                      child: Icon(
                        isUnLike == false
                            ? Icons.thumb_down_alt_outlined
                            : Icons.thumb_down,
                        color: AppColors.redColor,
                      ),
                    ),
                    Space(8.w),
                    Text(
                      vm.maybeWhen(
                          data: (v) => "${v.data!.noOfDislikes}",
                          orElse: () => '0'),
                      style: AppText.robotoStyle(
                        context,
                        AppColors.textColor,
                        14,
                        FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
