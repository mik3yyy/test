import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart' as phone;
import 'package:kayndrexsphere_mobile/Data/model/profile/res/profile_res.dart';
import 'package:kayndrexsphere_mobile/presentation/components/extension/string_extension.dart';
import 'package:kayndrexsphere_mobile/presentation/components/helper/country/list_of_countries.dart';
import 'package:kayndrexsphere_mobile/presentation/components/loading_util/loading_util.dart';
import 'package:kayndrexsphere_mobile/presentation/components/widget/appbar_title.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/home.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/state_of_acct/check_date/check_date.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/req/update_profile_req.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/get_profile_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/update_profile_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/edit_form.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/validator.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../../Data/controller/controller/generic_state_notifier.dart';
import '../../../components/AppSnackBar/snackbar/app_snackbar_view.dart';
import '../../../components/app text theme/app_text_theme.dart';

class EditInfo extends StatefulHookConsumerWidget {
  final ProfileRes userValue;

  const EditInfo({
    Key? key,
    required this.userValue,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditInfoState();
}

class _EditInfoState extends ConsumerState<EditInfo> {
  String phoneCode = "";
  String isCode = "";

  seperatePhoneAndDialCode() {
    for (var country in Countries.allCountries) {
      if (country.values.contains(widget.userValue.data.user.countryName)) {
        phoneCode = country["dial_code"].toString();
        isCode = country["code"].toString();
        // print(country["dial_code"]);
      }
    }
  }

  final formKey = GlobalKey<FormState>();

  final List<String> _gender = ['male', 'female'];
  String? _radioSelected;

  @override
  void initState() {
    seperatePhoneAndDialCode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(updateProfileProvider);
    FocusScopeNode currentFocus = FocusScope.of(context);
    final phoneNo =
        useState<phone.PhoneNumber>(phone.PhoneNumber(isoCode: isCode));
    final fistNameController = useTextEditingController(
        text: widget.userValue.data.user.firstName!.capitalize());
    final lastNameCountroller = useTextEditingController(
        text: widget.userValue.data.user.lastName!.capitalize());
    final emailCountroller =
        useTextEditingController(text: widget.userValue.data.user.email);
    final phoneNoCountroller = useTextEditingController(
        text: widget.userValue.data.user.phoneNumber?.phoneNumber);
    var dobCountroller = useTextEditingController(
        text: widget.userValue.data.user.dateOfBirth?.toIso8601String() ?? "");
    final countryCountroller =
        useTextEditingController(text: widget.userValue.data.user.countryName);
    final stateCountroller =
        useTextEditingController(text: widget.userValue.data.user.state);
    final cityCountroller =
        useTextEditingController(text: widget.userValue.data.user.city);
    final addressCountroller =
        useTextEditingController(text: widget.userValue.data.user.address);
    final genderCountroller =
        useTextEditingController(text: widget.userValue.data.user.gender);

    ref.listen<RequestState>(updateProfileProvider, (_, value) {
      if (value is Loading) {
        ScreenView.showLoadingView(context);
      } else {
        ScreenView.hideLoadingView(context);
      }

      if (value is Success<bool>) {
        ref.refresh(userProfileProvider);
        Navigator.pop(context);

        return AppSnackBar.showSuccessSnackBar(context,
            message: 'Profile Update Successful');
      }
      if (value is Error) {
        return AppSnackBar.showErrorSnackBar(context,
            message: value.error.toString());
      }
    });
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        title: const AppBarTitle(title: "Edit Account", color: Colors.black),
        leading: const BackButton(color: Colors.black),
        actions: [
          vm is Loading
              ? Padding(
                  padding: EdgeInsets.only(top: 20.h, right: 20.w),
                  child: Text(
                    'Loading...',
                    style:
                        AppText.body2Bold(context, AppColors.appColor, 20.sp),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(top: 20.h, right: 20.w),
                  child: InkWell(
                    onTap: vm is Loading
                        ? null
                        : () async {
                            if (formKey.currentState!.validate()) {
                              var updateProfile = UpdateProfileReq(
                                firstName: fistNameController.text,
                                lastName: lastNameCountroller.text,
                                email: emailCountroller.text,
                                address: addressCountroller.text,
                                gender: genderCountroller.text,
                                phoneCode: phoneCode,
                                phoneNumber: phoneNoCountroller.text,
                                dateOfBirth: formatDate(dobCountroller.text),
                                city: cityCountroller.text,
                                country: countryCountroller.text,
                                state: stateCountroller.text,
                              );
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }

                              ref
                                  .read(updateProfileProvider.notifier)
                                  .updateProfile(updateProfile);
                            }
                          },
                    child: Text(
                      'Save',
                      style:
                          AppText.body2Bold(context, AppColors.appColor, 20.sp),
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
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics()),
            child: Column(
              children: [
                InnerPageLoadingIndicator(loadingStream: vm is Loading),
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
                                              _radioSelected = value as String;
                                              genderCountroller.text =
                                                  _radioSelected!;
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
                      IntlPhoneNumber(
                        initialNo: phoneNo,
                        numberChanged: (phone.PhoneNumber value) {
                          setState(() {
                            phoneCode = value.dialCode!;
                          });
                        },
                        phoneController: phoneNoCountroller,
                      ),
                      // phone.InternationalPhoneNumberInput(
                      //   validator: (p0) => null,
                      //   onInputChanged: (phone.PhoneNumber number) {
                      //     setState(() {
                      //       phoneCode = number.dialCode!;
                      //     });
                      //   },
                      //   onInputValidated: (bool value) => true,
                      //   selectorConfig: const phone.SelectorConfig(
                      //     selectorType: phone.PhoneInputSelectorType.DROPDOWN,
                      //     leadingPadding: 0,
                      //     trailingSpace: false,
                      //     setSelectorButtonAsPrefixIcon: false,
                      //   ),
                      //   spaceBetweenSelectorAndTextField: 0,
                      //   ignoreBlank: true,
                      //   autoValidateMode: AutovalidateMode.onUserInteraction,
                      //   selectorTextStyle:
                      //       const TextStyle(color: Colors.black),
                      //   initialValue: phoneNo.value,
                      //   textFieldController: phoneNoCountroller,
                      //   formatInput: false,

                      //   inputDecoration: const InputDecoration(
                      //     hintText: "Phone number",
                      //     focusedBorder: UnderlineInputBorder(
                      //       borderSide: BorderSide(color: Colors.black),
                      //     ),
                      //   ),

                      //   keyboardType: const TextInputType.numberWithOptions(
                      //       signed: true, decimal: false),
                      //   inputBorder: InputBorder.none,

                      //   // onSaved: (PhoneNumber number) {},
                      // ),
                      Space(20.h),
                      DateTimePicker(
                        enabled: dobCountroller.text.isEmpty ? true : false,
                        controller: dobCountroller,
                        type: DateTimePickerType.date,
                        dateMask: 'MM-dd-yyyy',

                        firstDate: DateTime(1900),
                        lastDate: DateTime(3100),
                        decoration: InputDecoration(
                            label: Text(
                              'Date of Birth',
                              style:
                                  AppText.body2(context, Colors.black38, 20.sp),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            suffix: dobCountroller.text.isEmpty
                                ? const SizedBox()
                                : const Icon(
                                    Icons.lock,
                                    size: 20,
                                  )),
                        // icon: Icon(Icons.event),
                        dateLabelText: 'Date of Birth',

                        onChanged: (val) => debugPrint(val),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "update your Date of Birth";
                          }

                          return null;
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
                Space(50.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IntlPhoneNumber extends StatefulHookConsumerWidget {
  final TextEditingController phoneController;
  final ValueChanged<phone.PhoneNumber> numberChanged;
  final ValueNotifier<phone.PhoneNumber> initialNo;
  const IntlPhoneNumber(
      {Key? key,
      required this.phoneController,
      required this.initialNo,
      required this.numberChanged})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _IntlPhoneNumberState();
}

class _IntlPhoneNumberState extends ConsumerState<IntlPhoneNumber> {
  @override
  Widget build(BuildContext context) {
    return phone.InternationalPhoneNumberInput(
      validator: (p0) => null,
      onInputChanged: widget.numberChanged,
      onInputValidated: (bool value) => true,
      selectorConfig: const phone.SelectorConfig(
        selectorType: phone.PhoneInputSelectorType.DROPDOWN,
        leadingPadding: 0,
        trailingSpace: false,
        setSelectorButtonAsPrefixIcon: false,
      ),
      spaceBetweenSelectorAndTextField: 0,
      ignoreBlank: true,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      selectorTextStyle: const TextStyle(color: Colors.black),
      initialValue: widget.initialNo.value,
      textFieldController: widget.phoneController,
      formatInput: false,
      inputDecoration: const InputDecoration(
        hintText: "Phone number",
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
      keyboardType:
          const TextInputType.numberWithOptions(signed: true, decimal: false),
      inputBorder: InputBorder.none,
    );
  }
}
