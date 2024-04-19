// import 'package:accountingapp/views/depreciation/straitLineDepObject.dart';
// import 'package:accountingapp/views/straitlinedepreciation/straitLineDepObject.dart';
// import 'package:accountingapp/views/dephomepage/straitlinedepreciation/straitLineDepObject.dart';
import 'package:flutter/material.dart';
import 'package:accounting_app_last/pages/last_views/dephomepage/straitlinedepreciation/straitLineDepObject.dart';

// import '../reducingbalancedp/reducingBalanceDepObject.dart';
// import '../reducingbalancedp/straitLineDepObject.dart';

// import '../../Widgets/MonthesPickerWidget.dart';
// import '../../db/DealWithDataBase.dart';
Future<void> main() async {
  runApp(StriaghtLineDep());
}

// int calcDepPerYear(){
//
//
//   return
// }

class StriaghtLineDep extends StatelessWidget {
  late final TextEditingController originalCostController =
      TextEditingController();
  late final TextEditingController salvageValueController =
      TextEditingController();
  late final TextEditingController usefulLifeController =
      TextEditingController();

  StriaghtLineDep({super.key});
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
            color: Colors.grey[100], // Optional: Sets background color
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextWithTextField(
                  textEditingController: originalCostController,
                  label: 'Original Cost'),
              TextWithTextField(
                  textEditingController: salvageValueController,
                  label: 'Salvage Value'),
              TextWithTextField(
                  textEditingController: usefulLifeController,
                  label: 'Useful Life'),
              const SizedBox(
                  height: 20), // Add spacing between text bars and labels
              // MonthPickerButton(),

              ElevatedButton(
                onPressed: () {
                  // final DatabaseHelper dbHelper = DatabaseHelper();

                  // dbHelper.updateSettingsValueKey("pic-quality-after-comp",originalCostController.text);
                  // // Add your button functionality here
                  // dbHelper.logAllSettingsStoredInDB();

                  CalculateStraitLineDep depCalcClass = CalculateStraitLineDep(
                      originalCostStr: originalCostController.text,
                      salvageValueStr: salvageValueController.text,
                      usefulLifeStr: usefulLifeController.text);

                  print(depCalcClass.divideTheDepOverTheUsefulLife());
                  // calculator(originalCostController, salvageValueController, usefulLifeController);
                },
                child: const Text('Submit'),
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
  const TextWithTextField(
      {Key? key, required this.label, required this.textEditingController})
      : super(key: key);

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
          ),
        ],
      ),
    );
  }
}
