import 'package:flutter/material.dart';
import 'package:kayndrexsphere_mobile/presentation/components/loading_util/loading_view.dart';

class ScreenView {
  static void showLoadingView(BuildContext context) {
    Navigator.of(context).push(LoadingView());
  }

  static void hideLoadingView(BuildContext context) {
    Navigator.pop(context);
  }

  // static void showToast({required String message}) {
  //   Fluttertoast.showToast(
  //       msg: message,
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: Colors.black87,
  //       textColor: AppColors.white,
  //       fontSize: 16.0);
  // }

  // static void showSuccessDialog(
  //   BuildContext context,
  //   String message, {
  //   VoidCallback? buttonClicked,
  //   Widget? bottomContent,
  // }) {
  //   Navigator.of(context).push(
  //     MzSuccessDialog(message, buttonClicked: buttonClicked),
  //   );
  // }

  // static void showInputDialog(
  //   BuildContext context,
  //   String message, {
  //   String textLabel = "Enter your Amulet",
  //   String buttonText = "Be god",
  //   VoidCallback? buttonClicked,
  //   required TextEditingController controller,
  // }) {
  //   HapticFeedback.mediumImpact();
  //   Navigator.of(context).push(MzInputDialog(message,
  //       buttonText: buttonText,
  //       buttonClicked: buttonClicked,
  //       textController: controller,
  //       textLabel: textLabel));
  // }

  // static void showErrorDialog(
  //   BuildContext context,
  //   String message, {
  //   String buttonText = "Try again",
  //   VoidCallback? buttonClicked,
  // }) {
  //   HapticFeedback.mediumImpact();
  //   Navigator.of(context).push(MzErrorDialog(message,
  //       buttonClicked: buttonClicked, buttonText: buttonText));
  // }

  // static void showDialog(BuildContext context, Route dialog) {
  //   HapticFeedback.mediumImpact();
  //   Navigator.of(context).push(dialog);
  // }

  // static void showRegistrationSuccessBottomSheet(
  //     {required BuildContext context, required VoidCallback onButtonClicked}) {
  //   _showRegistrationSuccess(
  //       context: context, onButtonClicked: onButtonClicked);
  // }

  // static _showRegistrationSuccess(
  //     {required BuildContext context, required VoidCallback onButtonClicked}) {
  //   showModalBottomSheet(
  //       backgroundColor: AppColors.primaryColor,
  //       shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(25), topRight: Radius.circular(25)),
  //       ),
  //       context: context,
  //       isDismissible: false,
  //       isScrollControlled: false,
  //       enableDrag: false,
  //       builder: (context) {
  //         return SizedBox(
  //           height: MediaQuery.of(context).size.height * 0.80,
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.end,
  //             children: [
  //               Stack(
  //                 children: [
  //                   Container(
  //                     padding: const EdgeInsets.only(bottom: 50),
  //                     child: Image.asset(
  //                       AppAssets.completeMask,
  //                       width: MediaQuery.of(context).size.width,
  //                       height: MediaQuery.of(context).size.height * 0.20,
  //                       fit: BoxFit.cover,
  //                     ),
  //                   ),
  //                   Positioned(
  //                     bottom: 0,
  //                     left: 0,
  //                     right: 0,
  //                     child: Center(
  //                       child: Image.asset(
  //                         AppAssets.signUpSuccessImage,
  //                         height: 150,
  //                         alignment: Alignment.bottomLeft,
  //                       ),
  //                     ),
  //                   )
  //                 ],
  //               ),
  //               Padding(
  //                 padding: EdgeInsets.symmetric(
  //                     vertical: 30,
  //                     horizontal: MediaQuery.of(context).size.width * 0.20),
  //                 child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Center(
  //                         child: Text("Congrats",
  //                             style: Theme.of(context)
  //                                 .textTheme
  //                                 .headline4
  //                                 ?.copyWith(
  //                                     color: AppColors.white,
  //                                     fontFamily: MzInterFont.bold)),
  //                       ),
  //                       const SizedBox(
  //                         height: 10,
  //                       ),
  //                       Center(
  //                         child: Text(
  //                           "Your account is ready, tap the button below to explore the experience tailored for you as an agent",
  //                           style: Theme.of(context)
  //                               .textTheme
  //                               .bodyText2
  //                               ?.copyWith(
  //                                   color: AppColors.white,
  //                                   height: 1.5,
  //                                   fontFamily: MzInterFont.regular),
  //                           textAlign: TextAlign.center,
  //                         ),
  //                       ),
  //                     ]),
  //               ),
  //               const SizedBox(
  //                 height: 10,
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   MzButton(onButtonClicked,
  //                       type: ButtonType.white,
  //                       text: "Let's go",
  //                       rightWidget: Image.asset(
  //                         AppAssets.path,
  //                         color: AppColors.primaryColor,
  //                         scale: 3,
  //                       )),
  //                 ],
  //               )
  //             ],
  //           ),
  //         );
  //       });
  // }
}
