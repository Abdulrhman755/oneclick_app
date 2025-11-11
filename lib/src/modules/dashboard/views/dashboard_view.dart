import 'package:flutter/material.dart';
import 'package:get/get.dart';
// --- 1. (جديد) استيراد HomeController ---
import 'package:one_click/src/modules/home/controllers/home_controller.dart';
import 'package:one_click/src/shared/widgets/content_header.dart';
// (تأكد أن هذا المسار صحيح عندك)
import 'package:one_click/src/modules/home/widgets/important_box.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});
  
  @override
  Widget build(BuildContext context) {
    // --- 2. (جديد) العثور على HomeController ---
    final HomeController homeController = Get.find<HomeController>();

    // --- 3. (الإصلاح) تمت إضافة SingleChildScrollView ---
    return SingleChildScrollView(
      // --- 4. (الإصلاح) ربط الـ ScrollController ---
      controller: homeController.scrollController,
      child: Column(
        children: [
          // إضافة Padding حول الهيدر
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: ContentHeader(),
          ),
          const SizedBox(height: 24),
    
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              // إضافة Padding حول الصندوق
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: const ImportantBox(),
            ),
          ),
        ],
      ),
    );
  }
}