import 'package:flutter/material.dart'; // Import the material package for Color

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
