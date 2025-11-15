import 'package:get/get.dart';
import '../models/unit_model.dart';

class UnitsController extends GetxController {
  var isFilterVisible = false.obs;
  void toggleFilterVisibility() => isFilterVisible.toggle();

  // --- (جديد) منطق ترقيم الصفحات ---
  final int itemsPerPage = 2;
  var currentPage = 1.obs;

  final List<UnitModel> _masterUnitsList = [
    UnitModel(
      id: '1',
      name: 'قطعة',
      baseUnitName: 'قطعة',
      quantity: 1.0,
      isBaseUnit: true,
    ),
    UnitModel(
      id: '2',
      name: 'علبة',
      baseUnitName: 'قطعة',
      quantity: 10.0,
      isBaseUnit: false,
    ),
  ];

  var pagedItems = <UnitModel>[].obs;
  late int totalPages;

  @override
  void onInit() {
    super.onInit();
    totalPages = (_masterUnitsList.length / itemsPerPage).ceil();
    changePage(1);
  }

  void changePage(int pageIndex) {
    currentPage.value = pageIndex;
    int startIndex = (pageIndex - 1) * itemsPerPage;
    int endIndex = (startIndex + itemsPerPage);
    
    if (endIndex > _masterUnitsList.length) {
      endIndex = _masterUnitsList.length;
    }
    pagedItems.assignAll(
      _masterUnitsList.sublist(startIndex, endIndex),
    );
  }
}