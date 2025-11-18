import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api_constants.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  // دالة لجلب التوكن (النسخة النظيفة)
  Future<Options> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload(); // ضمان تحديث البيانات
    
    final token = prefs.getString('token') ?? '';
    
    // طباعة للتأكد فقط (ممكن تحذفها بعدين)
    print("✅ Token being sent: $token"); 

    return Options(
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
  }

  Future<Response> get(String endpoint, {Map<String, dynamic>? queryParameters}) async {
    try {
      final options = await _getHeaders();
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      // استثناء اللوجين لأنه لا يحتاج توكن
      if (endpoint == ApiConstants.login) {
         return await _dio.post(endpoint, data: data);
      }

      final options = await _getHeaders();
      final response = await _dio.post(
        endpoint,
        data: data,
        options: options,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> login(String companyPhone, String username, String password) async {
    try {
      final response = await _dio.post(
        ApiConstants.login,
        data: {
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