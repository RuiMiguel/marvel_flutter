import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateParser on String {
  String parseDate({String dateFormat = "yyyy-mm-dd HH:mm a"}) {
    final datetime = DateTime.parse(this);
    final format = DateFormat(dateFormat);
    return format.format(datetime);
  }
}

extension CurrencyParser on double {
  String toCurrency(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    var currency = NumberFormat.simpleCurrency(locale: locale.toString());
    return "$this ${currency.currencySymbol} ${currency.currencyName}";
  }
}
