// import 'package:accounting_app_last/model/base_entity.dart';
import 'package:flutter/material.dart';

import '../../model/ol_fls/base_entity.dart'; // Import the material package for Color
import 'package:accounting_app_last/newdfiles/dboperations/DealWithDataBase.dart';

const String transactionTableRM = 'UsAccTransaction';

class TransactionFieldsRM extends BaseEntityFields {
  static String id = 'id';
  static String date = 'date';
  static String amount = 'amount';
  static String type = 'type';
  static String typeExpenses = 'expenses';
  static String typeIncome = 'income';
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

class TransactionRM extends BaseEntity {
  final DateTime date;
  final num amount;
  final String type;
  final String? note;
  final int? idCategory;
  final String? categoryName;
  final int? categoryColor;
  final String? categorySymbol;
  final int idBankAccount;
  final String? bankAccountName;
  final int? idBankAccountTransfer;
  final String? bankAccountTransferName;
  final bool recurring;
  final String? recurrencyType;
  final int? recurrencyPayDay;
  final DateTime? recurrencyFrom;
  final DateTime? recurrencyTo;

  const TransactionRM(
      {super.id,
      required this.date,
      required this.amount,
      required this.type,
      this.note,
      this.idCategory,
      this.categoryName,
      this.categoryColor,
      this.categorySymbol,
      required this.idBankAccount,
      this.bankAccountName,
      this.idBankAccountTransfer,
      this.bankAccountTransferName,
      required this.recurring,
      this.recurrencyType,
      this.recurrencyPayDay,
      this.recurrencyFrom,
      this.recurrencyTo,
      super.createdAt,
      super.updatedAt});

