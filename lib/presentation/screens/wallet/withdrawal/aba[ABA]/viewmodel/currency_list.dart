class CurrencyModel {
  String currency;
  String code;
  CurrencyModel({
    required this.currency,
    required this.code,
  });
}

final List<CurrencyModel> currencylist = [
  CurrencyModel(currency: "Dollar", code: "USD"),
  CurrencyModel(currency: "Pound", code: "GBP"),
  CurrencyModel(currency: "Euro", code: "EURO"),
  CurrencyModel(currency: "Naira", code: "NGN"),
  CurrencyModel(currency: "Kayndrex", code: "KAYNDREX")
];
