import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/model/contact/contact_list.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/extension/string_extension.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/contacts/view_contacts.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/contacts/vm/block_contact_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/contacts/vm/delete_contact._vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/contacts/vm/rename_contact_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/contacts/vm/unblock_contact_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/contacts/widget/rename_text_field.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class ContactBuild extends StatefulHookConsumerWidget {
  final ContactElement contact;
  final bool isLoading;

  const ContactBuild(
    this.contact,
    this.isLoading, {
    Key? key,
  }) : super(key: key);
  // const ContactBuild(
  //     {super.key, required this.contact, required this.isLoading});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ContactBuildState();
}

class _ContactBuildState extends ConsumerState<ContactBuild> {
  late FocusNode myFocusNode;
  bool isEdit = true;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }
  // List<String> item = ["Block", "Unblock", "Delete"];

  @override
  Widget build(BuildContext context) {
    final userName = widget.contact.contactName ??
        "${widget.contact.contact!.firstName!.capitalize()} ${widget.contact.contact!.lastName!.capitalize()}";
    final name = useTextEditingController(text: userName);

    return Container(
      padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
      color: Colors.grey.shade100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ContactsImage(
            contacts: widget.contact,
          ),
          const Space(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 200,
                      child: isEdit
                          ? Text(
                              userName,
                              style: AppText.header2(
                                  context, AppColors.appColor, 18.sp),
                            )
                          : RenameTextInput(
                              controller: name,
                              readOnly: isEdit,
                              focusNode: myFocusNode,
                              onTapOutside: (value) {
                                if (myFocusNode.hasPrimaryFocus) {
                                  myFocusNode.unfocus();
                                }

                                setState(() {
                                  name.text = userName;
                                  isEdit = true;
                                });
                              },
                              onEditingComplete: () {
                                if (myFocusNode.hasPrimaryFocus) {
                                  myFocusNode.unfocus();
                                }
                                setState(() {
                                  isEdit = true;
                                });
                                ref
                                    .read(renameContactProvider.notifier)
                                    .renameContact(
                                        name.text, widget.contact.id!);
                              },
                              validator: (value) {
                                return null;
                              },
                            ),
                    ),
                    // Text(
                    //   "${widget.contact.contact!.firstName!.capitalize()} ${widget.contact.contact!.lastName!.capitalize()}",
                    //   textAlign: TextAlign.center,
                    //   style:
                    //       AppText.header2(context, AppColors.appColor, 18.sp),
                    // ),
                    Space(10.w),
                    if ((widget.contact.isBlocked)! > 0) ...[
                      const Icon(
                        Icons.block,
                        color: Colors.red,
                        size: 15,
                      )
                    ]
                  ],
                ),
                const Space(3),
                Text(
                  widget.contact.contact!.email.toString(),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: AppText.header2(
                      context, AppColors.appColor.withOpacity(0.5), 16.sp),
                ),
              ],
            ),
          ),
          PopupMenuButton(
            child: const Icon(
              Icons.more_vert_sharp,
            ),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Text("Rename",
                      style:
                          AppText.header2(context, AppColors.appColor, 18.sp)),
                  onTap: () {
                    setState(() => isEdit = false);
                    myFocusNode.requestFocus();
                    // ref
                    //     .read(unBlockContactProvider.notifier)
                    //     .unblockContact(widget.contact.id!);
                  },
                ),
                PopupMenuItem(
                  enabled: widget.contact.isBlocked! > 0 ? false : true,
                  child: Text("Block",
                      style: AppText.header2(
                          context,
                          widget.contact.isBlocked! > 0
                              ? Colors.grey
                              : AppColors.appColor,
                          18.sp)),
                  onTap: widget.contact.isBlocked! > 0 || widget.isLoading
                      ? null
                      : () {
                          ref
                              .read(blockContactProvider.notifier)
                              .blockContact(widget.contact.id!);
                        },
                ),
                PopupMenuItem(
                  enabled: widget.contact.isBlocked == 0 ? false : true,
                  child: Text("Unblock",
                      style: AppText.header2(
                          context,
                          widget.contact.isBlocked == 0
                              ? Colors.grey
                              : AppColors.appColor,
                          18.sp)),
                  onTap: widget.contact.isBlocked! == 0 || widget.isLoading
                      ? null
                      : () {
                          ref
                              .read(unBlockContactProvider.notifier)
                              .unblockContact(widget.contact.id!);
                        },
                ),
                PopupMenuItem(
                  child: Text("Delete",
                      style: AppText.header2(context, Colors.red, 18.sp)),
                  onTap: widget.isLoading
                      ? null
                      : () {
                          ref
                              .read(deleteContactProvider.notifier)
                              .deleteContact(widget.contact.id!);
                        },
                ),
              ];
            },
          ),
          // PopupMenu<String>(
          //   // items: const ['Block', 'Unblock', 'Delete'],
          //   itemBuilder: (context) => const [
          //     PopupMenuItem(
          //       child: Text('Block'),
          //     ),
          //     PopupMenuItem(
          //       child: Text('Unblock'),
          //     ),
          //     PopupMenuItem(
          //       child: Text('Delete'),
          //     ),
          //   ],
          //   // menuEntries: const [
          //   //   PopupMenuItem(
          //   //     child: Text('Block'),
          //   //   ),
          //   //   PopupMenuItem(
          //   //     child: Text('Unblock'),
          //   //   ),
          //   //   PopupMenuItem(
          //   //     child: Text('Delete'),
          //   //   ),
          //   // ],
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(10),
          //   ),
          //   onSelected: (String value) {
          //     //print(value);
          //   },
          // ),
          // IconButton(
          //     onPressed: () {},
          //     icon: Icon(
          //       Icons.more_vert_sharp,
          //       size: 18,
          //     ))
        ],
      ),
    );
  }
}
