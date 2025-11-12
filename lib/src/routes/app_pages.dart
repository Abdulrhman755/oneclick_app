import 'package:get/get.dart';
// import 'package:one_click/src/modules/Additions/bindings/additions_binding.dart';
// import 'package:one_click/src/modules/Additions/views/additions_view.dart';
// import 'package:one_click/src/modules/dashboard/bindings/dashboard_binding.dart';
// import 'package:one_click/src/modules/dashboard/views/dashboard_view.dart';
import 'package:one_click/src/modules/home/bindings/home_binding.dart';
import 'package:one_click/src/modules/home/views/home_view.dart';
import 'package:one_click/src/modules/login/bindings/login_binding.dart';
import 'package:one_click/src/modules/login/views/login_view.dart';
// import 'package:one_click/src/modules/units/bindings/units_binding.dart';
// import 'package:one_click/src/modules/units/views/units_view.dart';
// import 'package:one_click/src/modules/menus/bindings/menus_binding.dart';
// import 'package:one_click/src/modules/menus/views/menus_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.login;

  static final routes = [
    GetPage(
      name: Paths.login, // المسار: /login
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),

    GetPage(
      name: Paths.home, // المسار: /home
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),

    // GetPage(
    //   name: Routes.dashboard, // 
    //   page: () => const DashboardView(),
    //   binding: DashboardBinding(),
    // ),

    // GetPage(
    //   name: Routes.units, 
    //   page: () => const UnitsView(),
    //   binding: UnitsBinding(),
    // ),
    // GetPage(
    //   name: Routes.menus, 
    //   page: () => const MenusView(),
    //   binding: MenusBinding(),
    // ),
    // GetPage(
    //   name: Routes.additions, 
    //   page: () => const AdditionsView(),
    //   binding: AdditionsBinding(),
    // ),
  ];
}
