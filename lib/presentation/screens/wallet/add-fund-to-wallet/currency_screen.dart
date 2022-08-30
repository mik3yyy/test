import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/currency_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/create_wallet_res.dart';
import 'package:kayndrexsphere_mobile/presentation/components/AppSnackBar/snackbar/app_snackbar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
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
  List<Currency> bank = [];
  List<Currency> filterableBank = [];

  Future<List<Currency>> filterClients(
      {required List<Currency> banks, required String text}) {
    if (text.isEmpty) {
      banks = bank;
      return Future.value(banks);
    }
    List<Currency> result = banks
        .where((country) => country.name!.toLowerCase().contains(text))
        .toList();
    return Future.value(result);
  }

  void _filterClients(String text) async {
    filterableBank = await filterClients(banks: bank, text: text);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final currency = ref.watch(getCurrencyProvider);
    final listState = useState("");

    ref.listen<RequestState>(createWalletProvider, (prev, value) {
      if (value is Success<CreateWalletRes>) {
        context.loaderOverlay.hide();
        ref.read(getAccountDetailsProvider.notifier).getAccountDetails();
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
          backgroundColor: Colors.transparent,
          title: Text(
            'Choose a currency',
            style: AppText.header2(context, Colors.black, 20.sp),
          ),
          leading: InkWell(
            onTap: (() => Navigator.pop(context)),
            child: const Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.black,
            ),
          ),
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 23, right: 23),
            child: Column(
              children: [
                const Space(20),
                SearchBox(
                  hintText: "Search",
                  onTextEntered: (value) {
                    _filterClients(value);
                    listState.value = value;
                  },
                ),
                const Space(30),
                listState.value.isNotEmpty
                    ? Expanded(
                        child: ListView.separated(
                            itemCount: filterableBank.length,
                            itemBuilder: (context, index) {
                              final bank = filterableBank[index];
                              return InkWell(
                                onTap: () {
                                  if (widget.routeName == "createWallet") {
                                    ref
                                        .read(createWalletProvider.notifier)
                                        .createWallet(bank.code.toString());
                                    context.loaderOverlay.show();
                                  } else {
                                    setState(() {
                                      widget.currencyCode.text =
                                          bank.code.toString();
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
                                    bank.name.toString(),
                                    style: AppText.body2(
                                        context, Colors.black, 18),
                                  )),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 10,
                              );
                            }),
                      )
                    : currency.when(
                        error: (e, s) => Text(e.toString()),
                        idle: () => const CircularProgressIndicator.adaptive(
                              strokeWidth: 6,
                            ),
                        loading: () => const CircularProgressIndicator.adaptive(
                              strokeWidth: 6,
                            ),
                        success: (data) {
                          setState(() {
                            bank = data!.data.currencies;
                          });

                          return Expanded(
                            child: ListView.separated(
                                itemCount: bank.length,
                                itemBuilder: (context, index) {
                                  final banks = bank[index];
                                  return InkWell(
                                    onTap: () {
                                      if (widget.routeName == "createWallet") {
                                        ref
                                            .read(createWalletProvider.notifier)
                                            .createWallet(
                                                banks.code.toString());
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
                                              width: 0.5,
                                              color: Colors.black26)),
                                      child: Center(
                                          child: Text(
                                        banks.name.toString(),
                                        style: AppText.body2(
                                            context, Colors.black, 18),
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
                        })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
