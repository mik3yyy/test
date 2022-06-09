import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent-tab-view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/transaction_information/add_card_form.dart';
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
  @override
  Widget build(BuildContext context) {
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
                          width: 30,
                          color: AppColors.appColor.withOpacity(0.2),
                        ),
                        Container(
                          height: 70.h,
                          width: 320,
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
                                'Debit/Credit Card',
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
