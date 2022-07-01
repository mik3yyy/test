import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/AppSnackBar/snackbar/app_snackbar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent-tab-view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/edit_form.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/swiftcode/select_country_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/generic_controller.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../../components/app text theme/app_text_theme.dart';
import '../widget/validator.dart';

class AddressAuthenication extends StatefulHookConsumerWidget {
  final String depositRef;
  final String mode;
  const AddressAuthenication(
      {Key? key, required this.depositRef, required this.mode})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddressAuthenicationState();
}

class _AddressAuthenicationState extends ConsumerState<AddressAuthenication> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authorize = ref.watch(genericController);
    final address = useTextEditingController();
    final state = useTextEditingController();
    final country = useTextEditingController();
    final city = useTextEditingController();
    final countryCode = useTextEditingController();
    final zipcode = useTextEditingController();

    ref.listen<GenericState>(genericController, (prev, value) {
      if (value.success == true) {}

      if (value is Error) {
        AppSnackBar.showErrorSnackBar(context, message: value.error.toString());
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Add address',
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
      body: SingleChildScrollView(
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
                  'Authenticate address',
                  style: AppText.body2Medium(context, Colors.black54, 20.sp),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 23.w, right: 23.w, top: 30.h),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    EditForm(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      labelText: 'Enter address',
                      keyboardType: TextInputType.name,
                      // textAlign: TextAlign.start,
                      controller: address,
                      obscureText: false,
                      onChanged: (value) {},
                      validator: (value) => validateAddress(value),
                    ),
                    const Space(30),
                    EditForm(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      labelText: 'Enter state',
                      keyboardType: TextInputType.name,
                      // textAlign: TextAlign.start,
                      controller: state,
                      obscureText: false,
                      onChanged: (value) {},
                      validator: (value) => validateState(value),
                    ),
                    const Space(30),
                    Row(
                      children: [
                        SizedBox(
                          width: 160,
                          child: EditForm(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            labelText: 'Enter city',
                            keyboardType: TextInputType.name,
                            // textAlign: TextAlign.start,
                            controller: city,
                            obscureText: false,
                            onChanged: (value) {},
                            validator: (value) => validateCity(value),
                          ),
                        ),
                        const Space(40),
                        SizedBox(
                          width: 130,
                          child: EditForm(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              labelText: 'Enter Zip',
                              keyboardType: TextInputType.text,
                              // textAlign: TextAlign.start,
                              controller: zipcode,
                              obscureText: false,
                              validator: (value) {
                                return null;
                              }),
                        ),
                      ],
                    ),
                    const Space(30),
                    Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            pushNewScreen(context,
                                screen: SelectCountryScreen(
                                    countryName: country,
                                    countryCode: countryCode),
                                pageTransitionAnimation:
                                    PageTransitionAnimation.slideRight);
                            // countryBuild(context, countryController);
                          },
                          child: EditForm(
                              enabled: false,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              labelText: 'Enter country',
                              keyboardType: TextInputType.text,
                              // textAlign: TextAlign.start,
                              controller: country,
                              obscureText: false,
                              validator: (value) => validateCountry(value)),
                        ),
                        Positioned(
                          left: 375.w,
                          right: 0,
                          bottom: 17.h,
                          child: const Icon(
                            CupertinoIcons.chevron_down,
                            color: Color(0xffA8A8A8),
                            size: 15,
                          ),
                        ),
                      ],
                    ),
                    const Space(70),
                    CustomButton(
                        buttonText: authorize.loading ? 'Processing' : 'Next',
                        bgColor: AppColors.appColor,
                        borderColor: AppColors.appColor,
                        textColor: Colors.white,
                        onPressed: authorize.loading
                            ? null
                            : () {
                                if (formKey.currentState!.validate()) {
                                  ref
                                      .read(genericController.notifier)
                                      .authorize(
                                          address: address.text,
                                          city: city.text,
                                          country: country.text,
                                          depositRef: widget.depositRef,
                                          mode: widget.mode,
                                          userState: state.text,
                                          zipcode: zipcode.text,
                                          context: context);
                                }
                              },
                        buttonWidth: MediaQuery.of(context).size.width),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
