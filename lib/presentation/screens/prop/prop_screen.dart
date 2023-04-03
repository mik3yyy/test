import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/model/Dialog/all_dialog.dart'
    as all_dialog;
import 'package:kayndrexsphere_mobile/Data/model/Dialog/all_dialog.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/extension/string_extension.dart';
import 'package:kayndrexsphere_mobile/presentation/components/widget/appbar_title.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent_tab_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/contacts/add_contact_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/chat_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/contacts/view_contacts.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/vm/For-search/get_all_dialogs_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/vm/get_dialog_messages_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/widget/loading-display/loading_display.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/user_profile/user_profile_db.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/swiftcode/search_box.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../components/app image/app_image.dart';

class PropScreen extends HookConsumerWidget {
  const PropScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final dialogs = ref.watch(alldialogsProvider);
    final searchDialog = ref.watch(dialogInputProvider);
    return Scaffold(
        backgroundColor: AppColors.appColor,
        appBar: AppBar(
          leading: const BackButton(),
          centerTitle: true,
          title: const AppBarTitle(title: "Messages", color: Colors.white),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const Space(20),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: SearchBox(
                    onTextEntered: (value) => ref
                        .read(alldialgSearchQueryProvider.notifier)
                        .state = value,
                  )),
              const Space(20),
              Expanded(
                  child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(45.r)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: SizedBox(
                    height: 660.h,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          dialogs.when(
                              data: (data) {
                                if (searchDialog.value == null) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                if (data.data!.isEmpty) {
                                  return Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              4),
                                      child: Column(
                                        children: [
                                          Text(
                                            "You have No contact\nAdd a new contact and connect with friends",
                                            textAlign: TextAlign.center,
                                            style: AppText.header2(context,
                                                AppColors.appColor, 19.sp),
                                          ),
                                          const Space(20),
                                          SizedBox(
                                            height: 50,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            child: TextButton(
                                              child: const Text('Add Contact'),
                                              style: TextButton.styleFrom(
                                                foregroundColor: Colors.white,
                                                backgroundColor:
                                                    AppColors.appColor,
                                                disabledForegroundColor:
                                                    Colors.grey,
                                              ),
                                              onPressed: () {
                                                pushNewScreen(
                                                  context,
                                                  screen: AddContactScreen(),
                                                  withNavBar: false,
                                                  pageTransitionAnimation:
                                                      PageTransitionAnimation
                                                          .cupertino,
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  return Column(
                                    children: [
                                      const Space(20),
                                      viewContacts(context),
                                      const Space(30),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.62,
                                        child: ListView.separated(
                                          itemCount: searchDialog.value!.length,
                                          itemBuilder: (context, index) {
                                            final dialog =
                                                searchDialog.value![index];
                                            return DialogBuild(
                                              message: dialog,
                                            );
                                          },
                                          separatorBuilder: (context, index) {
                                            return const SizedBox(
                                              height: 20,
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              },
                              error: (e, s) => const ContactLoading(),
                              loading: () => const ContactLoading()),
                        ],
                      ),
                    ),
                  ),
                ),
              ))
            ],
          ),
        ));
  }
}

Widget viewContacts(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      InkWell(
          onTap: () {
            pushNewScreen(
              context,
              screen: const ViewAllContact(),
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
          },
          child: Row(
            children: [
              Text(
                "Contacts",
                textAlign: TextAlign.center,
                style: AppText.header2(context, AppColors.appColor, 16.sp),
              ),
              Space(15.w),
              const Icon(
                Icons.contacts_rounded,
                color: AppColors.appColor,
              ),
            ],
          )),
      const Space(20),
    ],
  );
}

class DialogBuild extends HookConsumerWidget {
  final all_dialog.Datum message;
  const DialogBuild({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final currentUser = ref.watch(savedUserProvider);
    return InkWell(
      onTap: () {
        pushNewScreen(context,
            screen: ChatScreen(
              datum: message,
            ),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.cupertino);
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        color: Colors.grey.shade100,
        child:
            // const Space(20),
            Row(
          children: [
            DialogContactImage(datum: message),
            const Space(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${message.title!.capitalize() == "" ? "${message.privateDialogOtherUser?.firstName!.capitalize()} ${message.privateDialogOtherUser?.lastName!.capitalize()}" : message.title!.capitalize()} ",
                    textAlign: TextAlign.center,
                    style: AppText.header2(context, AppColors.appColor, 19.sp),
                  ),
                  const Space(5),
                  Row(
                    children: [
                      if (currentUser.email ==
                          message.lastMessage!.from!.email) ...[
                        Text(
                          "You:",
                          textAlign: TextAlign.center,
                          style: AppText.header2(context,
                              AppColors.appColor.withOpacity(0.6), 16.sp),
                        ),
                      ] else ...[
                        Text(
                          "${message.lastMessage!.from!.firstName.toString()} :",
                          textAlign: TextAlign.center,
                          style: AppText.header2(context,
                              AppColors.appColor.withOpacity(0.6), 19.sp),
                        ),
                      ],
                      const Space(5),
                      Flexible(
                        child: Text(
                          message.lastMessage!.message.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: AppText.header2(context,
                              AppColors.appColor.withOpacity(0.6), 16.sp),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey.shade400,
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}

class DialogContactImage extends StatelessWidget {
  final Datum datum;
  const DialogContactImage({Key? key, required this.datum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (datum.privateDialogOtherUser!.profilePicture == null) {
      return SizedBox(
        height: 40,
        width: 40,
        child: Image.asset(
          AppImage.profile,
          scale: 5,
          fit: BoxFit.cover,
        ),
      );
    } else if (datum
        .privateDialogOtherUser!.profilePicture!.imageUrl!.isEmpty) {
      return SizedBox(
        height: 40,
        width: 40,
        child: Image.asset(
          AppImage.profile,
          scale: 5,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return SizedBox(
        height: 40,
        width: 40,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(300.0),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => SizedBox(
              height: 40,
              width: 40,
              child: Image.asset(
                AppImage.profile,
                scale: 5,
                fit: BoxFit.cover,
              ),
            ),
            imageUrl: datum.privateDialogOtherUser!.profilePicture!.imageUrl
                .toString(),
          ),
        ),
      );
    }
  }
}
