import 'package:flutter/material.dart';
import 'package:one_click/src/shared/constants/app_colors.dart'; //

// --- دوال بناء خلايا الجدول ---

TableCell buildHeaderCell(String text, TextStyle style) {
  return TableCell(
    verticalAlignment: TableCellVerticalAlignment.middle,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: Text(
        text,
        style: style,
        textAlign: TextAlign.center,
      ),
    ),
  );
}

TableCell buildBodyCell(String text, TextStyle style) {
  return TableCell(
    verticalAlignment: TableCellVerticalAlignment.middle,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      child: Text(
        text,
        style: style,
        textAlign: TextAlign.center,
      ),
    ),
  );
}

TableCell buildCheckboxCell(bool value) {
  return TableCell(
    verticalAlignment: TableCellVerticalAlignment.middle,
    child: Center(
      child: Checkbox(
        fillColor: WidgetStateProperty.all(AppColors.primary),
        value: value,
        onChanged: (val) {}, // (معطل حالياً)
      ),
    ),
  );
}

// --- ويدجت زر ترقيم الصفحات ---

Widget buildPageButton({
  required Widget child,
  required VoidCallback onTap,
  bool isSelected = false,
}) {
  return Material(
    color: isSelected ? AppColors.primary : Colors.grey[200],
    borderRadius: BorderRadius.circular(8),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: DefaultTextStyle(
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
          child: child,
        ),
      ),
    ),
  );
}