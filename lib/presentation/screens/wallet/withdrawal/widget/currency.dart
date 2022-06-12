import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/edit_form.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/validator.dart';

import '../../../../components/app text theme/app_text_theme.dart';

class CurrencyWidget extends StatefulWidget {
  const CurrencyWidget(
      {Key? key, required this.currencyController, required this.text})
      : super(key: key);

  final TextEditingController currencyController;
  final String text;

  @override
  State<CurrencyWidget> createState() => _CurrencyWidgetState();
}

class _CurrencyWidgetState extends State<CurrencyWidget> {
  String dollar = "DOLLAR";
  String pound = "POUND";
  String euro = "EURO";
  String naira = "NAIRA";
  String kayndrex = "KAYNDREX";
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            showCupertinoModalPopup(
                context: context,
                builder: (context) {
                  return Padding(
                    padding: EdgeInsets.only(left: 25.w, right: 25.w),
                    child: CupertinoActionSheet(
                      actions: <Widget>[
                        Container(
                          color: Colors.white,
                          child: CupertinoActionSheetAction(
                            child: Padding(
                              padding: EdgeInsets.only(left: 30.w, right: 30.w),
                              child: Row(
                                children: [
                                  Text(
                                    dollar,
                                    style: AppText.body2(
                                        context, Colors.black, 20.sp),
                                  ),
                                  const Spacer(),
                                  Container(
                                    height: 25.h,
                                    width: 25.w,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 1, color: Colors.black)),
                                    child: Center(
                                      child: Text(
                                        '\$',
                                        style: AppText.body2(
                                            context, Colors.black, 15.sp),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            isDefaultAction: true,
                            onPressed: () {
                              widget.currencyController.text = dollar;
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          child: CupertinoActionSheetAction(
                            child: Padding(
                              padding: EdgeInsets.only(left: 30.w, right: 30.w),
                              child: Row(
                                children: [
                                  Text(
                                    pound,
                                    style: AppText.body2(
                                        context, Colors.black, 20.sp),
                                  ),
                                  const Spacer(),
                                  Container(
                                    height: 25.h,
                                    width: 25.w,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 1, color: Colors.black)),
                                    child: Center(
                                      child: Text(
                                        '\$',
                                        style: AppText.body2(
                                            context, Colors.black, 15.sp),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            isDestructiveAction: true,
                            onPressed: () {
                              widget.currencyController.text = pound;
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          child: CupertinoActionSheetAction(
                            child: Padding(
                              padding: EdgeInsets.only(left: 30.w, right: 30.w),
                              child: Row(
                                children: [
                                  Text(
                                    euro,
                                    style: AppText.body2(
                                        context, Colors.black, 20.sp),
                                  ),
                                  const Spacer(),
                                  Container(
                                    height: 25.h,
                                    width: 25.w,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 1, color: Colors.black)),
                                    child: Center(
                                      child: Text(
                                        '\$',
                                        style: AppText.body2(
                                            context, Colors.black, 15.sp),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            isDestructiveAction: true,
                            onPressed: () {
                              widget.currencyController.text = euro;
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          child: CupertinoActionSheetAction(
                            child: Padding(
                              padding: EdgeInsets.only(left: 30.w, right: 30.w),
                              child: Row(
                                children: [
                                  Text(
                                    naira,
                                    style: AppText.body2(
                                        context, Colors.black, 20.sp),
                                  ),
                                  const Spacer(),
                                  Container(
                                    height: 25.h,
                                    width: 25.w,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 1, color: Colors.black)),
                                    child: Center(
                                      child: Text(
                                        '\$',
                                        style: AppText.body2(
                                            context, Colors.black, 15.sp),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            isDestructiveAction: true,
                            onPressed: () {
                              widget.currencyController.text = naira;
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          child: CupertinoActionSheetAction(
                            child: Padding(
                              padding: EdgeInsets.only(left: 30.w, right: 30.w),
                              child: Row(
                                children: [
                                  Text(
                                    kayndrex,
                                    style: AppText.body2(
                                        context, Colors.black, 20.sp),
                                  ),
                                  const Spacer(),
                                  Container(
                                    height: 25.h,
                                    width: 25.w,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 1, color: Colors.black)),
                                    child: Center(
                                      child: Text(
                                        '\$',
                                        style: AppText.body2(
                                            context, Colors.black, 15.sp),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            isDestructiveAction: true,
                            onPressed: () {
                              widget.currencyController.text = kayndrex;
                              Navigator.pop(context);
                            },
                          ),
                        )
                      ],
                      cancelButton: CupertinoActionSheetAction(
                        child: const Text("Close"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  );
                });
          },
          child: EditForm(
              enabled: false,
              labelText: widget.text,

              // textAlign: TextAlign.start,
              controller: widget.currencyController,
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
    );
  }
}
