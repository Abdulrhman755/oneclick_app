import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../shared/services/api_service.dart';
import '../../../routes/app_pages.dart';
import '../../auth/models/auth_model.dart';

class LoginController extends GetxController {
  // نصوص الإدخال
  final TextEditingController companyPhoneController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  var isLoading = false.obs;
  final ApiService _apiService = ApiService();

  var isPasswordHidden = true.obs;
 
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  Future<void> login() async {
    // التحقق من الحقول الثلاثة
    if (companyPhoneController.text.isEmpty || 
        usernameController.text.isEmpty || 
        passwordController.text.isEmpty) {
      Get.snackbar('تنبيه', 'الرجاء إدخال جميع البيانات المطلوبة',
          backgroundColor: Colors.orange, colorText: Colors.white);
      return;
    }

    try {
      isLoading.value = true;
      // استدعاء الـ API بالبيانات الثلاثة
      final response = await _apiService.login(
        companyPhoneController.text.trim(),
        usernameController.text.trim(),
        passwordController.text.trim(),
      );

      if (response.statusCode == 200) {
        final authData = AuthModel.fromJson(response.data);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', authData.token);

        Get.snackbar('نجاح', 'تم تسجيل الدخول بنجاح',
            backgroundColor: Colors.green, colorText: Colors.white);
        Get.offAllNamed(Routes.home);
      }
    } on DioException catch (e) {
      String errorMessage = 'حدث خطأ غير معروف';
      if (e.response != null) {
        errorMessage = e.response?.data.toString() ?? 'بيانات الدخول غير صحيحة';
      } else {
        errorMessage = 'تأكد من الاتصال بالإنترنت أو السيرفر';
      }
      Get.snackbar('خطأ', errorMessage,
          backgroundColor: Colors.red, colorText: Colors.white);
    } catch (e) {
      Get.snackbar('خطأ', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  
  @override
  void onClose() {
    companyPhoneController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}