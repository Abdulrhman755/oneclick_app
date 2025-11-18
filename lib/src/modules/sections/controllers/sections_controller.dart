import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/services/api_service.dart';
import '../../../shared/models/api_response.dart';
import '../../../shared/constants/api_constants.dart';
import '../models/section_model.dart';

class SectionsController extends GetxController {
  var isFilterVisible = false.obs;
  void toggleFilterVisibility() => isFilterVisible.toggle();

  var isLoading = false.obs;
  var pagedItems = <SectionModel>[].obs;
  
  var currentPage = 1.obs;
  var totalPages = 1.obs;
  var totalCounts = 0.obs;
  final int pageSize = 20;

  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    fetchSections(1);
  }

  Future<void> fetchSections(int pageNumber) async {
    isLoading.value = true;
    try {
      final response = await _apiService.get(
        ApiConstants.sections, 
        queryParameters: {
          'PageNumber': pageNumber,
          'PageSize': pageSize,
        },
      );

      final apiResponse = ApiResponse<SectionModel>.fromJson(
        response.data,
        (json) => SectionModel.fromJson(json),
      );

      pagedItems.assignAll(apiResponse.data);
      currentPage.value = apiResponse.pageNumber;
      totalPages.value = apiResponse.totalPages;
      totalCounts.value = apiResponse.totalCounts;

    } catch (e) {
      Get.snackbar(
        'خطأ',
        'فشل تحميل الأقسام: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void changePage(int pageIndex) {
    if (pageIndex >= 1 && pageIndex <= totalPages.value) {
      fetchSections(pageIndex);
    }
  }
}