import 'package:get/get.dart';
import '../controllers/additions_controller.dart';

class AdditionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdditionsController>(() => AdditionsController());
  }
}