import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_click/src/routes/app_pages.dart'; // تأكد من تعديل "one_click" لاسم مشروعك إذا اختلف

class LoginController extends GetxController {
  // مفتاح الـ Form للتحقق من الـ validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Controllers لحقول الإدخال
  late TextEditingController phoneController;
  late TextEditingController usernameController;
  late TextEditingController passwordController;

  // متغيرات "مُراقبة" (observable) لتحديث الواجهة تلقائياً
  var isLoading = false.obs;
  var isPasswordHidden = true.obs;
  var rememberMe = false.obs;

  @override
  void onInit() {
    super.onInit();
    // بناءً على الصور التي أرسلتها، سنضع البيانات الافتراضية هنا
    phoneController = TextEditingController(text: '048260236');
    usernameController = TextEditingController(text: '1');
    passwordController = TextEditingController(text: '1');
  }

  // دالة تسجيل الدخول
  Future<void> login() async {
    // التحقق من أن الفورم صحيح (مثلاً الحقول ليست فارغة)
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      isLoading(true); // إظهار علامة التحميل

      // محاكاة لعملية تسجيل الدخول (لأننا لا نتصل بـ API حقيقي الآن)
      await Future.delayed(const Duration(seconds: 1));

      // --- هذا هو منطق التحقق الأساسي ---
      // بناءً على البيانات التي أعطيتني إياها
      if (phoneController.text == '048260236' &&
          usernameController.text == '1' &&
          passwordController.text == '1') {
        
        // نجح تسجيل الدخول: اذهب للشاشة الرئيسية واحذف كل الشاشات السابقة
        Get.offAllNamed(Routes.home);

      } else {
        // فشل تسجيل الدخول
        Get.snackbar(
          'خطأ في تسجيل الدخول',
          'رقم الهاتف أو اسم المستخدم أو كلمة المرور غير صحيحة.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      // للتعامل مع أي أخطاء غير متوقعة
      Get.snackbar('خطأ', 'حدث خطأ ما: $e',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false); // إخفاء علامة التحميل في كل الحالات
    }
  }

  // دالة لتبديل إظهار/إخفاء كلمة المرور
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  @override
  void onClose() {
    // تنظيف الـ controllers عند إغلاق الشاشة لتوفير الذاكرة
    phoneController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}