  TransactionRM copy(
          {int? id,
          DateTime? date,
          num? amount,
          String? type,
          String? note,
          int? idCategory,
          int? idBankAccount,
          int? idBankAccountTransfer,
          bool? recurring,
          String? recurrencyType,
          int? recurrencyPayDay,
          DateTime? recurrencyFrom,
          DateTime? recurrencyTo,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      TransactionRM(
          id: id ?? this.id,
          date: date ?? this.date,
          amount: amount ?? this.amount,
          type: type ?? this.type,
          note: note ?? this.note,
          idCategory: idCategory ?? this.idCategory,
          idBankAccount: idBankAccount ?? this.idBankAccount,
          idBankAccountTransfer:
              idBankAccountTransfer ?? this.idBankAccountTransfer,
          recurring: recurring ?? this.recurring,
          recurrencyType: recurrencyType ?? this.recurrencyType,
          recurrencyPayDay: recurrencyPayDay ?? this.recurrencyPayDay,
          recurrencyFrom: recurrencyFrom ?? this.recurrencyFrom,
          recurrencyTo: recurrencyTo ?? this.recurrencyTo,
          createdAt: createdAt ?? this.createdAt,
          updatedAt: updatedAt ?? this.updatedAt);

  static TransactionRM fromJson(Map<String, Object?> json) => TransactionRM(
      id: json[BaseEntityFields.id] as int?,
      date: DateTime.parse(json[TransactionFieldsRM.date] as String),
      amount: json[TransactionFieldsRM.amount] as num,
      type: json[TransactionFieldsRM.type] as String,
      note: json[TransactionFieldsRM.note] as String?,
      idCategory: json[TransactionFieldsRM.idCategory] as int?,
      categoryName: json[TransactionFieldsRM.categoryName] as String?,
      categoryColor: json[TransactionFieldsRM.categoryColor] as int?,
      categorySymbol: json[TransactionFieldsRM.categorySymbol] as String?,
      idBankAccount: json[TransactionFieldsRM.idBankAccount] as int,
      bankAccountName: json[TransactionFieldsRM.bankAccountName] as String?,
      idBankAccountTransfer:
          json[TransactionFieldsRM.idBankAccountTransfer] as int?,
      bankAccountTransferName:
          json[TransactionFieldsRM.bankAccountTransferName] as String?,
      recurring: json[TransactionFieldsRM.recurring] == 1 ? true : false,
      recurrencyType: json[TransactionFieldsRM.recurrencyType] as String?,
      recurrencyPayDay: json[TransactionFieldsRM.recurrencyPayDay] as int?,
      recurrencyFrom: json[TransactionFieldsRM.recurrencyFrom] != null
          ? DateTime.parse(TransactionFieldsRM.recurrencyFrom)
          : null,
      recurrencyTo: json[TransactionFieldsRM.recurrencyTo] != null
          ? DateTime.parse(TransactionFieldsRM.recurrencyTo)
          : null,
      createdAt: DateTime.parse(json[BaseEntityFields.createdAt] as String),
      updatedAt: DateTime.parse(json[BaseEntityFields.updatedAt] as String));

  Map<String, Object?> toJson({bool update = false}) {
    print("inside the tojson");
    print({
      TransactionFieldsRM.id: id,
      TransactionFieldsRM.date: date.toIso8601String(),
      TransactionFieldsRM.amount: amount,
      TransactionFieldsRM.type:type ,
      TransactionFieldsRM.note: note,
      TransactionFieldsRM.idCategory: idCategory,
      TransactionFieldsRM.idBankAccount: idBankAccount,
      TransactionFieldsRM.idBankAccountTransfer: idBankAccountTransfer,
      TransactionFieldsRM.recurring: recurring ? 1 : 0,
      TransactionFieldsRM.recurrencyType: recurrencyType,
      TransactionFieldsRM.recurrencyPayDay: recurrencyPayDay,
      TransactionFieldsRM.recurrencyFrom: recurrencyFrom,
      TransactionFieldsRM.recurrencyTo: recurrencyTo,
      BaseEntityFields.createdAt: update
          ? createdAt?.toIso8601String()
          : DateTime.now().toIso8601String(),
      BaseEntityFields.updatedAt: DateTime.now().toIso8601String(),
    });
    return {
      TransactionFieldsRM.id: id,
      TransactionFieldsRM.date: date.toIso8601String(),
      TransactionFieldsRM.amount: amount,
      TransactionFieldsRM.type:type.toString(),
      TransactionFieldsRM.note: note,
      TransactionFieldsRM.idCategory: idCategory,
      TransactionFieldsRM.idBankAccount: idBankAccount,
      TransactionFieldsRM.idBankAccountTransfer: idBankAccountTransfer,
      TransactionFieldsRM.recurring: recurring ? 1 : 0,
      TransactionFieldsRM.recurrencyType: recurrencyType,
      TransactionFieldsRM.recurrencyPayDay: recurrencyPayDay,
      TransactionFieldsRM.recurrencyFrom: recurrencyFrom,
      TransactionFieldsRM.recurrencyTo: recurrencyTo,
      BaseEntityFields.createdAt: update
          ? createdAt?.toIso8601String()
          : DateTime.now().toIso8601String(),
      BaseEntityFields.updatedAt: DateTime.now().toIso8601String(),
    };
  }
}

enum TransactionTypeRM { income, expense, transfer, typeIncome, typeExpenses }

enum RecurrenceRM {
  daily,
  weekly,
  monthly,
  bimonthly,
  quarterly,
  semester,
  annual
}

Map<String, TransactionTypeRM> typeMapRM = {
  "IN": TransactionTypeRM.income,
  "OUT": TransactionTypeRM.expense,
  "TRSF": TransactionTypeRM.transfer,
};
Map<RecurrenceRM, String> recurrenceMapRM = {
  RecurrenceRM.daily: "Daily",
  RecurrenceRM.weekly: "Weekly",
  RecurrenceRM.monthly: "Monthly",
  RecurrenceRM.bimonthly: "Bimonthly",
  RecurrenceRM.quarterly: "Quarterly",
  RecurrenceRM.semester: "Semester",
  RecurrenceRM.annual: "Annual",
};
