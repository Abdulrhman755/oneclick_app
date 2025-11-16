import 'package:get/get.dart';
import '../models/daily_report_model.dart';

class DailyReportsController extends GetxController {
  // للتحكم في الفلتر
  var isFilterVisible = false.obs;
  void toggleFilterVisibility() => isFilterVisible.toggle();

  // --- (منطق ترقيم الصفحات) ---
  final int itemsPerPage = 10; // (عرض 10 أسطر في كل صفحة)
  var currentPage = 1.obs;

  // (البيانات الكاملة - 30 سطر)
  final List<DailyReportModel> _masterItemsList = List.generate(30, (index) {
    int id = index + 1;
    String cashier = (index % 3 == 0) ? 'zits' : 'test';
    int opening = 1000 + (index * 50);
    int closing = 2000 + (index * 100);
    int actual = (index % 5 == 0) ? closing - 50 : closing; // (لعمل عجز تجريبي)
    int discrepancy = actual - closing;

    return DailyReportModel(
      id: id.toString(),
      startDate: '15/11/2025',
      endDate: '16/11/2025',
      startTime: '12:00 AM',
      endTime: '12:00 AM',
      cashierName: cashier,
      openingAmount: opening.toString(),
      closingAmount: closing.toString(),
      actualAmount: actual.toString(),
      discrepancy: discrepancy.toString(),
    );
  });

  var pagedItems = <DailyReportModel>[].obs;
  late int totalPages;

  @override
  void onInit() {
    super.onInit();
    totalPages = (_masterItemsList.length / itemsPerPage).ceil();
    if (totalPages == 0) totalPages = 1;
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