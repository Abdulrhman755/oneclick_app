// import 'package:flutter/material.dart';
class UnitModel {
  final String id;
  final String name;
  final String baseUnitName;
  final double quantity; // (baseUnitQuantity -> quantity)
  final bool isBaseUnit;

  UnitModel({
    required this.id,
    required this.name,
    required this.baseUnitName,
    required this.quantity,
    required this.isBaseUnit,
  });
}