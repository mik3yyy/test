import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/Nuban/nuban_use_beneficiary_model.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent-tab-view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/Nuban/nuban.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/shared/route_name.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/withdrawal_controller.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class BeneficiaryScreen extends StatefulHookConsumerWidget {
  final RouteName routeName;
  const BeneficiaryScreen({Key? key, required this.routeName})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BeneficiaryScreenState();
}

class _BeneficiaryScreenState extends ConsumerState<BeneficiaryScreen> {
  @override
  void initState() {
    super.initState();
    // ref.read(withdrawalController.notifier).getBeneficiaries();
  }

  @override
  Widget build(BuildContext context) {
    // final vm = ref.watch(withdrawalController);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'NUBAN',
          style: AppText.header2(context, Colors.black, 20.sp),
        ),
        leading: InkWell(
          onTap: (() => Navigator.pop(context)),
          child: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.black,
          ),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: widget.routeName == RouteName.aba
          ? const AbaBeneficiary()
          : widget.routeName == RouteName.nuban
              ? const NubanBenficiary()
              : const IbanBeneficiary(),
    );
  }

  void clear() {
    var passBeneficiary =
        PassBeneficiary(accountName: "", accountNumber: "", bankCode: "");
    ref.read(genericController.notifier).addBeneficiary(passBeneficiary);
  }
}

class NubanBenficiary extends StatefulHookConsumerWidget {
  const NubanBenficiary({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NubanBenficiaryState();
}

class _NubanBenficiaryState extends ConsumerState<NubanBenficiary> {
  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(genericController);
    return Padding(
      padding: const EdgeInsets.only(left: 23, right: 23),
      child: Column(
        children: [
          vm.loading
              ? const Center(child: CircularProgressIndicator.adaptive())
              : Expanded(
                  child: ListView.separated(
                      itemCount: vm.beneficiary.length,
                      itemBuilder: (context, index) {
                        final receipients = vm.beneficiary[index];
                        return InkWell(
                          onTap: () {
                            var passBeneficiary = PassBeneficiary(
                                accountName: receipients.accountName!,
                                accountNumber: receipients.accountNumber!,
                                bankCode: receipients.bankCode!);

                            ref
                                .read(genericController.notifier)
                                .addBeneficiary(passBeneficiary);

                            pushNewScreen(context,
                                screen: const NubanWithdraw(),
                                pageTransitionAnimation:
                                    PageTransitionAnimation.fade);
                          },
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 20),
                              height: 70,
                              color: Colors.grey.shade100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    receipients.accountName.toString(),
                                    style: AppText.body2Medium(
                                        context, Colors.black54, 20),
                                  ),
                                  const Space(5),
                                  Text(
                                    receipients.accountNumber.toString(),
                                    style: AppText.body2(
                                        context, Colors.grey.shade500, 16.sp),
                                  ),
                                ],
                              )),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      }),
                ),
          CustomButton(
              buttonText: 'Next',
              bgColor: AppColors.appColor,
              borderColor: AppColors.appColor,
              textColor: Colors.white,
              onPressed: () {
                if (vm.passBeneficiary.accountName.isNotEmpty) {
                  clear();
                  pushNewScreen(context, screen: const NubanWithdraw());
                } else {}
              },
              buttonWidth: MediaQuery.of(context).size.width),
          const Space(70)
        ],
      ),
    );
  }

  void clear() {
    var passBeneficiary =
        PassBeneficiary(accountName: "", accountNumber: "", bankCode: "");
    ref.read(genericController.notifier).addBeneficiary(passBeneficiary);
  }
}

