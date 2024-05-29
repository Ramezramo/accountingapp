import 'package:flutter/material.dart'; // Import the material package for Color
const String categoryTransactionTableRM = 'categoryTransactionRM';

class CategoryTransactionFieldsRM {
  static String id = "id";
  static String name = 'name';
  static String symbol = 'symbol';
  static String color = 'color';
  static String note = 'note';
  static String parent = 'parent';
  static String createdAt = 'CreatedAt';
  static String updatedAt = 'UpdatedAt';

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

class Categorey {
  // ignore: non_constant_identifier_names
  final Object? categoryName;
  final Object? categoryIcon;
  final Object? color;
  Object? id;

  Categorey(
      {required this.id,
     required  this.color,
      required this.categoryName,
      required this.categoryIcon,
   });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category_name': categoryName,
      'category_icon': categoryIcon,
      'color': color.toString()
    };
  }

  @override
  String toString() {
    return '''Categorey{'id': $id,'category_name': '$categoryName', 'category_icon': '$categoryIcon', 'color':${color.toString()}}''';
  }
}
