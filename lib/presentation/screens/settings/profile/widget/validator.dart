String? validateEmail(String? value) {
  const String pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  final RegExp regex = RegExp(pattern);
  if (value == null || !regex.hasMatch(value)) {
    return 'Not a valid email.';
  } else {
    return null;
  }
}

String? validatePassword(String? value) {
  if (value!.length < 8) {
    return 'Password must at least be 8 characters';
  }
  if (value.isEmpty) {
    return 'Invalid password';
  }
  return null;
}

String? validateNubanAccountNumber(String? value) {
  if (value!.length < 10) {
    return 'Account Number must be 10 characters';
  }
  if (value.isEmpty) {
    return 'Invalid Accoount Number';
  }
  return null;
}

String? validatePhoneNumber(String? value) {
  if (value!.isEmpty) {
    return 'Please add a phone number';
  }
  return null;
}

String? validatePurpose(String? value) {
  if (value!.isEmpty) {
    return 'Please add reason for withdrawal';
  }
  return null;
}

// swift code validation
String? swiftCode(String? value) {
  if ((value!.length != 8) || (value.length != 11)) {
    return 'swift code must be  either 8-11 characters';
  }
  if (value.isEmpty) {
    return 'Please add a swift code';
  }
  return null;
}

// routing number validation
String? routingNumber(String? value) {
  if (value!.length != 9) {
    return 'routing number must be 9 characters';
  }
  if (value.isEmpty) {
    return 'Please add a routing number';
  }
  return null;
}

String? validateCountry(String? value) {
  if (value!.isEmpty) {
    return 'Please include your country';
  }
  return null;
}

String? validateAmount(String? value) {
  if (value == "10") {
    return 'amount must be more than 10 ';
  }
  if (value!.isEmpty) {
    return 'please enter an amount';
  }
  return null;
}

String? validateCardName(String? value) {
  if (value!.isEmpty) {
    return 'card holder name is required';
  }
  return null;
}

String? wallet(String? value) {
  if (value!.isEmpty) {
    return 'Please select a wallet';
  }
  return null;
}

String? validateState(String? value) {
  if (value!.isEmpty) {
    return 'Please include your state';
  }
  return null;
}

String? validateAddress(String? value) {
  if (value!.isEmpty) {
    return 'Please include your address';
  }
  return null;
}

String? validateCity(String? value) {
  if (value!.isEmpty) {
    return 'Please include your city';
  }
  return null;
}

String? validateFirstName(String? value) {
  const String pattern = r"^[.!#$%&'*+<>:;,%@()(/=?^_`{|}~-]";

  if (value == null || value.isEmpty) {
    return 'First Name is required';
  }
  final RegExp regex = RegExp(pattern);
  if (regex.hasMatch(value)) {
    return 'Enter a valid name';
  }
  return null;
}

String? accountName(String? value) {
  const String pattern = r"^[.!#$%&'*+<>:;,%@()(/=?^_`{|}~-]";

  if (value == null || value.isEmpty) {
    return 'account name is required';
  }
  final RegExp regex = RegExp(pattern);
  if (regex.hasMatch(value)) {
    return 'Enter a valid name';
  }
  return null;
}

String? validateLastName(String? value) {
  const String pattern = r"^[.!#$%&'*+<>:;,%@()(/=?^_`{|}~-]";

  if (value == null || value.isEmpty) {
    return 'Last Name is required';
  }
  final RegExp regex = RegExp(pattern);
  if (regex.hasMatch(value)) {
    return 'Enter a valid name';
  }
  return null;
}

String? validatePin(String? value) {
  if (value!.length < 5 || value.isEmpty) {
    return 'Pin must be 5 characters';
  }
  if (value.isEmpty) {
    return 'Invalid password';
  }
  return null;
}

//fixed here
String? validateCurrency(String? value) {
  if (value!.isEmpty) {
    return 'Please select a currency';
  }
  return null;
}

//end here
String? validateCardNumber(String? value) {
  if (value!.isEmpty) {
    return ' Add card number';
  }
  if (value.length < 16) {
    return 'card number is incomplete';
  }
  return null;
}

String? validateCCV(String? value) {
  if (value!.isEmpty) {
    return 'Add ccv';
  }
  if (value.length > 3 || value.length < 3) {
    return 'Enter ccv';
  }
  return null;
}

String? validateExpiryDate(String? value) {
  if (value!.isEmpty) {
    return 'add expiry date';
  }

  final DateTime now = DateTime.now();
  final List<String> date = value.split(RegExp(r'/'));
  final int month = int.parse(date.first);
  final int year = int.parse('20${date.last}');
  final DateTime cardDate = DateTime(year, month);

  if (cardDate.isBefore(now) || month > 12 || month == 0) {
    // return widget.dateValidationMessage;
  }
  return null;
}
