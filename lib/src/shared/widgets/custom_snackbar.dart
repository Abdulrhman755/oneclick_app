import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:one_click/src/shared/constants/app_colors.dart';

class CustomSnackbar {
  // إعدادات عامة مشتركة
  static void _show({
    required String title,
    required String message,
    required Color backgroundColor,
    required IconData icon,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM, // ظهور من الأسفل
      backgroundColor: backgroundColor,
      colorText: Colors.white,
      borderRadius: 16,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      icon: Icon(icon, color: Colors.white, size: 28),
      shouldIconPulse: true,
      duration: const Duration(seconds: 3),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
      titleText: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.white,
          fontFamily: 'Calibri',
        ),
      ),
      messageText: Text(
        message,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.white,
          fontFamily: 'Calibri',
        ),
      ),
    );
  }

  // 1. رسالة نجاح (أخضر)
  static void showSuccess(String message) {
    _show(
      title: 'نجاح',
      message: message,
      backgroundColor: const Color(0xFF2E7D32), // أخضر غامق مريح
      icon: Icons.check_circle_outline_rounded,
    );
  }

  // 2. رسالة خطأ (أحمر)
  static void showError(String message) {
    _show(
      title: 'خطأ',
      message: message,
      backgroundColor: const Color(0xFFC62828), // أحمر غامق
      icon: Icons.error_outline_rounded,
    );
  }

  // 3. رسالة تنبيه (برتقالي/أصفر غامق)
  static void showWarning(String message) {
    _show(
      title: 'تنبيه',
      message: message,
      backgroundColor: const Color(0xFFEF6C00), // برتقالي غامق
      icon: Icons.warning_amber_rounded,
    );
  }
}