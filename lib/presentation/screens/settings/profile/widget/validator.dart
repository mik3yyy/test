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

String? validateCountry(String? value) {
  if (value!.isEmpty) {
    return 'Please include your country';
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
