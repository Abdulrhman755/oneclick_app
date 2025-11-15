import 'package:get/get.dart';
import '../models/group_model.dart';

class GroupsController extends GetxController {
  // للتحكم في الفلتر
  var isFilterVisible = false.obs;
  void toggleFilterVisibility() => isFilterVisible.toggle();

  // --- (جديد) منطق ترقيم الصفحات ---
  final int itemsPerPage = 2; // (للتجربة)
  var currentPage = 1.obs;

  // (البيانات الكاملة)
  final List<GroupModel> _masterGroupsList = [
    GroupModel(
      id: '1',
      name: 'الحجم',
      printerName: 'printer 1',
      kitchenScreenNumber: '1',
      sectionCount: '1',
    ),
    GroupModel(
      id: '2',
      name: 'الاضافات',
      printerName: 'printer 2',
      kitchenScreenNumber: '2',
      sectionCount: '2',
    ),
    // (بيانات إضافية للتجربة)
    GroupModel(
      id: '3',
      name: 'المشروبات',
      printerName: 'printer 1',
      kitchenScreenNumber: '1',
      sectionCount: '3',
    ),
  ];

  // (القائمة التي ستعرض في الجدول)
  var pagedItems = <GroupModel>[].obs;

  // (حساب إجمالي عدد الصفحات)
  late int totalPages;

  @override
  void onInit() {
    super.onInit();
    totalPages = (_masterGroupsList.length / itemsPerPage).ceil();
    changePage(1); // تحميل الصفحة الأولى
  }

  // (دالة تغيير الصفحة)
  void changePage(int pageIndex) {
    currentPage.value = pageIndex;
    int startIndex = (pageIndex - 1) * itemsPerPage;
    int endIndex = (startIndex + itemsPerPage);
    
    if (endIndex > _masterGroupsList.length) {
      endIndex = _masterGroupsList.length;
    }

    pagedItems.assignAll(
      _masterGroupsList.sublist(startIndex, endIndex),
    );
  }
}