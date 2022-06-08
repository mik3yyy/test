import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import '../../../components/app text theme/app_text_theme.dart';

class ViewVirtualCard extends StatefulHookConsumerWidget {
  const ViewVirtualCard({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ViewVirtualCardState();
}

class _ViewVirtualCardState extends ConsumerState<ViewVirtualCard> {
  final toggleStateProvider = StateProvider<bool>((ref) {
    return true;
  });
  @override
  Widget build(BuildContext context) {
    final toggle = ref.watch(toggleStateProvider.state);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Virtual card info',
          style: AppText.header2(context, Colors.black, 20.sp),
        ),
        leading: InkWell(
          onTap: (() => Navigator.pop(context)),
          child: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 40.h,
                width: MediaQuery.of(context).size.width,
                color: AppColors.appColor.withOpacity(0.1),
                child: Padding(
                  padding: EdgeInsets.only(right: 150.w),
                  child: Center(
                    child: Text(
                      'View virtual card information',
                      style:
                          AppText.body2Medium(context, Colors.black54, 20.sp),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 23.w, right: 23.w, top: 30.h),
                child: Column(
                  children: [
                    const VirtualCardInfo(
                        title: "Add name", name: "Janeth Doe"),
                    Space(30.h),
                    const VirtualCardInfo(
                        title: "Card number", name: "2342 2344 2344 2344"),
                    Space(30.h),
                    Row(
                      children: const [
                        SizedBox(
                          width: 150,
                          child: VirtualCardInfo(
                              title: "Card expiry", name: "12/23"),
                        ),
                        Spacer(),
                        SizedBox(
                          width: 150,
                          child: VirtualCardInfo(title: "CVV", name: "124"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Space(90.h),
              Container(
                color: Colors.grey.shade100,
                height: 200,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 23.w,
                    right: 23.w,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Add card to apple pay',
                            style:
                                AppText.header2(context, Colors.black, 20.sp),
                          ),
                          const Spacer(),
                          Switch.adaptive(
                              activeColor: Colors.greenAccent,
                              value: toggle.state,
                              onChanged: (value) {
                                toggle.state = !toggle.state;
                              }),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Add virtual card to Google pay',
                            style:
                                AppText.header2(context, Colors.black, 20.sp),
                          ),
                          const Spacer(),
                          Switch.adaptive(
                              activeColor: Colors.greenAccent,
                              value: toggle.state,
                              onChanged: (value) {
                                toggle.state = !toggle.state;
                              }),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Terminate card',
                            style:
                                AppText.header2(context, Colors.black, 20.sp),
                          ),
                          const Spacer(),
                          Switch.adaptive(
                              activeColor: Colors.greenAccent,
                              value: toggle.state,
                              onChanged: (value) {
                                toggle.state = !toggle.state;
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class ViewVirtualCard extends StatelessWidget {
//   const ViewVirtualCard({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         title: Text(
//           'Virtual card info',
//           style: AppText.header2(context, Colors.black, 20.sp),
//         ),
//         leading: InkWell(
//           onTap: (() => Navigator.pop(context)),
//           child: const Icon(
//             Icons.arrow_back_ios_outlined,
//             color: Colors.black,
//           ),
//         ),
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//         elevation: 0,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 height: 40.h,
//                 width: MediaQuery.of(context).size.width,
//                 color: AppColors.appColor.withOpacity(0.1),
//                 child: Padding(
//                   padding: EdgeInsets.only(right: 150.w),
//                   child: Center(
//                     child: Text(
//                       'View virtual card information',
//                       style:
//                           AppText.body2Medium(context, Colors.black54, 20.sp),
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: 23.w, right: 23.w, top: 30.h),
//                 child: Column(
//                   children: [
//                     const VirtualCardInfo(
//                         title: "Add name", name: "Janeth Doe"),
//                     Space(30.h),
//                     const VirtualCardInfo(
//                         title: "Card number", name: "2342 2344 2344 2344"),
//                     Space(30.h),
//                     Row(
//                       children: const [
//                         SizedBox(
//                           width: 150,
//                           child: VirtualCardInfo(
//                               title: "Card expiry", name: "12/23"),
//                         ),
//                         Spacer(),
//                         SizedBox(
//                           width: 150,
//                           child: VirtualCardInfo(title: "CVV", name: "124"),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               Space(90.h),
//               Container(
//                 color: Colors.grey.shade100,
//                 height: 200,
//                 child: Column(children: [
//                    Row(
//                       children: [
//                         Text(
//                           'Add to beneficiaries',
//                           style: AppText.header2(context, Colors.black, 20.sp),
//                         ),
//                         const Spacer(),
//                         Switch.adaptive(
//                             activeColor: Colors.greenAccent,
//                             value: toggle.state,
//                             onChanged: (value) {
//                               toggle.state = !toggle.state;
//                             }),
//                       ],
//                     ),

//                 ],),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class VirtualCardInfo extends StatelessWidget {
  final String title;
  final String name;
  const VirtualCardInfo({Key? key, required this.title, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppText.body2(context, Colors.black54, 15.sp),
        ),
        Space(10.h),
        Row(
          children: [
            Text(
              name,
              style: AppText.body2Medium(context, Colors.black54, 20.sp),
            ),
            const Spacer(),
            Icon(
              Icons.copy_outlined,
              color: Colors.grey.shade400,
            )
          ],
        ),
        Divider(
          thickness: 1,
          height: 20.h,
        ),
      ],
    );
  }
}
