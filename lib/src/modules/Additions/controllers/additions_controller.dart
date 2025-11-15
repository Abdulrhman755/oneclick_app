import 'package:get/get.dart';
import '../models/addition_model.dart';

class AdditionsController extends GetxController {
  var isFilterVisible = false.obs;
  void toggleFilterVisibility() => isFilterVisible.toggle();

  // --- (جديد) منطق ترقيم الصفحات ---
  final int itemsPerPage = 2;
  var currentPage = 1.obs;

  final List<AdditionModel> _masterAdditionsList = [
    AdditionModel(id: '1', name: 'كاتشب', price: '5', isPrimary: true),
    AdditionModel(id: '2', name: 'مايونيز', price: '5', isPrimary: true),
    AdditionModel(id: '3', name: 'باربكيو', price: '7', isPrimary: false),
    AdditionModel(id: '4', name: 'جبنة', price: '10', isPrimary: false),
  ];

  var pagedItems = <AdditionModel>[].obs;
  late int totalPages;

  @override
  void onInit() {
    super.onInit();
    totalPages = (_masterAdditionsList.length / itemsPerPage).ceil();
    changePage(1);
  }

  void changePage(int pageIndex) {
    currentPage.value = pageIndex;
    int startIndex = (pageIndex - 1) * itemsPerPage;
    int endIndex = (startIndex + itemsPerPage);
    
    if (endIndex > _masterAdditionsList.length) {
      endIndex = _masterAdditionsList.length;
    }
    pagedItems.assignAll(
      _masterAdditionsList.sublist(startIndex, endIndex),
    );
  }
}