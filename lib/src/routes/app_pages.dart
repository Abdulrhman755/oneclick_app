import 'package:get/get.dart';

// (تأكد أن كل هذه المسارات تبدأ بـ .../src/...)
import 'package:one_click/src/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:one_click/src/modules/dashboard/views/dashboard_view.dart';
import 'package:one_click/src/modules/home/bindings/home_binding.dart';
import 'package:one_click/src/modules/home/views/home_view.dart';
import 'package:one_click/src/modules/login/bindings/login_binding.dart';
import 'package:one_click/src/modules/login/views/login_view.dart';
import 'package:one_click/src/modules/units/bindings/units_binding.dart';
import 'package:one_click/src/modules/units/views/units_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.login;

  static final routes = [
    GetPage(
      name: Paths.login, // <-- تم التعديل
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    
    GetPage(
      name: Paths.home, // <-- تم التعديل
      page: () => const HomeView(),
      binding: HomeBinding(),
      // (تم حذف 'children' من هنا لأننا نديرها يدوياً)
    ),
  ];
}