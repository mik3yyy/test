import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/widget/appbar_title.dart';
import 'package:flutter/material.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/swiftcode/search_box.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import '../../../components/app text theme/app_text_theme.dart';
import 'languages.dart';

class SelectLanguage extends StatefulWidget {
  final TextEditingController languageName;
  const SelectLanguage({Key? key, required this.languageName})
      : super(key: key);

  @override
  State<SelectLanguage> createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> {
  List<Language>? _allLanguages;
  List<Language>? _filteredLanguages;

  @override
  void initState() {
    _allLanguages = Languages.defaultLanguages;
    _filteredLanguages = _allLanguages;
    super.initState();
  }

  void _runFilter(String searchKeyword) {
    List<Language>? results;

    if (searchKeyword.isEmpty) {
      results = _allLanguages;
    } else {
      results = _allLanguages!
          .where((element) =>
              element.name.toLowerCase().contains(searchKeyword.toLowerCase()))
          .toList();
    }

    _filteredLanguages = results;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.transparent,
        title: const AppBarTitle(title: "Select Language", color: Colors.black),
        leading: const BackButton(color: Colors.black),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
        child: Column(
          children: [
            SearchBox(
              onTextEntered: _runFilter,
            ),
            const Space(30),
            _filteredLanguages == null
                ? const CircularProgressIndicator()
                : Expanded(
                    // height: 300,
                    child: ListView.separated(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    itemCount: _filteredLanguages!.length,
                    itemBuilder: (context, index) {
                      final lang = _filteredLanguages![index];
                      return InkWell(
                        onTap: () {
                          setState(() {
                            widget.languageName.text = lang.name;
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 0.2, color: Colors.black26)),
                          child: Center(
                              child: Text(
                            lang.name.toString(),
                            style: AppText.body2(
                                context, AppColors.appColor, 20.sp),
                          )),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                  ))
          ],
        ),
      ),
    );
  }
}
