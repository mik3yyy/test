import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/notification/widget/notification_toggle.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/widget/chat_drawer_contents.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_view_widget.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class ChatSettingScreen extends StatefulWidget {
  const ChatSettingScreen({Key? key}) : super(key: key);

  @override
  State<ChatSettingScreen> createState() => _ChatSettingScreenState();
}

bool isDrawerOpen = false;

class _ChatSettingScreenState extends State<ChatSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WalletViewWidget(
        appBar: Padding(
          padding: EdgeInsets.only(left: 18.w, right: 18.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.chevron_left,
                color: AppColors.whiteColor,
              ),
              Text(
                'Settings',
                style: AppText.body3(
                  context,
                  AppColors.whiteColor,
                ),
              ),
              GestureDetector(
                  onTap: () {
                    // isDrawerOpen = !isDrawerOpen;
                    setState(() {
                      isDrawerOpen = !isDrawerOpen;
                    });

                    print(isDrawerOpen);
                  },
                  child: Image.asset(AppImage.messageMenuIcon)),
            ],
          ),

          // CustomAppbarWithDrawer(
          //   isDrawerOpen: isDraweropen,
          // ),
        ),
        child: Container(
          height: 750.h,
          // padding:
          //     EdgeInsets.only(left: 25.w, right: 25.w, top: 15.w, bottom: 20.w),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              //Cheacking if drawer is open  if not display content
              isDrawerOpen == false
                  ? const SizedBox()
                  : const ChatDrawerContents(),
              Padding(
                padding: EdgeInsets.only(
                    left: 25.w, right: 25.w, top: 27.w, bottom: 20.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Night mode",
                          style: AppText.body5(
                            context,
                            AppColors.appColor,
                            16.sp,
                          ),
                        ),
                        //Hiding the toggle when drawer is opened, to make it not visible
                        isDrawerOpen == true
                            ? const SizedBox()
                            : const NotificationToggle()
                      ],
                    ),
                    Space(24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Notification",
                          style: AppText.body5(
                            context,
                            AppColors.appColor,
                            16.sp,
                          ),
                        ),
                        //Hiding the toggle when drawer is opened, to make it not visible
                        isDrawerOpen == true
                            ? const SizedBox()
                            : const NotificationToggle()
                      ],
                    ),
                    Space(24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Share my location",
                          style: AppText.body5(
                            context,
                            AppColors.appColor,
                            16.sp,
                          ),
                        ),
                        //Hiding the toggle when drawer is opened, to make it not visible
                        isDrawerOpen == true
                            ? const SizedBox()
                            : const NotificationToggle()
                      ],
                    ),
                    Space(24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Hide chat",
                          style: AppText.body5(
                            context,
                            AppColors.appColor,
                            16.sp,
                          ),
                        ),
                        //Hiding the toggle when drawer is opened, to make it not visible
                        isDrawerOpen == true
                            ? const SizedBox()
                            : const NotificationToggle()
                      ],
                    ),
                    Space(24.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// class CustomAppbarWithDrawer extends StatefulWidget {
//   bool isDrawerOpen;
//   CustomAppbarWithDrawer({
//     required this.isDrawerOpen,
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<CustomAppbarWithDrawer> createState() => _CustomAppbarWithDrawerState();
// }

// class _CustomAppbarWithDrawerState extends State<CustomAppbarWithDrawer> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         const Icon(
//           Icons.chevron_left,
//           color: AppColors.whiteColor,
//         ),
//         Text(
//           'Settings',
//           style: AppText.body3(
//             context,
//             AppColors.whiteColor,
//           ),
//         ),
//         GestureDetector(
//             onTap: () {
//               setState(() {
//                 widget.isDrawerOpen = !widget.isDrawerOpen;
//               });

//               print(widget.isDrawerOpen);
//             },
//             child: Image.asset(AppImage.messageMenuIcon)),
//       ],
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
// import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
// import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
// import 'package:kayndrexsphere_mobile/presentation/screens/notification/widget/notification_toggle.dart';
// import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_view_widget.dart';
// import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

// class ChatSettingScreen extends StatelessWidget {
//   const ChatSettingScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     bool isDraweropen = false;
//     return Scaffold(
//       body: WalletViewWidget(
//         appBar: Padding(
//           padding: EdgeInsets.only(left: 18.w, right: 18.w),
//           child: CustomAppbarWithDrawer(
//             isDrawerOpen: isDraweropen,
//           ),
//         ),
//         child: Container(
//           height: 750.h,
//           // padding:
//           //     EdgeInsets.only(left: 25.w, right: 25.w, top: 15.w, bottom: 20.w),
//           child: Stack(
//             alignment: Alignment.topRight,
//             children: [
//               isDraweropen == false
//                   ? const SizedBox()
//                   : Container(
//                       width: 200.w,
//                       height: 477.h,
//                       decoration: BoxDecoration(
//                         color: AppColors.fadedAppColor,
//                       ),
//                     ),
//               Padding(
//                 padding: EdgeInsets.only(
//                     left: 25.w, right: 25.w, top: 15.w, bottom: 20.w),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "Night mode",
//                           style: AppText.body5(
//                             context,
//                             AppColors.appColor,
//                             16.sp,
//                           ),
//                         ),
//                         const NotificationToggle()
//                       ],
//                     ),
//                     Space(24.h),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "Notification",
//                           style: AppText.body5(
//                             context,
//                             AppColors.appColor,
//                             16.sp,
//                           ),
//                         ),
//                         const NotificationToggle()
//                       ],
//                     ),
//                     Space(24.h),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "Share my location",
//                           style: AppText.body5(
//                             context,
//                             AppColors.appColor,
//                             16.sp,
//                           ),
//                         ),
//                         const NotificationToggle()
//                       ],
//                     ),
//                     Space(24.h),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "Hide chat",
//                           style: AppText.body5(
//                             context,
//                             AppColors.appColor,
//                             16.sp,
//                           ),
//                         ),
//                         const NotificationToggle()
//                       ],
//                     ),
//                     Space(24.h),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CustomAppbarWithDrawer extends StatefulWidget {
//   bool isDrawerOpen;
//   CustomAppbarWithDrawer({
//     required this.isDrawerOpen,
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<CustomAppbarWithDrawer> createState() => _CustomAppbarWithDrawerState();
// }

// class _CustomAppbarWithDrawerState extends State<CustomAppbarWithDrawer> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         const Icon(
//           Icons.chevron_left,
//           color: AppColors.whiteColor,
//         ),
//         Text(
//           'Settings',
//           style: AppText.body3(
//             context,
//             AppColors.whiteColor,
//           ),
//         ),
//         GestureDetector(
//             onTap: () {
//               setState(() {
//                 widget.isDrawerOpen = !widget.isDrawerOpen;
//               });

//               print(widget.isDrawerOpen);
//             },
//             child: Image.asset(AppImage.messageMenuIcon)),
//       ],
//     );
//   }
// }
