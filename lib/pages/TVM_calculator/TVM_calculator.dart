
import 'package:flutter/material.dart';

// class CalculatorPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Calculator'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: CalculatorForm(),
//       ),
//     );
//   }
// }

// ignore: use_key_in_widget_constructors
class TVMcalculator extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _CalculatorFormState createState() => _CalculatorFormState();
}

class _CalculatorFormState extends State<TVMcalculator> {
  String _selectedSolve = 'rate';
  double _presentValue = 44;
  double _futureValue = 44;
  double _interestRate = 44;
  double _periods = 44;
  double _payment = 4444;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Radio(
                      value: 'future',
                      groupValue: _selectedSolve,
                      onChanged: (value) {
                        setState(() {
                          _selectedSolve = value!;
                        });
                      },
                    ),
                    const Text('Future Value'),
                    Radio(
                      value: 'present',
                      groupValue: _selectedSolve,
                      onChanged: (value) {
                        setState(() {
                          _selectedSolve = value!;
                        });
                      },
                    ),
                    const Text('Present Value'),
                  ],
                ),
      
                // Row(
                //   children: [
      
                //   ],
                // ),
                Row(
                  children: [
                    Radio(
                      value: 'rate',
                      groupValue: _selectedSolve,
                      onChanged: (value) {
                        setState(() {
                          _selectedSolve = value!;
                        });
                      },
                    ),
                    const Text('Interest Rate'),
                    Radio(
                      value: 'periods',
                      groupValue: _selectedSolve,
                      onChanged: (value) {
                        setState(() {
                          _selectedSolve = value!;
                        });
                      },
                    ),
                    const Text('Periods'),
                  ],
                ),
                // Row(
                //   children: [
      
                //   ],
                // ),
                Row(
                  children: [
                    Radio(
                      value: 'payment',
                      groupValue: _selectedSolve,
                      onChanged: (value) {
                        setState(() {
                          _selectedSolve = value!;
                        });
                      },
                    ),
                    const Text('Repeating payment'),
                  ],
                ),
              ],
            ),
            TextFormField(
              initialValue: _presentValue.toString(),
              onChanged: (value) {
                setState(() {
                  _presentValue = double.parse(value);
                });
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Present value (PV)'),
            ),
            TextFormField(
              initialValue: _futureValue.toString(),
              onChanged: (value) {
                setState(() {
                  _futureValue = double.parse(value);
                });
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Future value (FV)'),
            ),
            TextFormField(
              initialValue: _interestRate.toString(),
              onChanged: (value) {
                setState(() {
                  _interestRate = double.parse(value);
                });
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Interest rate (%)'),
            ),
            TextFormField(
              initialValue: _periods.toString(),
              onChanged: (value) {
                setState(() {
                  _periods = double.parse(value);
                });
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Number of periods'),
            ),
            TextFormField(
              initialValue: _payment.toString(),
              onChanged: (value) {
                setState(() {
                  _payment = double.parse(value);
                });
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Payment'),
            ),
            const SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add your calculation logic here
                },
                child: const Text('Calculate'),
              ),
            ),
          ],
        ),
    );
  }
}
