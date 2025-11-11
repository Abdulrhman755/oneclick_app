import 'package:flutter/material.dart';

/// يمثل عنصر فرعي داخل قائمة متوسعة
class NavSubItemModel {
  final String title;
  final String route; // المسار الذي سينتقل إليه

  NavSubItemModel({
    required this.title,
    required this.route,
  });
}

/// يمثل عنصر قائمة رئيسي (إما زر عادي أو قائمة متوسعة)
class NavMenuItemModel {
  final String title;
  final IconData icon;
  
  // إذا كانت هذه القائمة لا تحتوي على أطفال، فهي زر عادي
  final List<NavSubItemModel>? children; 
  // إذا كانت تحتوي على مسار، فهي زر عادي
  final String? route;

  NavMenuItemModel({
    required this.title,
    required this.icon,
    this.children,
    this.route,
  });
}