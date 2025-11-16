import 'package:get/get.dart';
import '../models/main_safe_model.dart';

class MainSafesController extends GetxController {
  // للتحكم في الفلتر
  var isFilterVisible = false.obs;
  void toggleFilterVisibility() => isFilterVisible.toggle();

  // --- (منطق ترقيم الصفحات) ---
  final int itemsPerPage = 2; // (للتجربة) 
  var currentPage = 1.obs;

  // (البيانات الكاملة من الصورة)
  final List<MainSafeModel> _masterItemsList = [
    MainSafeModel(
      id: '1',
      name: 'zits',
      branch: 'فرع 1',
      openingBalance: '1000',
    ),
    MainSafeModel(
      id: '2',
      name: 'test',
      branch: 'فرع 1',
      openingBalance: '2000',
    ),
  ];

  var pagedItems = <MainSafeModel>[].obs;
  late int totalPages;

  @override
  void onInit() {
    super.onInit();
    totalPages = (_masterItemsList.length / itemsPerPage).ceil();
    if (totalPages == 0) totalPages = 1; // (لمنع الخطأ إذا كانت القائمة فارغة)
    changePage(1); 
  }

  void changePage(int pageIndex) {
    currentPage.value = pageIndex;
    int startIndex = (pageIndex - 1) * itemsPerPage;
    int endIndex = (startIndex + itemsPerPage);
    
    if (endIndex > _masterItemsList.length) {
      endIndex = _masterItemsList.length;
    }
    pagedItems.assignAll(
      _masterItemsList.sublist(startIndex, endIndex),
    );
  }
}