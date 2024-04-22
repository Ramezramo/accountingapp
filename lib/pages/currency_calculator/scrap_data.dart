import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';

Future<String> exchange(
    String ammount, String fromCurrency, String toCurrency) async {
  String fileName = 'country_currency.json';
  // String amount = '1';
  String link =
      'https://www.xe.com/currencyconverter/convert/?Amount=$ammount&From=$fromCurrency&To=$toCurrency';

  try {
    http.Response response = await http.get(Uri.parse(link));
    if (response.statusCode == 200) {
      var document = parse(response.body);
      var productTitles = document.querySelector('.sc-1c293993-1.fxoXHw')?.text;

      return productTitles?.trim() ?? ''; // Return the trimmed result
    } else {}
  } catch (e) {}
  return ''; // Return empty string if there's an error
}
