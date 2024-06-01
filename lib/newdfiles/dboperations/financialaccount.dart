import 'package:flutter/material.dart';

import '../../model/ol_fls/base_entity.dart'; // Import the material package for Color
const String bankAccountTableRM = 'FinancialAccount';

class BankAccountFieldsRM extends BaseEntityFields {
  static String id = "id";
  static String name = 'name';
  static String symbol = 'symbol';
  static String color = 'color';
  static String startingValue = 'startingValue';
  static String active = 'active';
  static String mainAccount = 'mainAccount';
  static String total = 'total';
  static String createdAt = BaseEntityFields.getCreatedAt;
  static String updatedAt = BaseEntityFields.getUpdatedAt;

  
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

class BankAccountRM extends BaseEntity {
  final String name;
  final String symbol;
  final int color;
  final num startingValue;
  final bool active;
  final bool mainAccount;
  final num? total;

  const BankAccountRM(
      {super.id,
      required this.name,
      required this.symbol,
      required this.color,
      required this.startingValue,
      required this.active,
      required this.mainAccount,
      this.total,
      super.createdAt,
      super.updatedAt});

  BankAccountRM copy(
          {int? id,
          String? name,
          String? symbol,
          int? color,
          num? startingValue,
          bool? active,
          bool? mainAccount,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      BankAccountRM(
          id: id ?? this.id,
          name: name ?? this.name,
          symbol: symbol ?? this.symbol,
          color: color ?? this.color,
          startingValue: startingValue ?? this.startingValue,
          active: active ?? this.active,
          mainAccount: mainAccount ?? this.mainAccount,
          createdAt: createdAt ?? this.createdAt,
          updatedAt: updatedAt ?? this.updatedAt);

  static BankAccountRM fromJson(Map<String, Object?> json) => BankAccountRM(
      id: json[BaseEntityFields.id] as int,
      name: json[BankAccountFieldsRM.name] as String,
      symbol: json[BankAccountFieldsRM.symbol] as String,
      color: json[BankAccountFieldsRM.color] as int,
      startingValue: json[BankAccountFieldsRM.startingValue] as num,
      active: json[BankAccountFieldsRM.active] == 1 ? true : false,
      mainAccount: json[BankAccountFieldsRM.mainAccount] == 1 ? true : false,
      total: json[BankAccountFieldsRM.total] as num?,
      createdAt: DateTime.parse(json[BaseEntityFields.createdAt] as String),
      updatedAt: DateTime.parse(json[BaseEntityFields.updatedAt] as String));

  Map<String, Object?> toJson({bool update = false}) => {
        BankAccountFieldsRM.id: id,
        BankAccountFieldsRM.name: name,
        BankAccountFieldsRM.symbol: symbol,
        BankAccountFieldsRM.color: color,
        BankAccountFieldsRM.startingValue: startingValue,
        BankAccountFieldsRM.active: active ? 1 : 0,
        BankAccountFieldsRM.mainAccount: mainAccount ? 1 : 0,
        BaseEntityFields.createdAt: update
            ? createdAt?.toIso8601String()
            : DateTime.now().toIso8601String(),
        BaseEntityFields.updatedAt: DateTime.now().toIso8601String(),
      };
}
