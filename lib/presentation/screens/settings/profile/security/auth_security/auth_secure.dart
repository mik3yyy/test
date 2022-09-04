import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// class CredentialState extends Equatable {
//   final String storePassWord;
//   final String storeEmail;
//   final String name;
//   final bool success;
//   const CredentialState(
//       {required this.storePassWord,
//       required this.storeEmail,
//       required this.success,
//       required this.name});

//   factory CredentialState.initial() {
//     return const CredentialState(
//         storePassWord: "", storeEmail: "", name: "", success: false);
//   }

//   CredentialState copyWith(
//       {final String? storePassWord,
//       final String? storeEmail,
//       final bool? success,
//       final String? name}) {
//     return CredentialState(
//         storePassWord: storePassWord ?? this.storePassWord,
//         name: name ?? this.name,
//         success: success ?? this.success,
//         storeEmail: storeEmail ?? this.storeEmail);
//   }

//   @override
//   List<Object?> get props => [storeEmail, storePassWord, name];
// }

final credentialProvider =
    StateNotifierProvider<CredentialsNotifier, String>((ref) {
  const storage = FlutterSecureStorage();
  return CredentialsNotifier(storage);
});

class CredentialsNotifier extends StateNotifier<String> {
  CredentialsNotifier(this.storage) : super("");

  final FlutterSecureStorage storage;

  void storeCredential(String key, String value) async {
    await storage.write(
        key: key,
        value: value,
        aOptions: const AndroidOptions(
          encryptedSharedPreferences: true,
        ),
        iOptions:
            const IOSOptions(accessibility: IOSAccessibility.first_unlock));
  }

  Future<String?> getCredential(String key) async {
    final value = await storage.read(
        key: key,
        aOptions: const AndroidOptions(
          encryptedSharedPreferences: true,
        ),
        iOptions:
            const IOSOptions(accessibility: IOSAccessibility.first_unlock));
    state = value!;

    return value;
  }

  void deleteCredential(String key) async {
    await storage.delete(
        key: key,
        aOptions: const AndroidOptions(
          encryptedSharedPreferences: true,
        ),
        iOptions:
            const IOSOptions(accessibility: IOSAccessibility.first_unlock));
  }

  void clear() async {
    await storage.deleteAll();
  }
}
