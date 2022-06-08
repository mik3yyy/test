import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/user_account_details_res.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent-tab-view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/account/available_wallet.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/account/no_wallet.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/account/view_all_wallets.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/get_account_details_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_view_widget.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../components/app image/app_image.dart';
import '../../../components/app text theme/app_text_theme.dart';
import '../../../components/reusable_widget.dart/custom_button.dart';

class CreateWallet extends StatefulHookConsumerWidget {
  final BuildContext menuScreenContext;
  final Function onScreenHideButtonPressed;
  final bool hideStatus;
  const CreateWallet(
      {Key? key,
      required this.menuScreenContext,
      required this.onScreenHideButtonPressed,
      required this.hideStatus})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateWalletState();
}

class _CreateWalletState extends ConsumerState<CreateWallet> {
  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(getAccountDetailsProvider);
    return vm.when(success: (value) {
      //Checking if user wallet is empty, then show no wallet screen else show list of wallet available
      return value!.data!.wallets!.isEmpty
          ? const NoWalletWidget()
          : AvailableWallet(
              wallet: value.data!.wallets!,
            );
    }, error: (Object error, StackTrace? stackTrace) {
      return Center(
        child: Text(
          error.toString(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }, idle: () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }, loading: () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}

// class CreateWallet extends StatefulWidget {
//   final BuildContext menuScreenContext;
//   final Function onScreenHideButtonPressed;
//   final bool hideStatus;
//   const CreateWallet(
//       {Key? key,
//       required this.menuScreenContext,
//       required this.onScreenHideButtonPressed,
//       required this.hideStatus})
//       : super(key: key);

//   @override
//   State<CreateWallet> createState() => _CreateWalletState();
// }

// class _CreateWalletState extends State<CreateWallet> {
//   @override
//   Widget build(BuildContext context) {
//     return GenericWidget(
//       appbar: Padding(
//         padding: EdgeInsets.only(left: 20.w, right: 20.w),
//         child: Column(
//           children: [
//             Space(20.h),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       'Wallets',
//                       style: AppText.header1(context, Colors.white, 25.sp),
//                     ),
//                     Space(10.h),
//                     Text(
//                       'Lets you view your currency accounts',
//                       style: AppText.body2(context, Colors.white, 18.sp),
//                     ),
//                   ],
//                 ),
//                 const Spacer(),
//                 Icon(
//                   Icons.notifications,
//                   color: Colors.white,
//                   size: 30.sp,
//                 ),
//                 Space(10.w),
//                 const CircleAvatar(
//                   radius: 18.0,
//                   backgroundImage: AssetImage(
//                     AppImage.image1,
//                   ),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//       bgColor: AppColors.whiteColor,
//       child: SizedBox(
//         height: 700.h,
//         child: NoWalletWidget(),
//       ),
//     );
//   }
// }

