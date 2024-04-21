// import 'package:accountingapp/views/depreciation/straitLineDepObject.dart';
// import 'package:accountingapp/views/straitlinedepreciation/straitLineDepObject.dart';
// import 'package:accountingapp/views/dephomepage/reducingbalancedp/reducingBalanceDepObject.dart';
import 'package:accounting_app_last/custom_widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:accounting_app_last/pages/last_views/dephomepage/reducingbalancedp/reducingBalanceDepObject.dart';

// import '../../Widgets/MonthesPickerWidget.dart';
// import '../../db/DealWithDataBase.dart';
Future<void> main() async {
  runApp(reducingBalance());
}

// int calcDepPerYear(){
//
//
//   return
// }
bool isWithSelvage = true;

class reducingBalance extends StatefulWidget {
  reducingBalance({super.key});

  @override
  State<reducingBalance> createState() => _reducingBalanceState();
}

class _reducingBalanceState extends State<reducingBalance> {
  late final TextEditingController originalCostController =
      TextEditingController();

  late final TextEditingController salvageValueController =
      TextEditingController();

  late final TextEditingController usefulLifeController =
      TextEditingController();

  late final TextEditingController depreciationRate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            // border: Border.all(),
            borderRadius:
                BorderRadius.circular(10), // Optional: Adds rounded corners
            color:  Theme.of(context)
                .colorScheme
                .tertiary, // Optional: Sets background color
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextWithTextField(
                  textEditingController: originalCostController,
                  label: 'Original Cost'),
              TextWithTextField(
                  textEditingController: depreciationRate,
                  label: 'Depreciation Rate'),
              TextWithTextField(
                  textEditingController: usefulLifeController,
                  label: 'Useful Life'),
              TextWithTextField(
                  textEditingController: salvageValueController,
                  label: 'Salvage Value'),
              // Switch(
              //   value: isWithSelvage,
              //   onChanged: (value) {
              //     setState(() {
              //       isWithSelvage =
              //           value; // Update the state variable when the switch is toggled.
              //     });
              //   },
              // ),
              const SizedBox(
                  height: 20), // Add spacing between text bars and labels
              // MonthPickerButton(),
              ButtonWidget(
                icon: Icons.done,
                onPressed: () {
                  CalculatereducingBalanceDep depCalcClass =
                      CalculatereducingBalanceDep(
                          withSelvage: isWithSelvage,
                          originalCostStr: originalCostController.text,
                          salvageValueStr: salvageValueController.text,
                          usefulLifeStr: usefulLifeController.text,
                          depreciationRatester: depreciationRate.text);

                  print(depCalcClass.divideTheDepOverTheUsefulLife());
                },
                text: "Submit",
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class TextWithTextField extends StatelessWidget {
  final String label;
  final TextEditingController textEditingController;
  final bool isEnabled; // Add a boolean variable to control the enabled state
  const TextWithTextField({
    Key? key,
    required this.label,
    required this.textEditingController,
    this.isEnabled = true, // Default is true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 5),
          TextField(
            controller: textEditingController,
            enabled:
                isEnabled, // Control the enabled state based on the isEnabled variable
          ),
        ],
      ),
    );
  }
}
