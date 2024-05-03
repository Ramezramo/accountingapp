import 'package:flutter/material.dart'; // Import the material package for Color
const String bankAccountTableRM = 'FinancialAccount';

class BankAccountFieldsRM {
  static String id = "id";
  static String name = 'name';
  static String symbol = 'symbol';
  static String color = 'color';
  static String startingValue = 'startingValue';
  static String active = 'active';
  static String mainAccount = 'mainAccount';
  static String total = 'total';
  static String createdAt = 'CreatedAt';
  static String updatedAt = 'UpdatedAt';

  static final List<String> allFields = [
    id,
    name,
    symbol,
    color,
    startingValue,
    active,
    mainAccount,
   createdAt,
    updatedAt
  ];
}
class FinancialAccount {
  final Object? accountIcon;
  final Object? accountName;
  final Object? accountBeginning;
  final Object? mainAccount;
  final Object? color;
  Object? id;

  FinancialAccount(
      {required this.id,
      required this.accountIcon,
      required this.accountName,
      required this.accountBeginning,
      required this.mainAccount,
      required this.color});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'account_icon': accountIcon,
      'account_name': accountName,
      'account_beggening': accountBeginning,
      'main_account': mainAccount,
      'color': color.toString(), // Convert Color to string representation
    };
  }

  @override
  String toString() {
    return 'FinancialAccount{account_icon: $accountIcon, account_name: $accountName, account_beggening: $accountBeginning, main_account: $mainAccount, color: $color}';
  }
}
