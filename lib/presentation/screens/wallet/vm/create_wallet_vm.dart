import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/create_wallet_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/repo/wallet_repo.dart';

final createWalletProvider =
    StateNotifierProvider<CreateWalletVm, RequestState<CreateWalletRes>>(
  (ref) => CreateWalletVm(ref),
);

class CreateWalletVm extends RequestStateNotifier<CreateWalletRes> {
  final WalletRepo _walletRepo;

  CreateWalletVm(Ref ref) : _walletRepo = ref.read(walletManagerProvider);

  Future<RequestState<CreateWalletRes>> createWallet(
    String currency,
  ) =>
      makeRequest(() => _walletRepo.createWallet(currency));
}
