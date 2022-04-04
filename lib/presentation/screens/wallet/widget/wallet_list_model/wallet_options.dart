import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';

class WalletOptions {
  final String name;
  final String image;

  WalletOptions({
    required this.name,
    required this.image,
  });
}

final List<WalletOptions> walletOptions = [
  WalletOptions(name: 'Transfer', image: AppImage.transfer),
  WalletOptions(name: 'Add Funds', image: AppImage.addFunds),
  WalletOptions(name: 'Invest', image: AppImage.invest),
  WalletOptions(name: 'Withdraw', image: AppImage.withdraw),
];

class WalletCategories {
  final String name;
  final String image;
  final String description;

  WalletCategories(
      {required this.name, required this.image, required this.description});
}

final List<WalletCategories> walletCategories = [
  WalletCategories(
      name: 'Alpha',
      image: AppImage.alpha,
      description: 'Up to 2% value earned on every amount deposited to alpha'),
  WalletCategories(
      name: 'Beta',
      image: AppImage.beta,
      description: 'Earn between 3.2% and 16% value on every beta purchased'),
  WalletCategories(
      name: 'Delta',
      image: AppImage.delta,
      description:
          'A percentage of all credited amounts into your personal wallets gets invested in your delta portfolio'),
];
