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

class TVMcalculator extends StatefulWidget {
  @override
  _CalculatorFormState createState() => _CalculatorFormState();
}

class _CalculatorFormState extends State<TVMcalculator> {
  String _selectedSolve = 'rate';
  double _presentValue = 44;
  double _futureValue = 44;
  double _interestRate = 44;
  double _periods = 44;
  double _payment = 4444;
  final _formKey = GlobalKey<FormState>(); // Add this line
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
                    Text('Present Value'),
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
                    Text('Interest Rate'),
                    Radio(
                      value: 'periods',
                      groupValue: _selectedSolve,
                      onChanged: (value) {
                        setState(() {
                          _selectedSolve = value!;
                        });
                      },
                    ),
                    Text('Periods'),
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
                    Text('Repeating payment'),
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
              decoration: InputDecoration(labelText: 'Present value (PV)'),
            ),
            TextFormField(
              initialValue: _futureValue.toString(),
              onChanged: (value) {
                setState(() {
                  _futureValue = double.parse(value);
                });
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Future value (FV)'),
            ),
            TextFormField(
              initialValue: _interestRate.toString(),
              onChanged: (value) {
                setState(() {
                  _interestRate = double.parse(value);
                });
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Interest rate (%)'),
            ),
            TextFormField(
              initialValue: _periods.toString(),
              onChanged: (value) {
                setState(() {
                  _periods = double.parse(value);
                });
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Number of periods'),
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
            SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add your calculation logic here
                },
                child: Text('Calculate'),
              ),
            ),
          ],
        ),
    );
  }
}
