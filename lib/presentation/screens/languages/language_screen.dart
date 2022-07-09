import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/l10n/l10n.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/languages/language_state.dart';

class LanguageScreen extends StatefulHookConsumerWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends ConsumerState<LanguageScreen> {
  List<Locale> appCountry = [];

  @override
  void initState() {
    final country = L10n.all.toList();
    appCountry = country;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100,
            child: ListView.builder(
                itemCount: appCountry.length,
                itemBuilder: (context, index) {
                  final country = appCountry[index];
                  return InkWell(
                      onTap: () {
                        ref.read(localeProvider.notifier).setLang(country);
                        Navigator.pop(context);
                      },
                      child: Text(country.languageCode));
                }),
          )
        ],
      ),
    );
  }
}
