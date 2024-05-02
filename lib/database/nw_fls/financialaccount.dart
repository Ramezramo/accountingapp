import 'package:flutter/material.dart'; // Import the material package for Color

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
