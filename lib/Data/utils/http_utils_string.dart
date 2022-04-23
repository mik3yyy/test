class HttpErrorStrings {
  // ignore: constant_identifier_names
  static const String CONNECTION_TIMEOUT_ACTIVE =
      'Unable to make connection at the moment this may be caused by an unstable network or connection to the server, please try again later.';

  // ignore: constant_identifier_names
  static const String CONNECTION_TIMEOUT_NOT_ACTIVE =
      'Looks like you have no active connection at the moment, please try again when you have an active connection.';

  // ignore: constant_identifier_names
  static const String SEND_TIMEOUT =
      'Looks like you have an unstable network at the moment, please try again when network stabilizes.';

  // ignore: constant_identifier_names
  static const String RECEIVE_TIMEOUT =
      'Unable to connect to server at the moment';

  // ignore: constant_identifier_names
  static const String BAD_RESPONSE =
      'Unable to complete request at the moment. Please contact our customer care';

  // ignore: constant_identifier_names
  static const String OPERATION_CANCELLED = 'Operation was cancelled';

  // ignore: constant_identifier_names
  static const String DEFAULT =
      'Looks like you are not connected to any active network. Please connect and try again';

  // ignore: constant_identifier_names
  static const String UNKNOWN = 'Unknown error occurred';
  // ignore: constant_identifier_names
  static const String UnAuthorized = 'Username or Password is Incorrect';
}
