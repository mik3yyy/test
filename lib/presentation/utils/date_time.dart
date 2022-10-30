// import 'package:flutter/material.dart';
// import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';

// class DateFormField extends FormField<DateTime> {
//   DateFormField({
//     Key? key,
//     FormFieldSetter<DateTime>? onSaved,
//     FormFieldValidator<DateTime>? validator,
//     bool autovalidate = false,
//     required BuildContext context,
//     Function(DateTime date)? onChanged,
//     BoxDecoration? decoration,
//     DateTime? initialDateTime,
//     DateTime? maxDateTime,
//     DateTime? minDateTime,
//     DateTime? defaultPickerDate,
//     String hint = 'Pick a Date',
//   }) : super(
//           key: key,
//           onSaved: onSaved,
//           validator: validator,
//           autovalidateMode: AutovalidateMode.onUserInteraction,
//           initialValue: initialDateTime,
//           builder: (FormFieldState<DateTime> state) {
//             final value = state.value;
//             final themeData = Theme.of(context);

//             final fieldValue = Text(
//               value != null ? DateFormat.yMd().format(value) : '',
//               style: themeData.textTheme.subtitle1!.copyWith(
//                 color:
//                     state.value == null && state.hasError ? Colors.red : null,
//                 fontWeight: FontWeight.normal,
//               ),
//             );

//             return Focus(
//               canRequestFocus: false,
//               skipTraversal: true,
//               child: Builder(
//                 builder: (ctxx) {
//                   final InputDecoration effectiveDecoration = InputDecoration(
//                     hintText: hint,
//                     suffixIcon: const Icon(
//                       Icons.calendar_month,
//                       color: AppColors.appBgColor,
//                     ),
//                   ).applyDefaults(
//                     Theme.of(ctxx).inputDecorationTheme,
//                   );

//                   return InkWell(
//                     onTap: () {
//                       DatePicker.showDatePicker(
//                         context,
//                         maxDateTime: maxDateTime,
//                         minDateTime: minDateTime,
//                         dateFormat: 'MM/dd/yyyy',
//                         initialDateTime: initialDateTime,
//                         locale: DATETIME_PICKER_LOCALE_DEFAULT,
//                         pickerMode: DateTimePickerMode.date,
//                         onMonthChangeStartWithFirstDate: true,
//                         pickerTheme: DateTimePickerTheme.Default,
//                         onConfirm: (date, _) {
//                           state.didChange(date);
//                           final valid = state.validate();

//                           if (onChanged != null) onChanged(date);
//                           if (valid) FocusScope.of(context).nextFocus();
//                         },
//                       );
//                     },
//                     child: InputDecorator(
//                       decoration: effectiveDecoration.copyWith(
//                         errorText: state.errorText,
//                       ),
//                       isEmpty: state.value == null,
//                       isFocused: Focus.of(ctxx).hasFocus,
//                       child: fieldValue,
//                     ),
//                   );
//                 },
//               ),
//             );
//           },
//         );
// }
