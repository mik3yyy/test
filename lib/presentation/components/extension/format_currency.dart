String formatCurrency(String number) {
  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');

  // ignore: prefer_function_declarations_over_variables
  final mathFunc = (Match match) => '${match[1]},';

  String result = number.replaceAllMapped(reg, mathFunc);
  return result;
}
