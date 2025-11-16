import 'package:get/get.dart';
import '../models/activity_log_model.dart';

class ActivityLogController extends GetxController {
  // للتحكم في الفلتر
  var isFilterVisible = false.obs;
  void toggleFilterVisibility() => isFilterVisible.toggle();

  // --- (منطق ترقيم الصفحات) ---
  final int itemsPerPage = 10; // (عرض 10 أسطر في كل صفحة)
  var currentPage = 1.obs;

  // (البيانات الكاملة - 30 سطر)
  final List<ActivityLogModel> _masterItemsList = List.generate(30, (index) {
    int id = index + 1;
    String cashier = (index % 3 == 0) ? 'zits' : 'test';
    String screen = (index % 2 == 0) ? 'الوحدات' : 'الأصناف';
    String command = (index % 2 == 0) ? 'اضافه' : 'تعديل';

    return ActivityLogModel(
      screenName: screen,
      command: command,
      date: '16/11/2025',
      time: '12:${(id < 10 ? '0' : '')}$id PM',
      description: '$cashier $command item $id',
      username: cashier,
    );
  });

  var pagedItems = <ActivityLogModel>[].obs;
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