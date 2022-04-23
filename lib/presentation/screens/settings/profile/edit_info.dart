import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/edit_form.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/validator.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../components/app text theme/app_text_theme.dart';

class EditInfo extends StatefulHookConsumerWidget {
  const EditInfo({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditInfoState();
}

class _EditInfoState extends ConsumerState<EditInfo> {
  final List<String> _gender = ['Male', 'Female'];

  String val = 'Male';
  @override
  Widget build(BuildContext context) {
    final fistNameController = useTextEditingController();
    return Scaffold(
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
              onTap: () {},
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
                      // textAlign: TextAlign.start,
                      controller: fistNameController,

                      obscureText: false,
                      validator: (value) => validateFirstName(value),
                    ),
                    Space(20.h),
                    EditForm(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      labelText: 'Last Name',
                      keyboardType: TextInputType.name,
                      // textAlign: TextAlign.start,
                      controller: fistNameController,

                      obscureText: false,
                      validator: (value) => validateLastName(value),
                    ),
                    Row(
                      children: [
                        Text(
                          'Gender',
                          style: AppText.body2(context, Colors.black38, 19.sp),
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
                                        value: val,
                                        groupValue: sex,
                                        onChanged: (value) {
                                          setState(() {
                                            val = value!;
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
                      // textAlign: TextAlign.start,
                      controller: fistNameController,

                      obscureText: false,
                      validator: (value) => validateEmail(value),
                    ),
                    Space(20.h),
                    EditForm(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        labelText: 'Phone Number',
                        keyboardType: TextInputType.number,
                        // textAlign: TextAlign.start,
                        controller: fistNameController,
                        obscureText: false,
                        validator: (value) => validatePhoneNumber(value)),
                    Space(20.h),
                    DateTimePicker(
                      dateMask: 'd-MMM-yyyy',
                      // initialValue: '',
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      // maxLines: 2,
                      controller: fistNameController,

                      decoration: InputDecoration(
                        // isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 0.h),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF86828D)),
                        ),
                        labelText: 'Due Date',
                        labelStyle:
                            AppText.body2(context, Colors.black38, 20.sp),
                      ),

                      onChanged: (val) => {print(val)},
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Select due date';
                        }
                        return null;
                      },
                      onSaved: (val) => print(val),
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
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: EditForm(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          labelText: 'Country',
                          keyboardType: TextInputType.number,
                          // textAlign: TextAlign.start,
                          controller: fistNameController,
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
              ),
              Space(20.h),
              Padding(
                padding: EdgeInsets.only(right: 20.w, left: 20.w),
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: EditForm(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          labelText: 'State',
                          keyboardType: TextInputType.number,
                          // textAlign: TextAlign.start,
                          controller: fistNameController,
                          obscureText: false,
                          validator: (value) => validateState(value)),
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
              ),
              Space(20.h),
              Padding(
                padding: EdgeInsets.only(right: 20.w, left: 20.w),
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: EditForm(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        labelText: 'City',
                        keyboardType: TextInputType.number,
                        // textAlign: TextAlign.start,
                        controller: fistNameController,

                        obscureText: false,
                        validator: (value) => validateCity(value),
                      ),
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
              ),
              Space(20.h),
              Padding(
                padding: EdgeInsets.only(right: 20.w, left: 20.w),
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: EditForm(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          labelText: 'Address',
                          keyboardType: TextInputType.number,
                          // textAlign: TextAlign.start,
                          controller: fistNameController,
                          obscureText: false,
                          validator: (value) => validateAddress(value)),
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
              ),
              Space(150.h),
            ],
          ),
        ),
      ),
    );
  }
}
