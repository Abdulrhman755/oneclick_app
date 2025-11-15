import 'package:get/get.dart';
import '../models/menu_model.dart';

class MenusController extends GetxController {
  var isFilterVisible = false.obs;
  void toggleFilterVisibility() => isFilterVisible.toggle();

  // --- (جديد) منطق ترقيم الصفحات ---
  final int itemsPerPage = 2;
  var currentPage = 1.obs;

  final List<MenuModel> _masterMenusList = [
    MenuModel(id: '1', name: 'المنيو الرئيسية'),
    // (بيانات إضافية للتجربة)
    MenuModel(id: '2', name: 'منيو المشروبات'),
    MenuModel(id: '3', name: 'منيو الإفطار'),
  ];

  var pagedItems = <MenuModel>[].obs;
  late int totalPages;

  @override
  void onInit() {
    super.onInit();
    totalPages = (_masterMenusList.length / itemsPerPage).ceil();
    changePage(1);
  }

  void changePage(int pageIndex) {
    currentPage.value = pageIndex;
    int startIndex = (pageIndex - 1) * itemsPerPage;
    int endIndex = (startIndex + itemsPerPage);
    
    if (endIndex > _masterMenusList.length) {
      endIndex = _masterMenusList.length;
    }
    pagedItems.assignAll(
      _masterMenusList.sublist(startIndex, endIndex),
    );
  }
}