import 'package:get/get.dart';
// (تأكد أن المسار صحيح)
import 'package:one_click/src/modules/units/models/unit_model.dart';

class UnitsController extends GetxController {

  // --- 1. (جديد) متغير للتحكم في الفلتر ---
  var isFilterVisible = false.obs;

  // --- 2. (جديد) دالة لفتح وإغلاق الفلتر ---
  void toggleFilterVisibility() {
    isFilterVisible.toggle();
  }
  // ----------------------------------------

  // (البيانات التي سنعرضها في الجدول)
  final units = <UnitModel>[
    UnitModel(id: '1', name: 'طن', baseUnitName: 'جرام', quantity: 1000000.00, isBaseUnit: false),
    UnitModel(id: '2', name: 'قطعة', baseUnitName: '---', quantity: 1.00, isBaseUnit: true),
    UnitModel(id: '3', name: 'ساعة', baseUnitName: '---', quantity: 1.00, isBaseUnit: true),
    UnitModel(id: '4', name: 'جرام', baseUnitName: 'جرام', quantity: 1.00, isBaseUnit: true),
    UnitModel(id: '5', name: 'كيلو جرام', baseUnitName: 'جرام', quantity: 1000.00, isBaseUnit: false),
    UnitModel(id: '6', name: 'عدد', baseUnitName: '---', quantity: 1.00, isBaseUnit: true),
  ].obs;
}