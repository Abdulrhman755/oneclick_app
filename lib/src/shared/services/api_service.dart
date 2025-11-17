import 'package:dio/dio.dart';

class ApiService {
  // 1. تحديث رابط السيرفر الجديد
  static const String baseUrl = 'http://192.168.1.150:959'; 

  final Dio _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      'Content-Type': 'application/json',
      'Accept': '*/*',
    },
  ));

  // دالة تسجيل الدخول (تم إضافة companyPhone)
  Future<Response> login(String companyPhone, String username, String password) async {
    try {
      final response = await _dio.post(
        '/api/Auth/Login',
        data: {
          // البيانات حسب الـ curl command بالحرف
          "CompanyPhone": companyPhone,
          "Username": username,
          "Password": password,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}