import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent-tab-view.dart';
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

  String groupValue = "";
  @override
  Widget build(BuildContext context) {
    final toggle = ref.watch(toggleStateProvider.state);
    final card = ref.watch(getCardProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Transaction Information',
          style: AppText.header2(context, Colors.black, 20.sp),
        ),
        leading: InkWell(
          onTap: (() => Navigator.pop(context)),
          child: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.black,
          ),
        ),
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
                    Row(
                      children: [
                        Container(
                          height: 70.h,
                          width: 20,
                          color: AppColors.appColor.withOpacity(0.2),
                        ),
                        Container(
                          height: 70.h,
                          width: 325,
                          // width: MediaQuery.of(context).size.width,
                          color: AppColors.appColor.withOpacity(0.1),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 7.5, horizontal: 20),
                            child: Center(
                              child: Text(
                                'You can add a maximum of 3 cards',
                                style: AppText.body2Medium(
                                    context, Colors.black54, 20.sp),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Space(30.h),
                    InkWell(
                      onTap: () {
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
                    card.when(
                        error: (error, stackTrace) => Text(
                              error.toString(),
                            ),
                        idle: () => const CircularProgressIndicator.adaptive(),
                        loading: () =>
                            const CircularProgressIndicator.adaptive(),
                        success: (data) {
                          return RefreshIndicator(
                            onRefresh: () async {
                              ref.refresh(getCardProvider);
                            },
                            child: SizedBox(
                              height: 400,
                              child: ListView.separated(
                                physics: const AlwaysScrollableScrollPhysics(
                                    parent: BouncingScrollPhysics()),
                                itemCount: data!.data.cards.length,
                                itemBuilder: (context, index) {
                                  final savedCard = data.data.cards[index];
                                  return Container(
                                    height: 70.h,
                                    width: MediaQuery.of(context).size.width,
                                    color: AppColors.appColor.withOpacity(0.03),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, right: 20, left: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                      style:
                                                          AppText.body2Medium(
                                                              context,
                                                              Colors.black54,
                                                              20.sp),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text: savedCard
                                                                .first6Digits
                                                                .toString(),
                                                            style: AppText
                                                                .body2Medium(
                                                                    context,
                                                                    Colors
                                                                        .black54,
                                                                    20.sp)),
                                                        const TextSpan(
                                                            text: '****'),
                                                        TextSpan(
                                                            text: savedCard
                                                                .last4Digits
                                                                .toString(),
                                                            style: AppText
                                                                .body2Medium(
                                                                    context,
                                                                    Colors
                                                                        .black54,
                                                                    20.sp))
                                                      ],
                                                    ),
                                                  ),
                                                  const Space(5),
                                                  RichText(
                                                    text: TextSpan(
                                                      style:
                                                          AppText.body2Medium(
                                                              context,
                                                              Colors.black54,
                                                              20.sp),
                                                      children: [
                                                        TextSpan(
                                                            text:
                                                                "Expiry date  ",
                                                            style: AppText
                                                                .body2Medium(
                                                                    context,
                                                                    Colors
                                                                        .black54,
                                                                    15.sp)),
                                                        TextSpan(
                                                            text: savedCard
                                                                .expiry
                                                                .toString(),
                                                            style: AppText
                                                                .body2Medium(
                                                                    context,
                                                                    Colors
                                                                        .black54,
                                                                    15.sp))
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              Text(
                                                savedCard.brand.toString(),
                                                style: AppText.body2Medium(
                                                    context,
                                                    Colors.black54,
                                                    17.sp),
                                              ),

                                              // CreditCardWidget(customCardTypeIcons: customCardTypeIcons, cardNumber: savedCard.first6Digits.toString())
                                              Radio<String>(
                                                  value: savedCard.isDefault
                                                      .toString(),
                                                  groupValue: groupValue,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      groupValue = value!;
                                                    });
                                                  })
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
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
                        }),
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
