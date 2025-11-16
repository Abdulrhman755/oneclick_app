import 'package:get/get.dart';
import '../controllers/daily_reports_controller.dart';

class DailyReportsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DailyReportsController>(() => DailyReportsController());
  }
}