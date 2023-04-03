import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/new_sign_in_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/messages/message_repository/message_manager.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/vm/get_contacts_vm.dart';

final renameContactProvider = StateNotifierProvider.autoDispose<RenameContactVM,
    RequestState<GenericRes>>((ref) {
  return RenameContactVM(ref);
});

class RenameContactVM extends RequestStateNotifier<GenericRes> {
  final Ref ref;

  RenameContactVM(this.ref);

  void renameContact(String name, int id) => makeRequest(() async {
        final res =
            await ref.read(messageManagerProvider).renameContact(name, id);
        if (res.status == "success") {
          ref.invalidate(allContactsProvider);
        }
        return res;
      });
}
