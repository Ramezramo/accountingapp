import 'package:flutter/material.dart';

class CurrencyConverterForm extends StatefulWidget {
  @override
  _CurrencyConverterFormState createState() => _CurrencyConverterFormState();
}

class _CurrencyConverterFormState extends State<CurrencyConverterForm> {
  String _amount = '300';
  String _fromCurrency = 'AUD';
  String _toCurrency = 'AUD';
  bool _showPopularCurrenciesOnly = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              initialValue: _amount,
              onChanged: (value) {
                setState(() {
                  _amount = value;
                });
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('From:'),
                DropdownButton<String>(
                  value: _fromCurrency,
                  onChanged: (String? newValue) {
                    setState(() {
                      _fromCurrency = newValue!;
                    });
                  },
                  items: <String>[
                    'AUD',
                    'BRL',
                    'BTC',
                    'CAD',
                    'CHF',
                    'CNY',
                    'EUR',
                    'GBP',
                    'HKD',
                    'INR',
                    'JPY',
                    'KRW',
                    'MXN',
                    'RUB',
                    'SGD',
                    'USD',
                    'ZAR'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('To:'),
                DropdownButton<String>(
                  value: _toCurrency,
                  onChanged: (String? newValue) {
                    setState(() {
                      _toCurrency = newValue!;
                    });
                  },
                  items: <String>[
                    'AUD',
                    'BRL',
                    'BTC',
                    'CAD',
                    'CHF',
                    'CNY',
                    'EUR',
                    'GBP',
                    'HKD',
                    'INR',
                    'JPY',
                    'KRW',
                    'MXN',
                    'RUB',
                    'SGD',
                    'USD',
                    'ZAR'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Checkbox(
                  value: _showPopularCurrenciesOnly,
                  onChanged: (bool? newValue) {
                    setState(() {
                      _showPopularCurrenciesOnly = newValue!;
                    });
                  },
                ),
                Text('Show most popular currencies only'),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Add your calculation logic here
                  },
                  child: Text('Calculate'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add your clear form logic here
                  },
                  child: Text('Clear'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
