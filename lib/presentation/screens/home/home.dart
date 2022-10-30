import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/set_default_as_wallet_res.dart';
import 'package:kayndrexsphere_mobile/presentation/components/AppSnackBar/snackbar/app_snackbar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/amount_display.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomView/bottomview.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/name_image_header.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/user_profile/user_profile_db.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/refreshToken/refresh_token_controller.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/currency_transactions_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/set_wallet_as_default_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../components/app text theme/app_text_theme.dart';
import '../settings/profile/vm/get_profile_vm.dart';

class HomePage extends StatefulHookConsumerWidget {
  final BuildContext menuScreenContext;
  final Function onScreenHideButtonPressed;
  final bool hideStatus;
  const HomePage(
      {Key? key,
      required this.menuScreenContext,
      required this.onScreenHideButtonPressed,
      required this.hideStatus})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with WidgetsBindingObserver {
  bool isBackground = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    ref.read(refreshControllerProvider.notifier).refreshToken();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    setState(() {
      isBackground = state == AppLifecycleState.inactive;
    });

    // final isBackground = state == AppLifecycleState.inactive;

    if (isBackground) {
      log("$isBackground");
    }

    /* if (isBackground) {
      // service.stop();
    } else {
      // service.start();
    }*/
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      ref.read(savedUserProvider.notifier).getUserDb();
      // ref.read(walletDataProvider.notifier).getData();
    });
    final savedUser = ref.watch(savedUserProvider);
    final defaultWallet = ref.watch(userProfileProvider);
    final setwallet = ref.watch(setWalletAsDefaultProvider);
    final currency = useTextEditingController();

    ref.listen<RequestState>(setWalletAsDefaultProvider, (prev, value) {
      if (value is Success<SetWalletAsDefaultRes>) {
        ref.refresh(userProfileProvider);
        ref.refresh(currencyTransactionProvider(
            value.value!.data!.wallet!.currencyCode!));
      }

      if (value is Error) {
        AppSnackBar.showSuccessSnackBar(context,
            message: "Wallet could not be set as default at the moment");
      }
    });

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.appColor,
        body: SafeArea(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            InnerPageLoadingIndicator(loadingStream: setwallet is Loading),
            Padding(
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
              ),
              child: Column(
                children: [
                  Space(20.h),
                  NameAndImageHeader(
                    defaultWallet: defaultWallet,
                    savedUser: savedUser,
                  ),
                  Space(20.h),
                  AmountDisplay(
                    currency: currency,
                    defaultWallet: defaultWallet,
                    savedUser: savedUser,
                    isBackGround: isBackground,
                  )
                ],
              ),
            ),
            const Space(20),
            BottomView(defaultWallet: defaultWallet)
          ]),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildItem(String currencyValue) {
    return DropdownMenuItem(
        value: currencyValue,
        child: Text(
          currencyValue,
          style: AppText.body2Bold(context, AppColors.appColor, 19.sp),
        ));
  }
}

class InnerPageLoadingIndicator extends StatelessWidget {
  final bool loadingStream;
  const InnerPageLoadingIndicator({required this.loadingStream, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    //
    return loadingStream
        ? const LinearProgressIndicator(
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.appColor))
        : const SizedBox(height: 3.5);
  }
}
