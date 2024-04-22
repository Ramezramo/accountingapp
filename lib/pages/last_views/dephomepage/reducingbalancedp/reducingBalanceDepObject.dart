class CalculatereducingBalanceDep {
  String? originalCostStr;
  String? salvageValueStr;
  String? usefulLifeStr;
  String? depreciationRatester;
  int depreciationPerYear_ = 0;
  bool withSelvage;
  CalculatereducingBalanceDep(
      {required this.withSelvage,
      required this.depreciationRatester,
      required this.originalCostStr,
      required this.salvageValueStr,
      required this.usefulLifeStr});
  int calculateMonths(DateTime startDate, DateTime endDate) {
    return (endDate.year - startDate.year) * 12 +
        endDate.month -
        startDate.month;
  }

  // int calculateDepreciationPerYear() {
  //   int originalCost = int.parse(originalCostStr!);
  //   int salvageValue = int.parse(salvageValueStr!);
  //   int usefulLife = int.parse(usefulLifeStr!);
  //   depreciationPerYear_ = ((originalCost - salvageValue) / usefulLife).floor();
  //   return depreciationPerYear_;
  // }

  divideTheDepOverTheUsefulLife() {
    if (withSelvage) {
      calulateWithSelvageValue();
    } else {
      calulateNoSelvageValue();
    }
  }

  calulateWithSelvageValue() {
    int usefulLife = int.parse(usefulLifeStr!);
    int originalCost = int.parse(originalCostStr!);
    double depreciationRate = double.parse(depreciationRatester!);
    int salvageValue = int.parse(salvageValueStr!);
    Map depPerYear = {};
    int originalCostValueWillDecrease = originalCost;
    int lastYearEquationResult = 0;
    // calculateDepreciationPerYear();
    for (int i = 1; i < usefulLife + 1; i += 1) {
      int EquationResult =
          ((originalCostValueWillDecrease - salvageValue) * depreciationRate)
              .floor();
      Map willBeAdded = {
        "year $i": {
          "net-book-value":
              "$lastYearEquationResult - ${originalCostValueWillDecrease + lastYearEquationResult} = $originalCostValueWillDecrease",
          "Depreciation":
              "$originalCostValueWillDecrease - $salvageValue * $depreciationRate = $EquationResult"
        }
      };
      originalCostValueWillDecrease -= EquationResult;

      depPerYear.addAll(willBeAdded);

      lastYearEquationResult = EquationResult;
    }
  }

  calulateNoSelvageValue() {
    /// from the ifrs course
    int usefulLife = int.parse(usefulLifeStr!);
    int originalCost = int.parse(originalCostStr!);
    double depreciationRate = double.parse(depreciationRatester!);
    int salvageValue = int.parse(salvageValueStr!);
    Map depPerYear = {};
    int originalCostValueWillDecrease = originalCost;
    int lastYearEquationResult = 0;
    // calculateDepreciationPerYear();
    for (int i = 1; i < usefulLife + 1; i += 1) {
      int EquationResult =
          ((originalCostValueWillDecrease - lastYearEquationResult) *
                  depreciationRate)
              .floor();
      Map willBeAdded = {
        "year $i": {
          "net-book-value":
              "$lastYearEquationResult - ${originalCostValueWillDecrease + lastYearEquationResult} = $originalCostValueWillDecrease",
          "Depreciation":
              "$originalCostValueWillDecrease - $salvageValue * $depreciationRate = $EquationResult"
        }
      };
      originalCostValueWillDecrease -= EquationResult;

      depPerYear.addAll(willBeAdded);

      lastYearEquationResult = EquationResult;
    }
  }
}
