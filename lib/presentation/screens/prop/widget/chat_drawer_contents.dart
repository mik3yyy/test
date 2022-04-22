import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/widget/chat_drawer_menu.dart';

class ChatDrawerContents extends StatelessWidget {
  const ChatDrawerContents({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 28.w, bottom: 15.w),
      width: 200.w,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.fadedAppColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              ChatDrawerMenu(
                text: "View Profile",
                onTap: () {},
              ),
              ChatDrawerMenu(
                text: "Clear Chat",
                onTap: () {},
              ),
              ChatDrawerMenu(
                text: "Delete Chat",
                onTap: () {},
              ),
              ChatDrawerMenu(
                text: "Setting",
                onTap: () {},
              ),
              ChatDrawerMenu(
                text: "Block user",
                onTap: () {},
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: 38.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(
                  Icons.chevron_left,
                  color: AppColors.whiteColor,
                ),
                Text(
                  "Home",
                  style: AppText.contactNameStyle(
                    context,
                    AppColors.inActiveColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
