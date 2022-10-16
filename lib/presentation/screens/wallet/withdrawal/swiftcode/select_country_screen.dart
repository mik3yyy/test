import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/country_res.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/widget/appbar_title.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/vm/get_country_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/swiftcode/search_box.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class SelectCountryScreen extends StatefulHookConsumerWidget {
  final TextEditingController countryName;
  final TextEditingController countryCode;
  const SelectCountryScreen(
      {Key? key, required this.countryName, required this.countryCode})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectCountryScreenState();
}

class _SelectCountryScreenState extends ConsumerState<SelectCountryScreen> {
  List<Country> countries = [];
  List<Country> filterableCountry = [];

  Future<List<Country>> filterClients(
      {required List<Country> countrys, required String text}) {
    if (text.isEmpty) {
      countrys = countries;
      return Future.value(countrys);
    }
    List<Country> result = countrys
        .where((country) =>
            country.name!.toLowerCase().contains(text.toLowerCase()))
        .toList();
    return Future.value(result);
  }

  void _filterClients(String text) async {
    filterableCountry = await filterClients(countrys: countries, text: text);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final country = ref.watch(getCountryProvider);
    final listState = useState("");
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        title: const AppBarTitle(title: "Select Country", color: Colors.black),
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
                hintText: "Search Country",
                onTextEntered: (value) {
                  _filterClients(value);
                  listState.value = value;
                },
              ),
              const Space(30),
              listState.value.isNotEmpty
                  ? Expanded(
                      child: ListView.separated(
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          itemCount: filterableCountry.length,
                          itemBuilder: (context, index) {
                            final country = filterableCountry[index];
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  widget.countryName.text =
                                      country.name.toString();
                                  widget.countryCode.text =
                                      country.iso2.toString();
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
                                  country.name.toString(),
                                  style: AppText.body2(
                                      context, AppColors.appColor, 18),
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
                          countries = data!.data.countries;

                          // filterableClient = countries;
                          // print(filterableClient.length);
                        });

                        return Expanded(
                          child: ListView.separated(
                              itemCount: countries.length,
                              itemBuilder: (context, index) {
                                final country = countries[index];
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      widget.countryName.text =
                                          country.name.toString();
                                      widget.countryCode.text =
                                          country.iso2.toString();
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
                                      country.name.toString(),
                                      style: AppText.body2(
                                          context, AppColors.appColor, 18),
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
