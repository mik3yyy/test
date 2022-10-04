import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/model/contact/contact_list.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/prop_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/vm/get_dialog_messages_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../components/app text theme/app_text_theme.dart';

class ChatScreen extends StatefulHookConsumerWidget {
  final ContactElement contact;
  const ChatScreen({Key? key, required this.contact}) : super(key: key);

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final allMessages = ref.watch(alldialogMessages(widget.contact.id!));
    return Scaffold(
        backgroundColor: AppColors.appColor,
        body: SafeArea(
            child: Column(
          children: [
            const Space(30),
            Row(
              children: [
                const BackButton(
                  color: Colors.white,
                ),
                const Space(30),
                ContactImage(profileImage: widget.contact.contact!),
                const Space(20),
                Text(
                  "${widget.contact.contact?.firstName} ${widget.contact.contact?.lastName}",
                  style: AppText.body2Bold(
                    context,
                    AppColors.whiteColor,
                    25.sp,
                  ),
                )
                //             )
              ],
            ),
            const Space(50),
            Expanded(
                child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(45.r)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  children: [
                    allMessages.when(
                        data: (data) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.62,
                            child: ListView.separated(
                              itemCount: data.data!.messages!.length,
                              itemBuilder: (context, index) {
                                final message = data.data!.messages![index];
                                return Text(message.message.toString());
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 20,
                                );
                              },
                            ),
                          );
                        },
                        error: (e, s) => Text(e.toString()),
                        loading: () => const CircularProgressIndicator()),
                    Container(
                      width: 320.w,
                      padding: EdgeInsets.only(left: 13.w, right: 13.w),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
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
                  ],
                ),
              ),
            ))
          ],
        ))

        //  WalletViewWidget(
        //   appBar: Padding(
        //     padding: EdgeInsets.only(left: 18.w, right: 18.w),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         const Icon(
        //           Icons.chevron_left,
        //           color: AppColors.whiteColor,
        //         ),
        //         Row(
        //           children: [
        //             Space(5.w),
        //             Text(
        //               "${widget.contact.firstName} ${widget.contact.lastName}",
        //               style: AppText.body2Bold(
        //                 context,
        //                 AppColors.whiteColor,
        //                 25.sp,
        //               ),
        //             )
        //           ],
        //         ),
        //         GestureDetector(
        //             onTap: () {
        //               // isDrawerOpen = !isDrawerOpen;
        //               setState(() {
        //                 isDrawerOpen = !isDrawerOpen;
        //               });
        //             },
        //             child: Image.asset(AppImage.messageMenuIcon)),
        //       ],
        //     ),
        //   ),
        //   child: SizedBox(
        //     height: 750.h,
        //     // padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 15.w),
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         Container(
        //           height: 300.h,
        //           padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 15.w),
        //           // height: MediaQuery.of(context).size.height,
        //           child: ListView.separated(
        //             itemCount: messages.length,
        //             itemBuilder: (context, index) {
        //               final messageItem = messages[index];
        //               bool isMe = messageItem.sender.id == currentUser.id;
        //               return BuildMessageWidget(
        //                 message: messageItem,
        //                 isMe: isMe,
        //               );
        //             },
        //             separatorBuilder: (context, index) {
        //               return const SizedBox();
        //             },
        //           ),
        //         ),
        //         Container(
        //           height: 90.h,
        //           width: double.infinity,
        //           padding: EdgeInsets.only(
        //               left: 53.w, right: 53.w, bottom: 13.w, top: 13.w),
        //           decoration: BoxDecoration(
        //             color: AppColors.appColor,
        //             borderRadius: BorderRadius.only(
        //               bottomLeft: Radius.circular(25.r),
        //               bottomRight: Radius.circular(5.r),
        //             ),
        //           ),
        //           child: Container(
        //             width: 320.w,
        //             padding: EdgeInsets.only(left: 13.w, right: 13.w),
        //             decoration: BoxDecoration(
        //               color: AppColors.whiteColor,
        //               borderRadius: BorderRadius.circular(7.r),
        //             ),
        //             child: Row(
        //               children: [
        //                 const Icon(Icons.attach_file),
        //                 Expanded(
        //                   child: TextFormField(
        //                     decoration: const InputDecoration(
        //                       hintText: 'Send Message',
        //                       border: InputBorder.none,
        //                     ),
        //                   ),
        //                 ),
        //                 IconButton(
        //                   onPressed: () {},
        //                   icon: const Icon(Icons.send),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        );
  }
}
