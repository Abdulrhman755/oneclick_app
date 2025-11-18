import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_click/src/shared/constants/api_constants.dart';
import '../../../shared/services/api_service.dart';
import '../../../shared/models/api_response.dart'; // المودل العام
import '../models/unit_model.dart';

class UnitsController extends GetxController {
  var isFilterVisible = false.obs;
  void toggleFilterVisibility() => isFilterVisible.toggle();

  // متغيرات التحميل والبيانات
  var isLoading = false.obs;
  var pagedItems = <UnitModel>[].obs;
  
  // متغيرات الترقيم (تأتي من السيرفر)
  var currentPage = 1.obs;
  var totalPages = 1.obs;
  var totalCounts = 0.obs;
  final int pageSize = 20; // كما هو في الـ JSON الخاص بك

  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    fetchUnits(1); // تحميل الصفحة الأولى
  }

  Future<void> fetchUnits(int pageNumber) async {
    isLoading.value = true;
    try {
      // 1. طلب البيانات من السيرفر (تأكد من الرابط الصحيح للوحدات)
      // افترضت أن الرابط هو /api/Units حسب ملف JSON، عدله لو مختلف
      final response = await _apiService.get(
        ApiConstants.units, 
        queryParameters: {
          'PageNumber': pageNumber,
          'PageSize': pageSize,
        },
      );

      // 2. تحويل الرد باستخدام المودل العام
      final apiResponse = ApiResponse<UnitModel>.fromJson(
        response.data,
        (json) => UnitModel.fromJson(json),
      );

      // 3. تحديث البيانات في الكنترولر
      pagedItems.assignAll(apiResponse.data);
      currentPage.value = apiResponse.pageNumber;
      totalPages.value = apiResponse.totalPages;
      totalCounts.value = apiResponse.totalCounts;

    } catch (e) {
      Get.snackbar(
        'خطأ',
        'فشل تحميل الوحدات: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // دالة تغيير الصفحة (تستدعي الـ API)
  void changePage(int pageIndex) {
    if (pageIndex >= 1 && pageIndex <= totalPages.value) {
      fetchUnits(pageIndex);
    }
  }
}