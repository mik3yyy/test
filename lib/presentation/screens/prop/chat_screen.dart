import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/chat_setting_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/models/message_model.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/models/user_model.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/widget/build_message_widget.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_view_widget.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../components/app text theme/app_text_theme.dart';

class ChatScreen extends StatefulWidget {
  final User user;
  const ChatScreen({required this.user, Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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
              Row(
                children: [
                  Image.asset(
                    widget.user.imageUrl,
                    width: 40.w,
                    height: 40.h,
                    // fit: BoxFit.cover,
                  ),
                  Space(5.w),
                  Text(
                    widget.user.name,
                    style: AppText.body2(
                      context,
                      AppColors.whiteColor,
                      16.sp,
                    ),
                  )
                ],
              ),
              GestureDetector(
                  onTap: () {
                    // isDrawerOpen = !isDrawerOpen;
                    setState(() {
                      isDrawerOpen = !isDrawerOpen;
                    });
                  },
                  child: Image.asset(AppImage.messageMenuIcon)),
            ],
          ),
        ),
        child: SizedBox(
          height: 750.h,
          // padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 15.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 300.h,
                padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 15.w),
                // height: MediaQuery.of(context).size.height,
                child: ListView.separated(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final messageItem = messages[index];
                    bool isMe = messageItem.sender.id == currentUser.id;
                    return BuildMessageWidget(
                      message: messageItem,
                      isMe: isMe,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox();
                  },
                ),
              ),
              Container(
                height: 90.h,
                width: double.infinity,
                padding: EdgeInsets.only(
                    left: 53.w, right: 53.w, bottom: 13.w, top: 13.w),
                decoration: BoxDecoration(
                  color: AppColors.appColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25.r),
                    bottomRight: Radius.circular(5.r),
                  ),
                ),
                child: Container(
                  width: 320.w,
                  padding: EdgeInsets.only(left: 13.w, right: 13.w),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(7.r),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.attach_file),
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Send Message',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.send),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
