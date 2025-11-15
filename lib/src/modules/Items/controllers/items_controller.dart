import 'package:get/get.dart';
import '../models/item_model.dart';

class ItemsController extends GetxController {
  // للتحكم في الفلتر
  var isFilterVisible = false.obs;
  void toggleFilterVisibility() => isFilterVisible.toggle();

  // --- (منطق ترقيم الصفحات) ---
  final int itemsPerPage = 2; // (للتجربة) 
  var currentPage = 1.obs;

  // (البيانات الكاملة من الصورة)
  final List<ItemModel> _masterItemsList = [
    ItemModel(
      id: '1',
      name: 'شاورما فراخ',
      sellPrice: '50',
      sellUnit: 'ساندوتش',
      sectionName: 'شاورما',
      menu: 'المنيو الرئيسية',
    ),
    ItemModel(
      id: '2',
      name: 'شاورما لحمة',
      sellPrice: '60',
      sellUnit: 'ساندوتش',
      sectionName: 'شاورما',
      menu: 'المنيو الرئيسية',
    ),
    // (بيانات إضافية للتجربة)
    ItemModel(
      id: '3',
      name: 'بيتزا مارجريتا',
      sellPrice: '80',
      sellUnit: 'وسط',
      sectionName: 'بيتزا',
      menu: 'المنيو الرئيسية',
    ),
  ];

  var pagedItems = <ItemModel>[].obs;
  late int totalPages;

  @override
  void onInit() {
    super.onInit();
    totalPages = (_masterItemsList.length / itemsPerPage).ceil();
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