import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/route/navigator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/get_profile_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/shared/web_view_route_name.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/get_account_details_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/wallet_transactions.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/dialog/dialog.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CardWebView extends StatefulHookConsumerWidget {
  final String url;
  final String successMsg;
  final WebViewRoute webViewRoute;

  const CardWebView(
      {Key? key,
      required this.url,
      required this.successMsg,
      required this.webViewRoute})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CardWebViewState();
}

class _CardWebViewState extends ConsumerState<CardWebView> {
  @override
  void initState() {
    // if (Platform.isAndroid) WebView.platform = AndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back_ios),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        debuggingEnabled: true,
        userAgent: 'Flutter;Webview',
        navigationDelegate: (navigation) {
          switch (widget.webViewRoute) {
            case WebViewRoute.fundCard:
              if (navigation.url.contains('payment-success')) {
                // final index = navigation.url.toString().lastIndexOf('=');
                // final reference =
                //     navigation.url.toString().substring(index + 1);

                ref.refresh(getAccountDetailsProvider);
                ref.refresh(userProfileProvider);
                ref.refresh(walletTransactionProvider);
                Navigator.pop(context);
                AppDialog.showSuccessMessageDialog(
                  context,
                  widget.successMsg,
                  onpressed: () {
                    navigator.key.currentContext?.popView();
                  },
                );
              }
              break;
            case WebViewRoute.addCard:
              if (navigation.url.contains('embed_token')) {
                // final index = navigation.url.toString().lastIndexOf('=');
                // final reference =
                //     navigation.url.toString().substring(index + 1);
                // ref.read(getCardProvider.notifier).getCard();

                Navigator.pop(context);
                ref.refresh(walletTransactionProvider);
                AppDialog.showSuccessMessageDialog(
                  context,
                  widget.successMsg,
                  onpressed: () => Navigator.pop(context),
                );

                //Veriy Payment Endpoint Function
                // ref
                //     .read(verifySubscriptionPaymentProvider.notifier)
                //     .verifySubscriptionPayment(reference);
                // verifyTransaction(reference);

              }
              break;
            case WebViewRoute.authorization:
              if (navigation.url.contains('embed_token')) {
                // final index = navigation.url.toString().lastIndexOf('=');
                // final reference =
                //     navigation.url.toString().substring(index + 1);
                // ref.read(getCardProvider.notifier).getCard();
                ref.refresh(walletTransactionProvider);
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);

                AppDialog.showSuccessMessageDialog(
                  context,
                  widget.successMsg,
                  onpressed: () => Navigator.pop(context),
                );

                //Veriy Payment Endpoint Function
                // ref
                //     .read(verifySubscriptionPaymentProvider.notifier)
                //     .verifySubscriptionPayment(reference);
                // verifyTransaction(reference);

              }

              break;
          }

          // if (navigation.url.contains('embed_token')) {
          //   final index = navigation.url.toString().lastIndexOf('=');
          //   final reference = navigation.url.toString().substring(index + 1);
          //   // ref.read(getCardProvider.notifier).getCard();

          //   Navigator.pop(context);
          //   ref.refresh(walletTransactionProvider);
          //   AppDialog.showSuccessMessageDialog(context, widget.successMsg);

          //   //Veriy Payment Endpoint Function
          //   // ref
          //   //     .read(verifySubscriptionPaymentProvider.notifier)
          //   //     .verifySubscriptionPayment(reference);
          //   // verifyTransaction(reference);

          // }

          return NavigationDecision.navigate;
        },
      ),
    );
  }
}
