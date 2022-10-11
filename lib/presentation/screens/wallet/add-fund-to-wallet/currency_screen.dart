import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/create_wallet_res.dart';
import 'package:kayndrexsphere_mobile/presentation/components/AppSnackBar/snackbar/app_snackbar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/widget/appbar_title.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/vm/get_currency_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/create_wallet_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/swiftcode/search_box.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../vm/get_account_details_vm.dart';

class SelectCurrencyScreen extends StatefulHookConsumerWidget {
  final TextEditingController currencyCode;
  final String routeName;
  const SelectCurrencyScreen(
      {Key? key, required this.currencyCode, required this.routeName})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectCurrencyScreenState();
}

class _SelectCurrencyScreenState extends ConsumerState<SelectCurrencyScreen> {
  @override
  Widget build(BuildContext context) {
    final remoteCurrency = ref.watch(remoteCurrencyProvider);
    final currency = ref.watch(searchInputProvider);
    // final listState = useState("");

    ref.listen<RequestState>(createWalletProvider, (prev, value) {
      if (value is Success<CreateWalletRes>) {
        context.loaderOverlay.hide();
        ref.refresh(getAccountDetailsProvider);
        Navigator.pop(context);
      }

      if (value is Error) {
        context.loaderOverlay.hide();
        AppSnackBar.showErrorSnackBar(context, message: value.error.toString());
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
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: Colors.transparent,
          title:
              const AppBarTitle(title: "Choose Currency", color: Colors.black),
          leading: const BackButton(color: Colors.black),
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 23, right: 23),
            child: Column(
              children: [
                SearchBox(
                  hintText: "Search",
                  onTextEntered: (value) {
                    ref.read(currencySearchQueryStateProvider.notifier).state =
                        value;
                  },
                ),
                const Space(30),
                remoteCurrency.when(
                    error: (e, s) {
                      return Center(
                        child: TextButton.icon(
                            label: const Text('Retry'),
                            icon: const Icon(Icons.replay),
                            onPressed: () {
                              ref.refresh(remoteCurrencyProvider);
                            }),
                      );
                    },
                    loading: () => const CircularProgressIndicator.adaptive(
                          strokeWidth: 6,
                        ),
                    data: (data) {
                      if (currency.value == null) {
                        return const CircularProgressIndicator();
                      } else {
                        return Expanded(
                          child: ListView.separated(
                              itemCount: currency.value!.length,
                              itemBuilder: (context, index) {
                                final banks = currency.value![index];
                                return InkWell(
                                  onTap: () {
                                    if (widget.routeName == "createWallet") {
                                      ref
                                          .read(createWalletProvider.notifier)
                                          .createWallet(banks.code.toString());
                                      context.loaderOverlay.show();
                                    } else {
                                      setState(() {
                                        widget.currencyCode.text =
                                            banks.code.toString();
                                      });
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 0.5, color: Colors.black26)),
                                    child: Center(
                                        child: Text(
                                      banks.name.toString(),
                                      style: AppText.header2(
                                          context, AppColors.appColor, 20.sp),
                                    )),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 10,
                                );
                              }),
                        );
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
