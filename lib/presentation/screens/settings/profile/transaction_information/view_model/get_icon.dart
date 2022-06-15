import 'package:flutter/material.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/transaction_information/custom_card_type_icon.dart';

// import 'glassmorphism_config.dart';

const Map<CardType, String> cardTypeIconAsset = <CardType, String>{
  CardType.visa: AppImage.visa,
  CardType.americanExpress: AppImage.americanExpress,
  CardType.mastercard: AppImage.masterCard,
  CardType.verve: AppImage.verve,
};

class CreditCardWidget extends StatefulWidget {
  const CreditCardWidget(
      {Key? key, required this.customCardTypeIcons, required this.cardNumber

      // required this.onCreditCardWidgetChange
      })
      : super(key: key);

  final List<CustomCardTypeIcon> customCardTypeIcons;
  final String cardNumber;

  @override
  _CreditCardWidgetState createState() => _CreditCardWidgetState();
}

class _CreditCardWidgetState extends State<CreditCardWidget>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  // void _gradientSetup() {

  // }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        getCardTypeIcon(widget.cardNumber),
      ],
    );
  }

  /// Credit Card prefix patterns as of March 2019
  /// A [List<String>] represents a range.
  /// i.e. ['51', '55'] represents the range of cards starting with '51' to those starting with '55'
  Map<CardType, Set<List<String>>> cardNumPatterns =
      <CardType, Set<List<String>>>{
    CardType.visa: <List<String>>{
      <String>['4'],
    },
    CardType.americanExpress: <List<String>>{
      <String>['34'],
      <String>['37'],
    },
    CardType.verve: <List<String>>{
      <String>['6011'],
      <String>['622126', '622925'],
      <String>['644', '649'],
      <String>['65']
    },
    CardType.mastercard: <List<String>>{
      <String>['51', '55'],
      <String>['2221', '2229'],
      <String>['223', '229'],
      <String>['23', '26'],
      <String>['270', '271'],
      <String>['2720'],
    },
  };

  /// This function determines the Credit Card type based on the cardPatterns
  /// and returns it.
  CardType detectCCType(String cardNumber) {
    //Default card type is other
    CardType cardType = CardType.otherBrand;

    if (cardNumber.isEmpty) {
      return cardType;
    }

    cardNumPatterns.forEach(
      (CardType type, Set<List<String>> patterns) {
        for (List<String> patternRange in patterns) {
          // Remove any spaces
          String ccPatternStr =
              cardNumber.replaceAll(RegExp(r'\s+\b|\b\s'), '');
          final int rangeLen = patternRange[0].length;
          // Trim the Credit Card number string to match the pattern prefix length
          if (rangeLen < cardNumber.length) {
            ccPatternStr = ccPatternStr.substring(0, rangeLen);
          }

          if (patternRange.length > 1) {
            // Convert the prefix range into numbers then make sure the
            // Credit Card num is in the pattern range.
            // Because Strings don't have '>=' type operators
            final int ccPrefixAsInt = int.parse(ccPatternStr);
            final int startPatternPrefixAsInt = int.parse(patternRange[0]);
            final int endPatternPrefixAsInt = int.parse(patternRange[1]);
            if (ccPrefixAsInt >= startPatternPrefixAsInt &&
                ccPrefixAsInt <= endPatternPrefixAsInt) {
              // Found a match
              cardType = type;
              break;
            }
          } else {
            // Just compare the single pattern prefix with the Credit Card prefix
            if (ccPatternStr == patternRange[0]) {
              // Found a match
              cardType = type;
              break;
            }
          }
        }
      },
    );

    return cardType;
  }

  Widget getCardTypeImage(CardType? cardType) {
    final List<CustomCardTypeIcon> customCardTypeIcon =
        getCustomCardTypeIcon(cardType!);
    if (customCardTypeIcon.isNotEmpty) {
      return customCardTypeIcon.first.cardImage;
    } else {
      return Image.asset(
        cardTypeIconAsset[cardType]!,
        height: 48,
        width: 48,
        package: 'flutter_credit_card',
      );
    }
  }

  // This method returns the icon for the visa card type if found
  // else will return the empty container
  Widget getCardTypeIcon(String cardNumber) {
    Widget icon;
    final CardType ccType = detectCCType(cardNumber);
    final List<CustomCardTypeIcon> customCardTypeIcon =
        getCustomCardTypeIcon(ccType);
    if (customCardTypeIcon.isNotEmpty) {
      icon = customCardTypeIcon.first.cardImage;
    } else {
      switch (ccType) {
        case CardType.visa:
          icon = Image.asset(
            cardTypeIconAsset[ccType]!,
            height: 48,
            width: 48,
            package: 'flutter_credit_card',
          );

          break;

        case CardType.americanExpress:
          icon = Image.asset(
            cardTypeIconAsset[ccType]!,
            height: 48,
            width: 48,
            package: 'flutter_credit_card',
          );

          break;

        case CardType.mastercard:
          icon = Image.asset(
            cardTypeIconAsset[ccType]!,
            height: 48,
            width: 48,
            package: 'flutter_credit_card',
          );

          break;

        case CardType.discover:
          icon = Image.asset(
            cardTypeIconAsset[ccType]!,
            height: 48,
            width: 48,
            package: 'flutter_credit_card',
          );

          break;

        default:
          icon = const SizedBox(
            height: 48,
            width: 48,
          );

          break;
      }
    }

    return icon;
  }

  List<CustomCardTypeIcon> getCustomCardTypeIcon(CardType currentCardType) =>
      widget.customCardTypeIcons
          .where((CustomCardTypeIcon element) =>
              element.cardType == currentCardType)
          .toList();
}

enum CardType {
  otherBrand,
  mastercard,
  visa,
  americanExpress,
  discover,
  verve,
  maestro
}
