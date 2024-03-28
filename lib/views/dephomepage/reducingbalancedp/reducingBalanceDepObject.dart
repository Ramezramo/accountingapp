import 'package:flutter/material.dart';


class CalculateStraitLineDep {
  String? originalCostStr;
  String? salvageValueStr;
  String? usefulLifeStr;
  int depreciationPerYear_ = 0 ;
  CalculateStraitLineDep(
      {required this.originalCostStr,
        required this.salvageValueStr,
        required this.usefulLifeStr});
  int calculateMonths(DateTime startDate, DateTime endDate) {
    return (endDate.year - startDate.year) * 12 + endDate.month - startDate.month;
  }

  int calculateDepreciationPerYear() {
    int originalCost = int.parse(originalCostStr!);
    int salvageValue = int.parse(salvageValueStr!);
    int usefulLife = int.parse(usefulLifeStr!);
    depreciationPerYear_ = ((originalCost - salvageValue) / usefulLife).floor();
    return depreciationPerYear_;
  }


  divideTheDepOverTheUsefulLife(){
    int usefulLife = int.parse(usefulLifeStr!);
    int originalCost = int.parse(originalCostStr!);
    Map depPerYear = {};
    int originalCostValueWillDecrease = originalCost ;
    calculateDepreciationPerYear();
    for (int i = 1; i < usefulLife + 1; i += 1){
      depPerYear.addAll(
          {"year $i":
        "${(originalCostValueWillDecrease - depreciationPerYear_)}"
      });
      originalCostValueWillDecrease  -= depreciationPerYear_ ;
    }
    print(depPerYear);
  }


}