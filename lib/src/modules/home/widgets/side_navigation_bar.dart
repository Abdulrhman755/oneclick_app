import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart'; // For debugPrint
import 'package:get/get.dart';
import 'package:one_click/src/modules/home/controllers/home_controller.dart';

// (تأكد أن المسارات صحيحة)
import 'package:one_click/src/modules/home/data/menu_data.dart';
import 'package:one_click/src/modules/home/widgets/company_info_header.dart';
import 'package:one_click/src/modules/home/widgets/nav_expansion_menu.dart';
import 'package:one_click/src/modules/home/widgets/nav_item.dart';
import 'package:one_click/src/modules/home/widgets/user_info_header.dart';
import 'package:one_click/src/routes/app_pages.dart'; // (استيراد Routes)


class SideNavigationBar extends GetView<HomeController> {
  const SideNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // --- (الإصلاح) إرجاع العرض الأصلي ---
      width: 280, 
      backgroundColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 16.0),
        decoration: BoxDecoration(
          color: Colors.white, // <-- الخلفية بيضاء
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // (الكلام سيظهر الآن بعد إصلاح الملفات التالية)
              const SizedBox(height: 10),
              const CompanyInfoHeader(),
              const SizedBox(height: 20),
              const UserInfoHeader(),
              const Divider(height: 30),
              
              NavItem(
                text: 'الصفحة الرئيسية',
                icon: Icons.schedule,
                isSelected: true,
                onTap: () { Get.back(); },
              ),
              
              ...MenuData.items.map((item) {
                if (item.children != null && item.children!.isNotEmpty) {
                  return NavExpansionMenu(
                    text: item.title,
                    icon: item.icon,
                    children: item.children!
                        .map((subItem) => NavSubMenuItem(
                              text: subItem.title,
                              route: subItem.route,
                              onTap: () {
                                controller.setActiveSubMenu(subItem.route);
                              },
                            ))
                        .toList(),
                  );
                } else {
                  return NavItem(
                    text: item.title,
                    icon: item.icon,
                    onTap: () {
                      controller.setActiveSubMenu(item.route ?? Routes.dashboard);
                    },
                  );
                }
              }),

              const Divider(height: 20),

              NavItem(
                text: 'تسجيل الخروج',
                icon: Icons.logout,
                onTap: () { 
                  Get.back(); 
                  controller.logout();
                },
                isLogoutButton: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}