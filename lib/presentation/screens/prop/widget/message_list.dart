import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/route/navigator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/chat_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/models/message_model.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class MessageList extends StatelessWidget {
  const MessageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView.separated(
          itemCount: chats.length,
          itemBuilder: (context, index) {
            final chat = chats[index];
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40.0,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Stack(
                      // alignment: Alignment.topCenter,
                      children: [
                        Image.asset(
                          chat.sender.imageUrl,
                          width: 40.w,
                          height: 40.h,
                          fit: BoxFit.cover,
                        ),
                        chat.isOnline == false
                            ? const SizedBox()
                            : Positioned(
                                right: 0.0,
                                bottom: 0.0,
                                child: CircleAvatar(
                                  backgroundColor: AppColors.greenColor,
                                  radius: 12.sp,
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                Space(12.w),
                GestureDetector(
                  onTap: () {
                    context.navigate(ChatScreen(user: chat.sender));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              chat.sender.name,
                              style: AppText.body2(
                                context,
                                AppColors.appColor,
                                14.sp,
                              ),
                            ),
                            // Space(176.w),
                            Text(
                              chat.time,
                              style: AppText.body2(
                                context,
                                AppColors.appColor,
                                14.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Space(3.h),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.76,
                        child: Text(
                          chat.text,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
        ),
      ),
    );
  }
}
