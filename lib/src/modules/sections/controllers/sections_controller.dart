import 'package:get/get.dart';
import '../models/section_model.dart';

class SectionsController extends GetxController {
  var isFilterVisible = false.obs;
  void toggleFilterVisibility() => isFilterVisible.toggle();

  // --- (جديد) منطق ترقيم الصفحات ---
  final int itemsPerPage = 2;
  var currentPage = 1.obs;

  final List<SectionModel> _masterSectionsList = [
    SectionModel(
      id: '1',
      name: 'شاورما',
      description: 'قسم الشاورما',
      isAdditionsSection: false, 
      menu: 'المنيو الرئيسية',
      branch: 'فرع 1',
    ),
    SectionModel(
      id: '2',
      name: 'بيتزا',
      description: 'قسم البيتزا',
      isAdditionsSection: true, 
      menu: 'المنيو الرئيسية',
      branch: 'فرع 1',
    ),
    // (بيانات إضافية للتجربة)
     SectionModel(
      id: '3',
      name: 'مشروبات',
      description: 'قسم المشروبات',
      isAdditionsSection: true, 
      menu: 'المنيو الرئيسية',
      branch: 'فرع 1',
    ),
  ];

  var pagedItems = <SectionModel>[].obs;
  late int totalPages;

  @override
  void onInit() {
    super.onInit();
    totalPages = (_masterSectionsList.length / itemsPerPage).ceil();
    changePage(1);
  }

  void changePage(int pageIndex) {
    currentPage.value = pageIndex;
    int startIndex = (pageIndex - 1) * itemsPerPage;
    int endIndex = (startIndex + itemsPerPage);
    
    if (endIndex > _masterSectionsList.length) {
      endIndex = _masterSectionsList.length;
    }
    pagedItems.assignAll(
      _masterSectionsList.sublist(startIndex, endIndex),
    );
  }
}