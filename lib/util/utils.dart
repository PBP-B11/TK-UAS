import 'package:intl/intl.dart';

String convertToIdr(dynamic number, int decimalDigit) {
  NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp',
    decimalDigits: decimalDigit,
  );
  return currencyFormatter.format(number);
}