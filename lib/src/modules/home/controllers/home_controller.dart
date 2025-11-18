import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_click/src/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  // --- 1. (الإصلاح) تعريف ID ثابت ---
  final int navigatorId = 1;
  var isLoading = false.obs;
  var showFullUserName = false.obs;
  var expandedMenuKeys = <String>{}.obs;

  var activeSubMenuRoute = Routes.dashboard.obs;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late ScrollController scrollController;

  // --- 2. (الإصلاح) ربط المفتاح بالـ ID ---
  final GlobalKey<NavigatorState>? navigatorKey = Get.nestedKey(
    1,
  );
  
   // (استخدمنا ID رقم 1)

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  // --- 3. (الإصلاح) دالة التنقل الآمنة (كما اقترحت) ---
  void setActiveSubMenu(String route) {
    activeSubMenuRoute.value = route;

    // 3.1: إغلاق الـ Drawer أولاً (بالطريقة الآمنة)
    try {
      if (scaffoldKey.currentState?.isDrawerOpen ?? false) {
        Navigator.of(scaffoldKey.currentContext!).pop(); // يغلق الـ drawer فقط
      }
    } catch (e) {
      debugPrint("Error closing drawer: $e");
    }

    // 3.2: تجهيز المسار (حذف البادئة /home)
    final String nestedRoute =
        route.startsWith(Routes.home)
            ? route.replaceFirst(Routes.home, '')
            : route;

    // 3.3: تأجيل التنقل
    Future.microtask(() {
      // 3.4: التنقل باستخدام الـ ID
      Get.toNamed(nestedRoute, id: navigatorId); // (استخدام ID رقم 1)
    });
  }

  void toggleMenu(String key) {
    if (expandedMenuKeys.contains(key)) {
      expandedMenuKeys.remove(key);
    } else {
      expandedMenuKeys.add(key);
    }
  }

  void openDrawer() {
    if (scaffoldKey.currentState != null) {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  void scrollToTop() {
    scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token'); // أو prefs.clear() لمسح كل شيء
    Get.offAllNamed(Routes.login);
  }

  void search(String query) {
    debugPrint('Searching for: $query');
  }
}
