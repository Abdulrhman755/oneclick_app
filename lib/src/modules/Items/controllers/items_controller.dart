import 'package:get/get.dart';
import '../models/item_model.dart';

class ItemsController extends GetxController {
  // للتحكم في الفلتر
  var isFilterVisible = false.obs;
  void toggleFilterVisibility() => isFilterVisible.toggle();

  // --- (جديد) منطق ترقيم الصفحات ---
  final int itemsPerPage = 2; // (نعرض صنفين فقط في كل صفحة للتجربة)
  var currentPage = 1.obs;

  // (قائمة بكل البيانات من الصور الثلاث)
  final List<ItemModel> _masterItemsList = [
    // (بيانات صفحة 1 -)
    ItemModel(
      id: '1',
      name: 'شاورما فراخ',
      section: 'شاورما',
      unit: 'ساندوتش',
      sellPrice: '50',
      cost: '25',
      taxIncluded: true,
      showInHome: true,
      branch: 'فرع 1',
    ),
    ItemModel(
      id: '2',
      name: 'شاورما لحمة',
      section: 'شاورما',
      unit: 'ساندوتش',
      sellPrice: '60',
      cost: '30',
      taxIncluded: false,
      showInHome: true,
      branch: 'فرع 1',
    ),
    // (بيانات صفحة 2 -)
    ItemModel(
      id: '3',
      name: 'بيتزا مارجريتا',
      section: 'بيتزا',
      unit: 'وسط',
      sellPrice: '80',
      cost: '40',
      taxIncluded: true,
      showInHome: true,
      branch: 'فرع 1',
    ),
    ItemModel(
      id: '4',
      name: 'بيتزا خضروات',
      section: 'بيتزا',
      unit: 'وسط',
      sellPrice: '90',
      cost: '45',
      taxIncluded: false,
      showInHome: false,
      branch: 'فرع 1',
    ),
    // (بيانات صفحة 3 -)
    ItemModel(
      id: '5',
      name: 'بيبسي',
      section: 'مشروبات',
      unit: 'علبة',
      sellPrice: '15',
      cost: '7',
      taxIncluded: true,
      showInHome: false,
      branch: 'فرع 1',
    ),
  ];

  // (القائمة التي ستعرض في الجدول)
  var pagedItems = <ItemModel>[].obs;

  // (حساب إجمالي عدد الصفحات)
  late int totalPages;

  @override
  void onInit() {
    super.onInit();
    totalPages = (_masterItemsList.length / itemsPerPage).ceil();
    changePage(1); // تحميل الصفحة الأولى عند البداية
  }

  // (دالة تغيير الصفحة)
  void changePage(int pageIndex) {
    currentPage.value = pageIndex;
    int startIndex = (pageIndex - 1) * itemsPerPage;
    int endIndex = (startIndex + itemsPerPage);
    
    // (لضمان عدم تخطي حدود القائمة)
    if (endIndex > _masterItemsList.length) {
      endIndex = _masterItemsList.length;
    }

    // (تحديث القائمة المعروضة)
    pagedItems.assignAll(
      _masterItemsList.sublist(startIndex, endIndex),
    );
  }
}