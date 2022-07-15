import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'package:kayndrexsphere_mobile/Data/model/profile/req/update_profile_req.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/get_profile_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/update_profile_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/edit_form.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/validator.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/date_time.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../../Data/controller/controller/generic_state_notifier.dart';
import '../../../components/AppSnackBar/snackbar/app_snackbar_view.dart';
import '../../../components/app text theme/app_text_theme.dart';

class EditInfo extends StatefulHookConsumerWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String country;
  final String phoneNo;
  final String gender;
  final String dob;

  const EditInfo({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.country,
    required this.phoneNo,
    required this.dob,
    required this.gender,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditInfoState();
}

class _EditInfoState extends ConsumerState<EditInfo> {
  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');

    number = number;
  }

  String _handlePhoneNumber() {
    if (widget.phoneNo.substring(0, 4).length == 4) {
      return widget.phoneNo.substring(4);
    } else {
      return widget.phoneNo.substring(3);
    }
  }

  PhoneNumber number = PhoneNumber(isoCode: 'NG');
  final formKey = GlobalKey<FormState>();
  final fieldFocusNode = FocusNode();
  final List<String> _gender = ['male', 'female'];
  String? _radioSelected;
  String code = "+234";
  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(updateProfileProvider);
    final fistNameController = useTextEditingController(text: widget.firstName);
    final lastNameCountroller = useTextEditingController(text: widget.lastName);
    final emailCountroller = useTextEditingController(text: widget.email);
    final phoneNoCountroller =
        useTextEditingController(text: _handlePhoneNumber());
    var dobCountroller = useTextEditingController(text: widget.dob);
    final countryCountroller = useTextEditingController(text: widget.country);
    final stateCountroller = useTextEditingController();
    final cityCountroller = useTextEditingController();
    final addressCountroller = useTextEditingController();
    final genderCountroller = useTextEditingController(text: widget.gender);
    String code = _handlePhoneNumber();

    ref.listen<RequestState>(updateProfileProvider, (T, value) {
      if (value is Success) {
        Navigator.pop(context);
        ref.refresh(getProfileProvider);

        return AppSnackBar.showSuccessSnackBar(context,
            message: 'Profile Update Successful');
      }
      if (value is Error) {
        context.loaderOverlay.hide();
        return AppSnackBar.showErrorSnackBar(context,
            message: value.error.toString());
      }
    });
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: const Center(
        child: SpinKitWave(
          color: AppColors.appColor,
          size: 50.0,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Edit Account',
            style: AppText.header2(context, Colors.black, 20.sp),
          ),
          leading: InkWell(
            onTap: (() => Navigator.pop(context)),
            child: const Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.black,
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(top: 20.h, right: 20.w),
              child: InkWell(
                onTap: vm is Loading
                    ? null
                    : () async {
                        if (formKey.currentState!.validate()) {
                          // fieldFocusNode.unfocus();
                          var updateProfile = UpdateProfileReq(
                            firstName: fistNameController.text,
                            lastName: lastNameCountroller.text,
                            email: emailCountroller.text,
                            address: addressCountroller.text,
                            gender: genderCountroller.text,
                            phoneNumber: code + phoneNoCountroller.text,
                            dateOfBirth: dobCountroller.text,
                            city: cityCountroller.text,
                            country: countryCountroller.text,
                            state: stateCountroller.text,
                          );
                          ref
                              .read(updateProfileProvider.notifier)
                              .updateProfile(updateProfile);
                          context.loaderOverlay.show();
                        }
                      },
                child: Text(
                  'Save',
                  style: AppText.body2(context, Colors.greenAccent, 20.sp),
                ),
              ),
            ),
          ],
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        body: SafeArea(
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              child: Column(
                children: [
                  Container(
                    height: 40.h,
                    width: MediaQuery.of(context).size.width,
                    color: AppColors.appColor.withOpacity(0.1),
                    child: Padding(
                      padding: EdgeInsets.only(right: 210.w),
                      child: Center(
                        child: Text(
                          'Personal Information',
                          style: AppText.body2(context, Colors.black54, 20.sp),
                        ),
                      ),
                    ),
                  ),

                  ///
                  ///
                  /// personal Information
                  ///
                  ///
                  ///
                  Padding(
                    padding: EdgeInsets.only(right: 20.w, left: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        EditForm(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          labelText: 'First Name',
                          keyboardType: TextInputType.name,
                          controller: fistNameController,
                          obscureText: false,
                          validator: (value) => validateFirstName(value),
                        ),
                        Space(20.h),
                        EditForm(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          labelText: 'Last Name',
                          keyboardType: TextInputType.name,
                          controller: lastNameCountroller,
                          obscureText: false,
                          validator: (value) => validateLastName(value),
                        ),
                        Row(
                          children: [
                            Text(
                              'Gender',
                              style:
                                  AppText.body2(context, Colors.black38, 19.sp),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 60.h,
                                width: 50,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _gender.length,
                                    itemBuilder: (context, index) {
                                      final sex = _gender[index];

                                      return Row(
                                        children: [
                                          Space(15.w),
                                          Radio<String>(
                                            value: sex,
                                            groupValue: genderCountroller.text,
                                            onChanged: (value) {
                                              setState(() {
                                                _radioSelected =
                                                    value as String;
                                                genderCountroller.text =
                                                    _radioSelected!;

                                                // val = value!;
                                              });
                                            },
                                          ),
                                          Text(
                                            sex,
                                            style: AppText.body2(
                                                context, Colors.black, 19.sp),
                                          ),
                                        ],
                                      );
                                    }),
                              ),
                            ),
                          ],
                        ),
                        Space(20.h),
                        EditForm(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          labelText: 'Email Address',
                          keyboardType: TextInputType.emailAddress,
                          controller: emailCountroller,
                          obscureText: false,
                          validator: (value) => validateEmail(value),
                        ),
                        Space(20.h),
                        InternationalPhoneNumberInput(
                          onInputChanged: (PhoneNumber number) {
                            code = number.dialCode!;
                          },
                          onInputValidated: (bool value) {},
                          selectorConfig: const SelectorConfig(
                            selectorType: PhoneInputSelectorType.DROPDOWN,
                            leadingPadding: 0,
                            trailingSpace: false,
                            setSelectorButtonAsPrefixIcon: false,
                          ),
                          spaceBetweenSelectorAndTextField: 0,
                          ignoreBlank: false,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          selectorTextStyle:
                              const TextStyle(color: Colors.black),
                          initialValue: number,
                          textFieldController: phoneNoCountroller,
                          formatInput: false,
                          inputDecoration: const InputDecoration(
                            hintText: "Phone number",
                          ),
                          focusNode: fieldFocusNode,
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          inputBorder: InputBorder.none,
                          onSaved: (PhoneNumber number) {},
                        ),
                        // EditForm(
                        //     autovalidateMode:
                        //         AutovalidateMode.onUserInteraction,
                        //     labelText: 'Phone Number',
                        //     keyboardType: TextInputType.number,
                        //     controller: phoneNoCountroller,
                        //     obscureText: false,
                        //     validator: (value) => validatePhoneNumber(value)),
                        Space(20.h),
                        Builder(
                          builder: (ctx) {
                            final now = DateTime.now();
                            return DateFormField(
                              hint: 'Date of Birth',
                              context: context,
                              defaultPickerDate: DateTime(now.year - 16),
                              maxDateTime: DateTime(now.year - 16),
                              onChanged: (date) {
                                dobCountroller.text =
                                    (DateFormat('MM-dd-yyyy').format(date))
                                        .split(" ")
                                        .first;
                              },
                              validator: (date) {
                                // if (date == null) return 'Date is required';
                                return null;
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  ///
                  ///
                  /// Address and Contact Information
                  ///
                  ///
                  ///
                  Space(35.h),
                  Container(
                    height: 40.h,
                    width: MediaQuery.of(context).size.width,
                    color: AppColors.appColor.withOpacity(0.1),
                    child: Padding(
                      padding: EdgeInsets.only(right: 100.w),
                      child: Center(
                        child: Text(
                          'Address and Contact Information',
                          style: AppText.body2(context, Colors.black54, 20.sp),
                        ),
                      ),
                    ),
                  ),
                  Space(20.h),
                  Padding(
                    padding: EdgeInsets.only(right: 20.w, left: 20.w),
                    child: InkWell(
                      onTap: () {},
                      child: EditForm(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          labelText: 'Country',
                          keyboardType: TextInputType.text,
                          controller: countryCountroller,
                          obscureText: false,
                          validator: (value) => validateCountry(value)),
                    ),
                  ),
                  Space(20.h),
                  Padding(
                    padding: EdgeInsets.only(right: 20.w, left: 20.w),
                    child: EditForm(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        labelText: 'State',
                        keyboardType: TextInputType.text,
                        controller: stateCountroller,
                        obscureText: false,
                        validator: (value) => validateState(value)),
                  ),
                  Space(20.h),
                  Padding(
                    padding: EdgeInsets.only(right: 20.w, left: 20.w),
                    child: EditForm(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      labelText: 'City',
                      keyboardType: TextInputType.text,
                      controller: cityCountroller,
                      obscureText: false,
                      validator: (value) => validateCity(value),
                    ),
                  ),
                  Space(20.h),
                  Padding(
                    padding: EdgeInsets.only(right: 20.w, left: 20.w),
                    child: EditForm(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        labelText: 'Address',
                        keyboardType: TextInputType.text,
                        // textAlign: TextAlign.start,
                        controller: addressCountroller,
                        obscureText: false,
                        validator: (value) => validateAddress(value)),
                  ),
                  Space(150.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
