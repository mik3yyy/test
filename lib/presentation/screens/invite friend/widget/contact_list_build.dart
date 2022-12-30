import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class ContactListBuild extends StatefulWidget {
  const ContactListBuild({Key? key}) : super(key: key);

  @override
  State<ContactListBuild> createState() => _ContactListBuildState();
}

final List<Contacts> _contacts = [
  Contacts(
      name: 'Amari SA',
      imgUrl: AppImage.phoneContactImg1,
      icon: const ContactChecBox()),
  Contacts(
      name: 'Ben kard',
      imgUrl: AppImage.phoneContactImg2,
      icon: const ContactChecBox()),
  Contacts(
      name: 'Carmile ku',
      imgUrl: AppImage.phoneContactImg1,
      icon: const ContactChecBox()),
  Contacts(
      name: 'Darlia frec',
      imgUrl: AppImage.phoneContactImg3,
      icon: const ContactChecBox()),
  Contacts(
      name: 'Dave Serts',
      imgUrl: AppImage.phoneContactImg4,
      icon: const ContactChecBox()),
  Contacts(
      name: 'Eohn Doe',
      imgUrl: AppImage.phoneContactImg5,
      icon: const ContactChecBox()),
  Contacts(
      name: 'Fohn Doe',
      imgUrl: AppImage.phoneContactImg1,
      icon: const ContactChecBox()),
  Contacts(
      name: 'Gohn Doe',
      imgUrl: AppImage.phoneContactImg4,
      icon: const ContactChecBox()),
  Contacts(
      name: 'Hohn Doe',
      imgUrl: AppImage.phoneContactImg6,
      icon: const ContactChecBox()),
];

class _ContactListBuildState extends State<ContactListBuild> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500.h,
      child: Scrollbar(
        thumbVisibility: true,
        controller: _scrollController,
        child: ListView.separated(
          controller: _scrollController,
          itemCount: _contacts.length,
          itemBuilder: (BuildContext context, int index) {
            final item = _contacts[index];
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(item.imgUrl),
                        Space(4.w),
                        Text(
                          item.name,
                          style: AppText.contactNameStyle(
                            context,
                            AppColors.appColor,
                          ),
                        ),
                      ],
                    ),
                    item.icon,
                  ],
                ),
              ],
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: Divider(
                color: AppColors.notificationDividerColor,
                thickness: 1.5,
                height: 20,
                // indent: 5.0,
              ),
            );
          },
        ),
      ),
    );
  }
}

class Contacts {
  final String name;
  final String imgUrl;
  final Widget icon;

  Contacts({
    required this.name,
    required this.imgUrl,
    required this.icon,
  });
}

class ContactChecBox extends StatefulWidget {
  const ContactChecBox({Key? key}) : super(key: key);

  @override
  State<ContactChecBox> createState() => _ContactChecBoxState();
}

class _ContactChecBoxState extends State<ContactChecBox> {
  bool newValue = false;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
        activeColor: AppColors.appColor,
        checkColor: AppColors.whiteColor,
        shape: const CircleBorder(),
        value: newValue,
        onChanged: (value) {
          setState(() {
            newValue = value!;
          });
        });
  }
}
