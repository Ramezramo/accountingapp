
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../db/DealWithDataBase.dart';
Future<void> main() async {

  runApp(StriaghtLineDep());
}

// int calcDepPerYear(){
//
//
//   return
// }
void calculator(TextEditingController originalCostController, TextEditingController salvageValueController, TextEditingController usefulLifeController) {
  int? originalCost = int.tryParse(originalCostController.text);
  int? salvageValue = int.tryParse(salvageValueController.text);
  int? usefulLife = int.tryParse(usefulLifeController.text);

  int? depCalculationperyear;

  if (originalCost != null && salvageValue != null && usefulLife != null) {
    try {
      depCalculationperyear = (originalCost - salvageValue) ~/ usefulLife;
      // ~/ is used for integer division, rounding down if necessary
    } catch (e) {
      print('Error calculating depreciation: $e');
    }
  } else {
    print('Invalid input values');
  }

  print(depCalculationperyear);
}

class StriaghtLineDep extends StatelessWidget {
  late final TextEditingController originalCostController =TextEditingController();
  late final TextEditingController salvageValueController =TextEditingController();
  late final TextEditingController usefulLifeController =TextEditingController() ;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(

      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            // border: Border.all(),
            borderRadius: BorderRadius.circular(10), // Optional: Adds rounded corners
            color: Colors.grey[100], // Optional: Sets background color
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextWithTextField(textEditingController: originalCostController,label: 'Original Cost'),
              TextWithTextField(textEditingController: salvageValueController,label: 'Salvage Value'),
              TextWithTextField(textEditingController: usefulLifeController,label: 'Useful Life'),
              const SizedBox(height: 20), // Add spacing between text bars and labels
              ElevatedButton(
                onPressed: () {
                  final DatabaseHelper dbHelper = DatabaseHelper();

                  dbHelper.updateSettingsValueKey("pic-quality-after-comp",originalCostController.text);
                  // Add your button functionality here
                  dbHelper.logAllSettingsStoredInDB();
                  calculator(originalCostController, salvageValueController, usefulLifeController);
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
  final TextEditingController textEditingController ;
  const TextWithTextField({Key? key, required this.label, required this.textEditingController}) : super(key: key);

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
          TextField(controller: textEditingController,

          ),
        ],
      ),
    );
  }
}
