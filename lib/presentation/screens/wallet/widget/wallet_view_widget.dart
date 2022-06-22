import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/wallet_transfer_vm.dart.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import 'package:loader_overlay/loader_overlay.dart';

class WalletViewWidget extends StatelessWidget {
  final Widget appBar;
  final Widget child;
  const WalletViewWidget({Key? key, required this.appBar, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          height: 900.h,
          color: AppColors.appColor,
          child: Column(
            children: [
              Space(55.h),
              appBar,
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(45.r)),
              ),
              // height: 540,
              width: 33.w,
              child: child),
        ),
      ],
    );
  }
}

class GenericWidget extends HookConsumerWidget {
  final Widget appbar;
  final Widget child;
  final Color bgColor;
  const GenericWidget(
      {Key? key,
      required this.appbar,
      required this.child,
      required this.bgColor})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    ref.listen<RequestState>(transferToWalletProvider, (T, value) {
      if (value is Success) {
        context.loaderOverlay.hide();
      }
      if (value is Error) {
        context.loaderOverlay.hide();
      }
    });

    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: const Center(
        child: SpinKitWave(
          color: AppColors.appColor,
          size: 50.0,
        ),
      ),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.appColor,
          body: SafeArea(
            child: CustomScrollView(
              physics: const NeverScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: appbar,
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Container(
                          decoration: BoxDecoration(
                            color: bgColor,
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(45.r)),
                          ),
                          // height: 600,
                          width: double.maxFinite,
                          child: child)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
