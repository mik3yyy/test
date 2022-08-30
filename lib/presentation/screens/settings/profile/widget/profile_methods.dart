import 'package:intl/intl.dart';

String date(DateTime? dateTime) {
  final date = dateTime;
  // final date = user.dateOfBirth;

  if (date == null) {
    return "unavailable";
  } else {
    DateTime parseDate = DateFormat("yyyy-MM-dd").parse(date.toString());
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MM/dd/yyyy');
    var dob = outputFormat.format(inputDate);
    return dob;
  }
}

String userName(String? firstName, String? lastName) {
  if (firstName == null && lastName == null) {
    return "unavailable";
  } else {
    final userName = firstName.toString() + " " + lastName.toString();
    return userName;
  }
}
