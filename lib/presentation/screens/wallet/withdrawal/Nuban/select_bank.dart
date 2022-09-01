import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/model/bank/bank_res.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/Nuban/nuban_view_model.dart/bank_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/swiftcode/search_box.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class SelectBankScreen extends StatefulHookConsumerWidget {
  final TextEditingController bankName;
  final TextEditingController bankCode;
  const SelectBankScreen(
      {Key? key, required this.bankName, required this.bankCode})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectBankScreenState();
}

class _SelectBankScreenState extends ConsumerState<SelectBankScreen> {
  List<Datum> bank = [];
  List<Datum> filterableBank = [];

  Future<List<Datum>> filterClients(
      {required List<Datum> banks, required String text}) {
    if (text.isEmpty) {
      banks = bank;
      return Future.value(banks);
    }
    List<Datum> result = banks
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
    final country = ref.watch(getBankProvider);
    final listState = useState("");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Select Bank',
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
                hintText: "Search Bank",
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
                                setState(() {
                                  widget.bankName.text = bank.name.toString();
                                  widget.bankCode.text = bank.code.toString();
                                });
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.5, color: Colors.black26)),
                                child: Center(
                                    child: Text(
                                  bank.name.toString(),
                                  style:
                                      AppText.body2(context, Colors.black, 18),
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
                  : country.when(
                      error: (e, s) => Text(e.toString()),
                      idle: () => const CircularProgressIndicator.adaptive(
                            strokeWidth: 6,
                          ),
                      loading: () => const CircularProgressIndicator.adaptive(
                            strokeWidth: 6,
                          ),
                      success: (data) {
                        setState(() {
                          bank = data!.data!;
                        });

                        return Expanded(
                          child: ListView.separated(
                              itemCount: bank.length,
                              itemBuilder: (context, index) {
                                final banks = bank[index];
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      widget.bankName.text =
                                          banks.name.toString();
                                      widget.bankCode.text =
                                          banks.code.toString();
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 0.5, color: Colors.black26)),
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
    );
  }
}
