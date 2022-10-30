import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/constant/constant.dart';
import 'package:kayndrexsphere_mobile/Data/database/transactions/wallet_transaction.dart';

class WalletTransactionDBNotifier
    extends StateNotifier<List<TransactionDataBase>> {
  WalletTransactionDBNotifier() : super([]);
  var walletdb = Hive.box<TransactionDataBase>(Constants.transaction);

  getData() {
    if (walletdb.values.isEmpty) {
      return [];
    } else {
      final active = walletdb.values.toList().cast<TransactionDataBase>();
      state = active;
    }
  }

  deleteData() {
    walletdb.clear();
  }
}

final walletDataProvider = StateNotifierProvider<WalletTransactionDBNotifier,
    List<TransactionDataBase>>((ref) {
  return WalletTransactionDBNotifier();
});
