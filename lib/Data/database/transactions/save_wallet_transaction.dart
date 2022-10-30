import 'dart:developer';

import 'package:hive_flutter/adapters.dart';
import 'package:kayndrexsphere_mobile/Data/constant/constant.dart';
import 'package:kayndrexsphere_mobile/Data/database/transactions/wallet_transaction.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/wallet_transactions.dart';

class SaveWalletTransaction {
  final allWalletXX = Hive.box<TransactionDataBase>(Constants.transaction);
  final List<TransactionDataBase> walletX = [];

  void saveWalletTransaction(List<Transaction> data) {
    for (var trsnc in data) {
      var active = TransactionDataBase()
        ..accountNumber = trsnc.user?.accountNumber ?? ""
        ..address = trsnc.user?.address ?? ""
        ..amount = trsnc.amount ?? 0.0
        ..balanceAfterTransaction = trsnc.balanceAfterTransaction ?? 0.0
        ..balanceBeforeTransaction = trsnc.balanceBeforeTransaction ?? 0.0
        ..countryCode = trsnc.currencyCode ?? ""
        ..createdAt = trsnc.createdAt
        ..description = trsnc.description
        ..direction = trsnc.direction
        ..firstName = trsnc.user?.firstName ?? ""
        ..lastName = trsnc.user?.lastName ?? "";

      walletX.add(active);
    }

    if (allWalletXX.isEmpty) {
      log("I GOT HERE WHEN EMPTY");
      allWalletXX.addAll(walletX);
    } else {
      log("I GOT HERE WHEN RELOADING");
      allWalletXX.clear().then((value) {
        allWalletXX.addAll(walletX);
      });
    }
  }
}
