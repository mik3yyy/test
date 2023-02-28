import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/model/contact/contact_list.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/extension/string_extension.dart';
import 'package:kayndrexsphere_mobile/presentation/components/widget/appbar_title.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent_tab_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/contacts/add_contact_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/vm/For-search/search_contacts.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/vm/get_contacts_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/widget/loading-display/loading_display.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/swiftcode/search_box.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class ViewAllContact extends HookConsumerWidget {
  const ViewAllContact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final allContacts = ref.watch(allContactsProvider);
    final allContactsX = ref.watch(contactInputProvider);
    return Scaffold(
        backgroundColor: AppColors.appColor,
        appBar: AppBar(
          leading: const BackButton(),
          centerTitle: true,
          title: const AppBarTitle(title: "Contacts", color: Colors.white),
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
                        .read(allContactSearchQueryProvider.notifier)
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
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          allContacts.when(
                              data: (data) {
                                if (allContactsX.value == null) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
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
                                      addContact(context),
                                      const Space(30),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.62,
                                        child: ListView.separated(
                                          itemCount: allContactsX.value!.length,
                                          itemBuilder: (context, index) {
                                            final contact =
                                                allContactsX.value![index];
                                            return ContactBiuld(
                                              contact: contact,
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
  final ContactElement contact;
  const ContactBiuld({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
      color: Colors.grey.shade100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ContactsImage(
            contacts: contact,
          ),
          const Space(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${contact.contact!.firstName!.capitalize()} ${contact.contact!.lastName!.capitalize()}",
                  textAlign: TextAlign.center,
                  style: AppText.header2(context, AppColors.appColor, 18.sp),
                ),
                const Space(3),
                Text(
                  contact.contact!.email.toString(),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: AppText.header2(
                      context, AppColors.appColor.withOpacity(0.5), 16.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ContactsImage extends StatelessWidget {
  final ContactElement contacts;
  const ContactsImage({Key? key, required this.contacts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (contacts.contact?.profilePicture == null) {
      return SizedBox(
        height: 40,
        width: 40,
        child: Image.asset(
          AppImage.profile,
          scale: 5,
          fit: BoxFit.cover,
        ),
      );
    } else if (contacts.contact!.profilePicture!.imageUrl!.isEmpty) {
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
            imageUrl: contacts.contact!.profilePicture!.imageUrl!.toString(),
          ),
        ),
      );
    }
  }
}
