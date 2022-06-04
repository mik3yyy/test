import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/set_default_as_wallet_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/repo/wallet_repo.dart';

import '../../../../Data/controller/controller/generic_state_notifier.dart';

final setWalletAsDefaultProvider = StateNotifierProvider<SetWalletAsDefaultVm,
    RequestState<SetWalletAsDefaultRes>>(
  (ref) => SetWalletAsDefaultVm(ref),
);

class SetWalletAsDefaultVm extends RequestStateNotifier<SetWalletAsDefaultRes> {
  final WalletRepo _walletRepo;

  SetWalletAsDefaultVm(Ref ref) : _walletRepo = ref.read(walletManagerProvider);

  void setWalletAsDefault(
    String currency,
  ) =>
      makeRequest(() => _walletRepo.setWalletAsDefault(currency));
}
