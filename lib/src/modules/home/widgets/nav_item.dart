import 'package:flutter/material.dart';
// (تأكد أن المسار صحيح)
import 'package:one_click/src/shared/constants/app_colors.dart';

class NavItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final IconData? arrowIcon;
  final VoidCallback onTap;
  final bool isSelected;
  final bool isLogoutButton;

  const NavItem({
    super.key,
    required this.text,
    required this.icon,
    this.arrowIcon,
    required this.onTap,
    this.isSelected = false,
    this.isLogoutButton = false,
  });

  @override
  Widget build(BuildContext context) {
    
    // --- (الإصلاح) إرجاع منطق الألوان القديم ---
    final Color itemColor;
    final Color textColor;
    final Color? tileColor;
    final Color? hoverColor;

    if (isSelected) {
      itemColor = Colors.white; // أيقونة بيضاء
      textColor = Colors.white; // نص أبيض
      tileColor = AppColors.primary; // خلفية زرقاء
      hoverColor = AppColors.primary;
    } else if (isLogoutButton) {
      itemColor = Colors.red.shade700; // أيقونة حمراء
      textColor = Colors.red.shade700; // نص أحمر
      tileColor = Colors.transparent;
      hoverColor = Colors.red[50];
    } else {
      itemColor = AppColors.primary; // أيقونة زرقاء
      textColor = AppColors.primary; // نص أزرق
      tileColor = Colors.transparent; // خلفية بيضاء (شفافة للكونتينر الأب)
      hoverColor = Colors.grey[100];
    }
    // --- --- --- --- ---

    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: tileColor, // تطبيق الخلفية
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        onTap: onTap,
        hoverColor: hoverColor,
        splashColor: hoverColor,
        horizontalTitleGap: 8,
        leading: Icon(
          icon,
          color: itemColor,
        ),
        title: Text(
          text,
          textAlign: TextAlign.right,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold, // (دائماً Bold كما في الصورة)
          ),
        ),
        trailing: arrowIcon != null 
          ? Icon(arrowIcon, color: itemColor, size: 24)
          : null,
      ),
    );
  }
}