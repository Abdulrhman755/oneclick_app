import 'package:get/get.dart';
import '../models/addition_model.dart';

class AdditionsController extends GetxController {
  // البيانات من الصورة + الاضافة الجديدة "جبنة"
  final additions = <AdditionModel>[
    AdditionModel(id: '1', name: 'كاتشب', price: '5', isPrimary: false),
    AdditionModel(id: '2', name: 'مايونيز', price: '5', isPrimary: false),
    AdditionModel(id: '3', name: 'باربكيو', price: '7', isPrimary: false),
    AdditionModel(id: '4', name: 'جبنة', price: '10', isPrimary: true), // <-- الإضافة المطلوبة
  ].obs;

  // للتحكم في الفلتر (بنفس نهج شاشة المنيوهات)
  var isFilterVisible = false.obs;
  void toggleFilterVisibility() => isFilterVisible.toggle();
}