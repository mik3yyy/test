import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/widget/message_list.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_view_widget.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

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
              Image.asset(AppImage.messageMenuIcon),
            ],
          ),
        ),
        child: Container(
          height: 750.h,
          padding:
              EdgeInsets.only(left: 25.w, right: 25.w, top: 15.w, bottom: 39.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Messages",
                  style: AppText.body2(
                    context,
                    AppColors.appColor,
                    16.sp,
                  ),
                ),
                const Divider(),
                const MessageList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         height: 40.0,
//                         child: Align(
//                           alignment: Alignment.topCenter,
//                           child: Stack(
//                             // alignment: Alignment.topCenter,
//                             children: [
//                               Image.asset(
//                                 AppImage.phoneContactImg1,
//                                 width: 40.w,
//                                 height: 40.h,
//                                 fit: BoxFit.cover,
//                               ),
//                               Positioned(
//                                 right: 0.0,
//                                 bottom: 0.0,
//                                 child: CircleAvatar(
//                                   backgroundColor: AppColors.greenColor,
//                                   radius: 12.sp,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Space(12.w),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("John Doe"),
//                           SizedBox(
//                             width: MediaQuery.of(context).size.width * 0.62,
//                             child: Text(
//                               "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nisi in nisi, morbi imperdiet nibh. Tristique tincidunt non egestas iaculis",
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   Text("1.30 pm"),
//                 ],
//               ),