class AbaBeneficiary extends StatefulHookConsumerWidget {
  const AbaBeneficiary({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AbaBeneficiaryState();
}

class _AbaBeneficiaryState extends ConsumerState<AbaBeneficiary> {
  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(genericController);
    return Padding(
      padding: const EdgeInsets.only(left: 23, right: 23),
      child: Column(
        children: [
          vm.loading
              ? const Center(child: CircularProgressIndicator.adaptive())
              : Expanded(
                  child: ListView.separated(
                      itemCount: vm.ababeneficiary.length,
                      itemBuilder: (context, index) {
                        final receipients = vm.ababeneficiary[index];
                        return InkWell(
                          onTap: () {
                            var passBeneficiary = PassBeneficiary(
                                accountName: receipients.accountName!,
                                accountNumber: receipients.accountNumber!,
                                bankCode: receipients.bankCode!);

                            ref
                                .read(genericController.notifier)
                                .addBeneficiary(passBeneficiary);

                            pushNewScreen(context,
                                screen: const NubanWithdraw(),
                                pageTransitionAnimation:
                                    PageTransitionAnimation.fade);
                          },
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 20),
                              height: 70,
                              color: Colors.grey.shade100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    receipients.accountName.toString(),
                                    style: AppText.body2Medium(
                                        context, Colors.black54, 20),
                                  ),
                                  const Space(5),
                                  Text(
                                    receipients.accountNumber.toString(),
                                    style: AppText.body2(
                                        context, Colors.grey.shade500, 16.sp),
                                  ),
                                ],
                              )),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      }),
                ),
          CustomButton(
              buttonText: 'Next',
              bgColor: AppColors.appColor,
              borderColor: AppColors.appColor,
              textColor: Colors.white,
              onPressed: () {
                if (vm.passBeneficiary.accountName.isNotEmpty) {
                  clear();
                  pushNewScreen(context, screen: const NubanWithdraw());
                } else {}
              },
              buttonWidth: MediaQuery.of(context).size.width),
          const Space(70)
        ],
      ),
    );
  }

  void clear() {
    var passBeneficiary =
        PassBeneficiary(accountName: "", accountNumber: "", bankCode: "");
    ref.read(genericController.notifier).addBeneficiary(passBeneficiary);
  }
}

class IbanBeneficiary extends StatefulHookConsumerWidget {
  const IbanBeneficiary({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _IbanBeneficiaryState();
}

class _IbanBeneficiaryState extends ConsumerState<IbanBeneficiary> {
  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(genericController);
    return Padding(
      padding: const EdgeInsets.only(left: 23, right: 23),
      child: Column(
        children: [
          vm.loading
              ? const Center(child: CircularProgressIndicator.adaptive())
              : Expanded(
                  child: ListView.separated(
                      itemCount: vm.ibanbeneficiary.length,
                      itemBuilder: (context, index) {
                        final receipients = vm.ibanbeneficiary[index];
                        return InkWell(
                          onTap: () {
                            var passBeneficiary = PassBeneficiary(
                                accountName: receipients.accountName!,
                                accountNumber: receipients.accountNumber!,
                                bankCode: receipients.bankCode!);

                            ref
                                .read(genericController.notifier)
                                .addBeneficiary(passBeneficiary);

                            pushNewScreen(context,
                                screen: const NubanWithdraw(),
                                pageTransitionAnimation:
                                    PageTransitionAnimation.fade);
                          },
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 20),
                              height: 70,
                              color: Colors.grey.shade100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    receipients.accountName.toString(),
                                    style: AppText.body2Medium(
                                        context, Colors.black54, 20),
                                  ),
                                  const Space(5),
                                  Text(
                                    receipients.accountNumber.toString(),
                                    style: AppText.body2(
                                        context, Colors.grey.shade500, 16.sp),
                                  ),
                                ],
                              )),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      }),
                ),
          CustomButton(
              buttonText: 'Next',
              bgColor: AppColors.appColor,
              borderColor: AppColors.appColor,
              textColor: Colors.white,
              onPressed: () {
                if (vm.passBeneficiary.accountName.isNotEmpty) {
                  clear();
                  pushNewScreen(context, screen: const NubanWithdraw());
                } else {}
              },
              buttonWidth: MediaQuery.of(context).size.width),
          const Space(70)
        ],
      ),
    );
  }

  void clear() {
    var passBeneficiary =
        PassBeneficiary(accountName: "", accountNumber: "", bankCode: "");
    ref.read(genericController.notifier).addBeneficiary(passBeneficiary);
  }
}
