import 'package:get/get.dart';
import '../models/section_model.dart';

class SectionsController extends GetxController {
  // للتحكم في الفلتر
  var isFilterVisible = false.obs;
  void toggleFilterVisibility() => isFilterVisible.toggle();

  // البيانات من الصورة
  final sections = <SectionModel>[
    SectionModel(
      id: '1',
      name: 'شاورما',
      description: 'قسم الشاورما',
      isAdditionsSection: false, // (الـ Checkbox غير مُعلّم)
      menu: 'المنيو الرئيسية',
      branch: 'فرع 1',
    ),
    SectionModel(
      id: '2',
      name: 'بيتزا',
      description: 'قسم البيتزا',
      isAdditionsSection: true, // (الـ Checkbox مُعلّم)
      menu: 'المنيو الرئيسية',
      branch: 'فرع 1',
    ),
  ].obs;
}