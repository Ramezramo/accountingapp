import 'package:flutter/material.dart';
import 'package:accounting_app_last/pages/currency_calculator/scrap_data.dart';

class CurrencyConverterForm extends StatefulWidget {
  @override
  _CurrencyConverterFormState createState() => _CurrencyConverterFormState();
}

class _CurrencyConverterFormState extends State<CurrencyConverterForm> {
  String _amount = '0';
  String _fromCurrency = 'AUD';
  String _toCurrency = 'AUD';
  TextEditingController textEditingController = TextEditingController();

  Future<String>? _exchangeResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: textEditingController,
                    onChanged: (value) {
                      setState(() {
                        _amount = value;
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Amount'),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _amount = '0';
                      textEditingController.clear();
                    });
                  },
                  icon: const Icon(Icons.close),
                )
              ],
            ),
            const SizedBox(height: 20.0),
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
                    'EGP',
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
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('To:'),
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
                    'EGP',
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
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _exchangeResult = exchange(_amount, _fromCurrency, _toCurrency);
                      });
                    },
                    child: const Text('Calculate'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _amount = '0';
                        textEditingController.clear();
                        _exchangeResult = null; // Clear the result
                      });
                    },
                    child: const Text('Clear'),
                  ),
                ],
              ),
            ),
            if (_exchangeResult != null) ...[
              const SizedBox(height: 20.0),
              FutureBuilder<String>(
                future: _exchangeResult,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Text('Result: ${snapshot.data}');
                  }
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
