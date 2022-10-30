import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/widget/appbar_title.dart';
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
  @override
  Widget build(BuildContext context) {
    // THIS IS USED TO CHECK FOR THE LOADING AND ERROR STATE FROM THE SERVER
    final remoteBankList = ref.watch(bankListSearchProvider);
    // THIS RETURNS A SUCCESSFUL VALUE
    final bank = ref.watch(bankInputProvider);
    // final listState = useState("");
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        title: const AppBarTitle(title: "Select Bank", color: Colors.black),
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
              const Space(20),
              SearchBox(
                hintText: "Search Bank",
                onTextEntered: (value) {
                  ref.read(bankSearchQueryStateProvider.notifier).state = value;
                  // _filterClients(value);
                  // listState.value = value;
                },
              ),
              const Space(30),
              remoteBankList.when(
                  data: (_) {
                    //CHECK IF THE BANK PROVIDER IS NULL
                    if (bank.value == null) {
                      return const CircularProgressIndicator();
                    } else {
                      return Expanded(
                        child: ListView.separated(
                            itemCount: bank.value!.length,
                            itemBuilder: (context, index) {
                              final banks = bank.value![index];
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
                                        context, Colors.black, 16),
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
                  },
                  loading: () => const CircularProgressIndicator(),
                  error: (e, s) {
                    return Center(
                      child: TextButton.icon(
                          label: const Text('Retry'),
                          icon: const Icon(Icons.replay),
                          onPressed: () {
                            ref.refresh(bankListSearchProvider);
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
