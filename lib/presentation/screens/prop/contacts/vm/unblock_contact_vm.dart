import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/new_sign_in_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/messages/message_repository/message_manager.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/vm/get_contacts_vm.dart';

final unBlockContactProvider = StateNotifierProvider.autoDispose<
    UnBlockContactVM, RequestState<GenericRes>>((ref) {
  return UnBlockContactVM(ref);
});

class UnBlockContactVM extends RequestStateNotifier<GenericRes> {
  final Ref ref;

  UnBlockContactVM(this.ref);

  void unblockContact(int id) => makeRequest(() async {
        final res = await ref.read(messageManagerProvider).unblockContact(id);
        if (res.status == "success") {
          ref.invalidate(allContactsProvider);
        }
        return res;
      });
}
