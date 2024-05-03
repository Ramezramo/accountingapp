// import 'package:accounting_app_last/model/base_entity.dart';
import 'package:flutter/material.dart';

import '../../model/ol_fls/base_entity.dart'; // Import the material package for Color

const String transactionTableRM = 'UsAccTransaction';

class TransactionFieldsRM extends BaseEntityFields {
  static String id = 'id';
  static String date = 'date';
  static String amount = 'amount';
  static String type = 'type';
  static String note = 'note';
  static String idCategory = 'idCategory'; // FK
  static String categoryName = 'categoryName';
  static String categoryColor = 'categoryColor';
  static String categorySymbol = 'categorySymbol';
  static String idBankAccount = 'idBankAccount'; // FK
  static String bankAccountName = 'bankAccountName';
  static String idBankAccountTransfer = 'idBankAccountTransfer';
  static String bankAccountTransferName = 'bankAccountTransferName';
  static String recurring = 'recurring';
  static String recurrencyType = 'recurrencyType';
  static String recurrencyPayDay = 'recurrencyPayDay';
  static String recurrencyFrom = 'recurrencyFrom';
  static String recurrencyTo = 'recurrencyTo';
  static String createdAt = 'createdAt';
  static String updatedAt = 'updatedAt';

  static final List<String> allFields = [
    date,
    amount,
    type,
    note,
    idCategory,
    idBankAccount,
    idBankAccountTransfer,
    recurring,
    recurrencyType,
    recurrencyPayDay,
    recurrencyFrom,
    recurrencyTo,
    createdAt,
    updatedAt
  ];
}

class AccTransaction {
  // ignore: non_constant_identifier_names
  final Object?
      transactionType; // may it will an expenses or an income or a tarnsfer
  final Object?
      transactionFinancialAccount; // attatch the account that user will create if it is cash or loan
  final Object? ammount;
  final Object? category;
  final Object? date;
  final Object? description;
  final Object? id;
  //     '245344533454': {
  //       'transaction-type': 'expenses',
  //       'ammount': '500',
  //       'account-name': 'easter foods',
  //       'category': 'food',
  //       'date': '',
  //       'description': 'hello this is the firs account in the app '
  //     }
  AccTransaction({
    required this.id,
    required this.transactionType,
    required this.ammount,
    required this.category,
    required this.date,
    required this.description,
    required this.transactionFinancialAccount,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      TransactionFieldsRM.type: transactionType,
      TransactionFieldsRM.amount: ammount,
      TransactionFieldsRM.categoryName: category,
      TransactionFieldsRM.date: date,
      TransactionFieldsRM.note: description,
      TransactionFieldsRM.bankAccountName: transactionFinancialAccount,
    };
  }

  @override
  String toString() {
    return '''Transaction{
      'id': $id,
      'transaction_type': $transactionType,
      'ammount': $ammount,
      'category': $category,
      'date': $date,
      'description': $description,
      'transaction_financial_account': $transactionFinancialAccount,
    }''';
  }
}
