import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../shared/services/api_service.dart';
import '../../../routes/app_pages.dart';
import '../../auth/models/auth_model.dart';
// استيراد السناك بار المخصص
import '../../../shared/widgets/custom_snackbar.dart';

class LoginController extends GetxController {
  final TextEditingController companyPhoneController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  var isLoading = false.obs;
  var isPasswordHidden = true.obs;
  final ApiService _apiService = ApiService();

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  Future<void> login() async {
    // 1. التحقق
    if (companyPhoneController.text.isEmpty || 
        usernameController.text.isEmpty || 
        passwordController.text.isEmpty) {
      CustomSnackbar.showWarning('الرجاء إدخال جميع البيانات المطلوبة');
      return;
    }

    try {
      isLoading.value = true;

      // 2. الاتصال بالسيرفر
      final response = await _apiService.login(
        companyPhoneController.text.trim(),
        usernameController.text.trim(),
        passwordController.text.trim(),
      );

      // 3. النجاح
      if (response.statusCode == 200) {
        // تحويل البيانات
        final authData = AuthModel.fromJson(response.data);
        
        // --- (مهم جداً) حفظ التوكن ---
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', authData.token);
        
        // طباعة للتأكد من الحفظ
        print("Success! Token Saved: ${authData.token}");

        CustomSnackbar.showSuccess('تم تسجيل الدخول بنجاح');
        Get.offAllNamed(Routes.home);
      }
    } on DioException catch (e) {
      // 4. معالجة الأخطاء
      if (e.response?.statusCode == 401) {
        CustomSnackbar.showError('بيانات الدخول غير صحيحة');
      } else if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout) {
        CustomSnackbar.showError('انتهت مهلة الاتصال، تأكد من الإنترنت');
      } else {
        String errorMessage = e.response?.data?.toString() ?? 'حدث خطأ غير معروف';
        CustomSnackbar.showError(errorMessage);
      }
    } catch (e) {
      CustomSnackbar.showError('حدث خطأ: $e');
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