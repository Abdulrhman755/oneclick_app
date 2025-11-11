import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // هنا نقوم بـ "حقن" الـ controller ليكون جاهزاً للاستخدام
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
  }
}