import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/res/saved_id.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/profile_image/profile_image.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../../components/app image/app_image.dart';
import '../../../../components/app text theme/app_text_theme.dart';

class IDbuild extends StatelessWidget {
  final Identification id;
  const IDbuild({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            builder: (context) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.55,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 20.w,
                    right: 20.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Space(40),
                      Text("ID Type:",
                          style: AppText.body2(context, Colors.black45, 15.sp)),
                      Text(id.idType.toString(),
                          style: AppText.body2(context, Colors.black, 25.sp)),
                      const Space(30),
                      Center(
                        child: Transform.scale(
                          scale: 1.2,
                          child: SizedBox(
                            height: 200,
                            child: KYNetworkImage(
                                url: id.fileFront.toString(),
                                errorImage: Image.asset(AppImage.profile,
                                    scale: 5, fit: BoxFit.contain),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      const Space(30),
                      Text("ID number:",
                          style: AppText.body2(context, Colors.black45, 15.sp)),
                      Text(id.idNo.toString(),
                          style: AppText.body2(context, Colors.black, 25.sp)),
                    ],
                  ),
                ),
              );
            });
      },
      child: Container(
          padding: const EdgeInsets.all(10),
          color: Colors.grey.shade100,
          child: Row(
            children: [
              SizedBox(
                height: 70,
                width: 100,
                child: KYNetworkImage(
                    url: id.fileFront.toString(),
                    errorImage: Image.asset(
                      AppImage.profile,
                      scale: 7,
                      fit: BoxFit.cover,
                    ),
                    fit: BoxFit.fill),
              ),
              const Space(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("ID Type:",
                      style: AppText.body2(context, Colors.black45, 15.sp)),
                  Text(id.idType.toString()),
                  const Space(10),
                  Text("ID number:",
                      style: AppText.body2(context, Colors.black45, 15.sp)),
                  Text(id.idNo.toString())
                ],
              )
            ],
          )),
    );
  }
}
