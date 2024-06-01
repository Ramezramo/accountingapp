import 'package:flutter/material.dart';

import '../../model/ol_fls/base_entity.dart'; // Import the material package for Color
const String categoryTransactionTableRM = 'categoryTransactionRM';

class CategoryTransactionFieldsRM extends BaseEntityFields {
  static String id = "id";
  static String name = 'name';
  static String symbol = 'symbol';
  static String color = 'color';
  static String note = 'note';
  static String parent = 'parent';
  static String createdAt = BaseEntityFields.getCreatedAt;
  static String updatedAt = BaseEntityFields.getUpdatedAt;

  static final List<String> allFields = [
    id,
    name,
    symbol,
    color,
    note,
    parent,
    createdAt,
    updatedAt
  ];
}

class CategoryTransactionRM extends BaseEntity {
  final String name;
  final String symbol;
  final int color;
  final String? note;
  final int? parent;

  const CategoryTransactionRM(
      {int? id,
      required this.name,
      required this.symbol,
      required this.color,
      this.note,
      this.parent,
      DateTime? createdAt,
      DateTime? updatedAt})
      : super(id: id, createdAt: createdAt, updatedAt: updatedAt);

  CategoryTransactionRM copy(
          {int? id,
          String? name,
          String? symbol,
          int? color,
          String? note,
          int? parent,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      CategoryTransactionRM(
          id: id ?? this.id,
          name: name ?? this.name,
          symbol: symbol ?? this.symbol,
          color: color ?? this.color,
          note: note ?? this.note,
          parent: parent ?? this.parent,
          createdAt: createdAt ?? this.createdAt,
          updatedAt: updatedAt ?? this.updatedAt);

  static CategoryTransactionRM fromJson(Map<String, Object?> json) =>
      CategoryTransactionRM(
          id: json[BaseEntityFields.id] as int?,
          name: json[CategoryTransactionFieldsRM.name] as String,
          symbol: json[CategoryTransactionFieldsRM.symbol] as String,
          color: json[CategoryTransactionFieldsRM.color] as int,
          note: json[CategoryTransactionFieldsRM.note] as String?,
          parent: json[CategoryTransactionFieldsRM.parent] as int?,
          createdAt: DateTime.parse(json[BaseEntityFields.createdAt] as String),
          updatedAt:
              DateTime.parse(json[BaseEntityFields.updatedAt] as String));

  Map<String, Object?> toJson({bool update = false}) => {
        BaseEntityFields.id: id,
        CategoryTransactionFieldsRM.name: name,
        CategoryTransactionFieldsRM.symbol: symbol,
        CategoryTransactionFieldsRM.color: color,
        CategoryTransactionFieldsRM.note: note,
        CategoryTransactionFieldsRM.parent: parent,
        BaseEntityFields.createdAt: update
            ? createdAt?.toIso8601String()
            : DateTime.now().toIso8601String(),
        BaseEntityFields.updatedAt: DateTime.now().toIso8601String(),
      };
}