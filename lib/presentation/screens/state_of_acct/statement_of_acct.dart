import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/widget/appbar_title.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent_tab_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/state_of_acct/e_wallet_acct_history.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../components/app text theme/app_text_theme.dart';

class StatementOfAcctScreen extends StatefulWidget {
  const StatementOfAcctScreen({Key? key}) : super(key: key);

  @override
  State<StatementOfAcctScreen> createState() => _StatementOfAcctScreenState();
}

class _StatementOfAcctScreenState extends State<StatementOfAcctScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        title: const AppBarTitle(title: "Statements", color: Colors.black),
        leading: const BackButton(color: Colors.black),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
          children: [
            const Space(20),
            AccountHistoryButton(
              text: "E-Wallet Account History",
              onPressed: () {
                pushNewScreen(context,
                    screen: const EWalletAccountHistory(),
                    pageTransitionAnimation: PageTransitionAnimation.cupertino);
              },
            ),
            const Space(40),
            // AccountHistoryButton(
            //   text: "E-Banking Account History",
            //   onPressed: () {},
            // ),
          ],
        ),
      ),
    );
  }
}

class AccountHistoryButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const AccountHistoryButton(
      {Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: TextButton(
        child: Text(text, style: AppText.body2(context, Colors.black54, 20.sp)),
        style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: Colors.grey.shade100,
          onSurface: Colors.grey.shade100,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
