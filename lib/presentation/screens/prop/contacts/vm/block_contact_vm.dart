import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/new_sign_in_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/messages/message_repository/message_manager.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/vm/get_contacts_vm.dart';

final blockContactProvider =
    StateNotifierProvider.autoDispose<BlockContactVM, RequestState<GenericRes>>(
        (ref) {
  return BlockContactVM(ref);
});

class BlockContactVM extends RequestStateNotifier<GenericRes> {
  final Ref ref;

  BlockContactVM(this.ref);

  void blockContact(int id) => makeRequest(() async {
        final res = await ref.read(messageManagerProvider).blockContact(id);
        if (res.status == "success") {
          ref.invalidate(allContactsProvider);
        }
        return res;
      });
}
