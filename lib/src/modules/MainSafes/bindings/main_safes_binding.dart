import 'package:get/get.dart';
import '../controllers/main_safes_controller.dart';

class MainSafesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainSafesController>(() => MainSafesController());
  }
}