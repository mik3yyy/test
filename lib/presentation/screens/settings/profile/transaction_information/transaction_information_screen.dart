import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/card/res/get_card.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/widget/appbar_title.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent_tab_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/transaction_information/add_card_form.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/transaction_information/view_model/get_card_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../../components/app text theme/app_text_theme.dart';

class TransactionInformationScreen extends StatefulHookConsumerWidget {
  const TransactionInformationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransactionInformationScreenState();
}

class _TransactionInformationScreenState
    extends ConsumerState<TransactionInformationScreen> {
  final toggleStateProvider = StateProvider<int>((ref) {
    return 0;
  });

  int? groupValue;

  List<Cardd> storedCard = [];

  @override
  Widget build(BuildContext context) {
    final getCard = ref.watch(getCardProvider);
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        title: const AppBarTitle(
            title: "Transaction Information", color: Colors.black),
        leading: const BackButton(color: Colors.black),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 40.h,
                width: MediaQuery.of(context).size.width,
                color: AppColors.appColor.withOpacity(0.1),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 7.5, horizontal: 20),
                  child: Text(
                    'Add Card',
                    style: AppText.body2Medium(context, Colors.black54, 20.sp),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 23.w, right: 23.w, top: 30.h),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        'You can add a maximum of 3 cards',
                        style:
                            AppText.body2Medium(context, Colors.black54, 20.sp),
                      ),
                    ),
                    Space(30.h),
                    InkWell(
                      onTap: getCard is Loading
                          ? null
                          : storedCard.length == 3
                              ? null
                              : () {
                                  pushNewScreen(context,
                                      screen: const AddCardForm(),
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.fade);
                                },
                      child: Container(
                        height: 70.h,
                        width: MediaQuery.of(context).size.width,
                        color: AppColors.appColor.withOpacity(0.03),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 7.5, horizontal: 20),
                          child: Row(
                            children: [
                              Text(
                                'Add Debit/Credit Card',
                                style: AppText.body2Medium(
                                    context, Colors.black54, 20.sp),
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Space(30.h),
                    getCard.when(
                        error: (error, stackTrace) {
                          return Center(
                            child: TextButton.icon(
                                onPressed: () {
                                  ref.invalidate(getCardProvider);
                                },
                                icon: const Icon(Icons.replay),
                                label: const Text("Retry")),
                          );
                        },
                        idle: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                        loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                        success: (data) {
                          return data!.data.cards.isEmpty
                              ? Text("You have no card",
                                  style: AppText.body2Medium(
                                      context, AppColors.textColor, 19.sp))
                              : RefreshIndicator(
                                  onRefresh: () async {
                                    return ref
                                        .refresh(getCardProvider.notifier)
                                        .getCard();
                                  },
                                  child: SizedBox(
                                    height: 400,
                                    child: ListView.separated(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: data.data.cards.length,
                                      itemBuilder: (context, index) {
                                        storedCard = data.data.cards;
                                        final savedCard =
                                            data.data.cards[index];
                                        String getBrand() {
                                          if (savedCard.brand == "MASTERCARD") {
                                            return AppImage.masterCard;
                                          }
                                          if (savedCard.brand == "VERVE") {
                                            return AppImage.verve;
                                          }
                                          if (savedCard.brand == "VISA") {
                                            return AppImage.visa;
                                          }
                                          if (savedCard.brand ==
                                              "AMERICAN EXPRESS") {
                                            return AppImage.americanExpress;
                                          }
                                          if (savedCard.brand == "MAESTRO") {
                                            return AppImage.maestro;
                                          } else {
                                            return "";
                                          }
                                        }

                                        return RadioListTile<int>(
                                          value: savedCard.isDefault!.toInt(),
                                          groupValue: groupValue,
                                          onChanged: (value) {
                                            setState(() {
                                              groupValue = index;
                                              // val = value;
                                              // _value = true;
                                            });
                                          },
                                          tileColor: Colors.grey.shade100,
                                          title: RichText(
                                            text: TextSpan(
                                              style: AppText.body2Medium(
                                                  context,
                                                  Colors.black54,
                                                  20.sp),
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: savedCard.first6Digits
                                                        .toString(),
                                                    style: AppText.body2Medium(
                                                        context,
                                                        Colors.black54,
                                                        20.sp)),
                                                const TextSpan(text: '****'),
                                                TextSpan(
                                                    text: savedCard.last4Digits
                                                        .toString(),
                                                    style: AppText.body2Medium(
                                                        context,
                                                        Colors.black54,
                                                        20.sp))
                                              ],
                                            ),
                                          ),
                                          subtitle: RichText(
                                            text: TextSpan(
                                              style: AppText.body2Medium(
                                                  context,
                                                  Colors.black54,
                                                  20.sp),
                                              children: [
                                                TextSpan(
                                                    text: "Expiry date  ",
                                                    style: AppText.body2Medium(
                                                        context,
                                                        Colors.black54,
                                                        15.sp)),
                                                TextSpan(
                                                    text: savedCard.expiry
                                                        .toString(),
                                                    style: AppText.body2Medium(
                                                        context,
                                                        Colors.black54,
                                                        15.sp))
                                              ],
                                            ),
                                          ),
                                          secondary: SvgPicture.asset(
                                            getBrand(),
                                            height: 20,
                                            width: 20,
                                          ),
                                          selected: false,
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return const SizedBox(
                                          height: 10,
                                        );
                                      },
                                    ),
                                  ),
                                );
                        })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
