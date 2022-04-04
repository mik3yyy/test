class WalletNamelist {
  final String currency;
  final String amount;

  WalletNamelist({
    required this.currency,
    required this.amount,
  });
}

final List<WalletNamelist> walletNameList = [
  WalletNamelist(currency: 'Dollar', amount: '\$ 200.0'),
  WalletNamelist(currency: 'Pound', amount: '\$ 300.0'),
  WalletNamelist(currency: 'Euro', amount: '\$ 0.0'),
  WalletNamelist(currency: 'Naira', amount: 'N 40,000.0'),
];
