import 'package:get/get.dart';
import '../controllers/sections_controller.dart';

class SectionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SectionsController>(() => SectionsController());
  }
}