import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/model/contact/contact_list.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/widget/appbar_title.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent_tab_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/add_contact_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/chat_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/vm/get_contacts_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/swiftcode/search_box.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../components/app image/app_image.dart';

class PropScreen extends HookConsumerWidget {
  const PropScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final allContacts = ref.watch(allContactsProvider);
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
          child: Column(
            children: [
              const Space(20),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: const SearchBox()),
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
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          allContacts.when(
                              data: (data) {
                                if (data.data.contacts.isEmpty) {
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
                                                primary: Colors.white,
                                                backgroundColor:
                                                    AppColors.appColor,
                                                onSurface: Colors.grey,
                                              ),
                                              onPressed: () {
                                                pushNewScreen(
                                                  context,
                                                  screen: AddContactScreen(),
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
                                      addContact(context),
                                      const Space(30),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.62,
                                        child: ListView.separated(
                                          itemCount: data.data.contacts.length,
                                          itemBuilder: (context, index) {
                                            final contacts =
                                                data.data.contacts[index];
                                            return ContactBiuld(
                                              profileImage: contacts,
                                              text:
                                                  "${contacts.contact!.firstName} ${contacts.contact!.lastName}",
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
                              error: (e, s) =>
                                  Center(child: Text(e.toString())),
                              loading: () => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                3,
                                      ),
                                      const Center(
                                          child: CircularProgressIndicator()),
                                    ],
                                  )),
                          // Space(100.h),
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

Widget addContact(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      InkWell(
          onTap: () {
            pushNewScreen(
              context,
              screen: AddContactScreen(),
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
          },
          child: const Icon(
            Icons.person_add,
            color: AppColors.appColor,
          )),
      const Space(20),
      Image.asset(
        AppImage.moreIcon,
        color: AppColors.appColor,
      )
    ],
  );
}

class ContactBiuld extends StatelessWidget {
  final String text;
  final ContactElement profileImage;
  const ContactBiuld({Key? key, required this.text, required this.profileImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pushNewScreen(context,
            screen: ChatScreen(
              contact: profileImage,
            ),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.cupertino);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        color: Colors.grey.shade100,
        child: Row(
          children: [
            ContactImage(profileImage: profileImage.contact!),
            const Space(20),
            Text(
              text,
              textAlign: TextAlign.center,
              style: AppText.header2(context, AppColors.appColor, 19.sp),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey.shade400,
            )
          ],
        ),
      ),
    );
  }
}

class ContactImage extends StatelessWidget {
  final ContactContact profileImage;
  const ContactImage({Key? key, required this.profileImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return profileImage.profilePicture == null
        ? SizedBox(
            height: 50,
            width: 50,
            child: Image.asset(
              AppImage.profile,
              scale: 5,
              fit: BoxFit.cover,
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(300.0),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => SizedBox(
                height: 50,
                width: 50,
                child: Image.asset(
                  AppImage.profile,
                  scale: 5,
                  fit: BoxFit.cover,
                ),
              ),
              imageUrl: profileImage.profilePicture!.imageUrl.toString(),
            ),
          );
  }
}
