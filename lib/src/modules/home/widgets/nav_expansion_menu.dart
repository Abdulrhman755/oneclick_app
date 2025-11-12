import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_click/src/modules/home/controllers/home_controller.dart';
import 'package:one_click/src/shared/constants/app_colors.dart';

class NavExpansionMenu extends GetView<HomeController> {
  final String text;
  final IconData icon;
  final List<NavSubMenuItem> children;

  const NavExpansionMenu({
    super.key,
    required this.text,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final bool isExpanded = controller.expandedMenuKeys.contains(text);
      final bool hasActiveChild = children.any(
        (child) => controller.activeSubMenuRoute.value == child.route,
      );

      // --- (الإصلاح) إرجاع منطق الألوان القديم ---
      final bool isHeaderActive = isExpanded || hasActiveChild;

      final Color headerBackgroundColor =
          isHeaderActive
              ? AppColors.primary
              : Colors.white; // خلفية زرقاء عند الفتح
      final Color textColor =
          isHeaderActive
              ? Colors.white
              : AppColors.primary; // نص أبيض عند الفتح
      final Color iconColor =
          isHeaderActive
              ? Colors.white
              : AppColors.primary; // أيقونة بيضاء عند الفتح

      return Container(
        margin: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border:
              isHeaderActive ? null : Border.all(color: Colors.grey.shade300),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Container(
              color: headerBackgroundColor,
              child: ListTile(
                onTap: () {
                  controller.toggleMenu(text);
                },
                hoverColor: isHeaderActive ? null : Colors.grey[100],
                splashColor: isHeaderActive ? null : Colors.grey[200],
                horizontalTitleGap: 8,
                leading: Icon(icon, color: iconColor),
                title: Text(
                  text,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: AnimatedRotation(
                  turns: isExpanded ? 0.5 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: iconColor,
                    size: 24,
                  ),
                ),
              ),
            ),

            Visibility(
              visible: isExpanded,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.only(right: 30.0),
                child: Column(children: children),
              ),
            ),
          ],
        ),
      );
    });
  }
}

// (ويدجت العناصر الفرعية)
class NavSubMenuItem extends GetView<HomeController> {
  final String text;
  final String route;
  final VoidCallback onTap;

  const NavSubMenuItem({
    super.key,
    required this.text,
    required this.route,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final bool isSelected = controller.activeSubMenuRoute.value == route;

      // --- (الإصلاح) إرجاع منطق الألوان القديم ---
      final Color itemColor = isSelected ? Colors.white : AppColors.primary;
      final Color tileColor = isSelected ? AppColors.primary : Colors.white;

      return Container(
        margin: const EdgeInsets.only(top: 1.0, bottom: 1.0),
        decoration: BoxDecoration(
          color: tileColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          onTap: onTap,
          dense: true,
          title: Text(
            text,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: itemColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      );
    });
  }
}
