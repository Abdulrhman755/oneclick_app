import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_click/src/modules/ActivityLog/bindings/activity_log_binding.dart';
import 'package:one_click/src/modules/ActivityLog/views/activity_log_view.dart';
import 'package:one_click/src/modules/Additions/bindings/additions_binding.dart';
import 'package:one_click/src/modules/Additions/views/additions_view.dart';
import 'package:one_click/src/modules/Captains/bindings/captains_binding.dart';
import 'package:one_click/src/modules/Captains/views/captains_view.dart';
import 'package:one_click/src/modules/DailyReports/bindings/daily_reports_binding.dart';
import 'package:one_click/src/modules/DailyReports/views/daily_reports_view.dart';
import 'package:one_click/src/modules/DeliveryZones/bindings/delivery_zones_binding.dart';
import 'package:one_click/src/modules/DeliveryZones/views/delivery_zones_view.dart';
import 'package:one_click/src/modules/Drivers/bindings/drivers_binding.dart';
import 'package:one_click/src/modules/Drivers/views/drivers_view.dart';
import 'package:one_click/src/modules/Groups/bindings/groups_binding.dart';
import 'package:one_click/src/modules/Groups/views/groups_view.dart';
import 'package:one_click/src/modules/Halls/bindings/halls_binding.dart';
import 'package:one_click/src/modules/Halls/views/halls_view.dart';
import 'package:one_click/src/modules/Items/bindings/items_binding.dart';
import 'package:one_click/src/modules/Items/views/items_view.dart';
import 'package:one_click/src/modules/MainSafes/bindings/main_safes_binding.dart';
import 'package:one_click/src/modules/MainSafes/views/main_safes_view.dart';
import 'package:one_click/src/modules/MaterialSections/bindings/material_sections_binding.dart';
import 'package:one_click/src/modules/MaterialSections/views/material_sections_view.dart';
import 'package:one_click/src/modules/Materials/bindings/materials_binding.dart';
import 'package:one_click/src/modules/Materials/views/materials_view.dart';
import 'package:one_click/src/modules/Permissions/bindings/permissions_binding.dart';
import 'package:one_click/src/modules/Permissions/views/permissions_view.dart';
import 'package:one_click/src/modules/Sizes/bindings/sizes_binding.dart';
import 'package:one_click/src/modules/Sizes/views/sizes_view.dart';
import 'package:one_click/src/modules/Tables/bindings/tables_binding.dart';
import 'package:one_click/src/modules/Tables/views/tables_view.dart';
import 'package:one_click/src/modules/Users/bindings/users_binding.dart';
import 'package:one_click/src/modules/Users/views/users_view.dart';
import 'package:one_click/src/modules/sections/bindings/sections_binding.dart';
import 'package:one_click/src/modules/sections/views/sections_view.dart';
import 'package:one_click/src/modules/home/controllers/home_controller.dart';
import 'package:one_click/src/routes/app_pages.dart';
import 'package:one_click/src/shared/constants/app_colors.dart';
import 'package:one_click/src/modules/home/widgets/side_navigation_bar.dart';
import 'package:one_click/src/modules/dashboard/views/dashboard_view.dart';
import 'package:one_click/src/modules/units/views/units_view.dart';
import 'package:one_click/src/modules/menus/views/menus_view.dart';
import 'package:one_click/src/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:one_click/src/modules/units/bindings/units_binding.dart';
import 'package:one_click/src/modules/menus/bindings/menus_binding.dart';
// import 'package:one_click/src/routes/app_routes.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: Colors.grey[100],

      drawer: SideNavigationBar(),

      floatingActionButton: Obx(() {
        // إظهار الزر فقط إذا كنا في لوحة التحكم (Dashboard)
        // لأن باقي الصفحات سيكون لها زر خاص في الأسفل
        if (controller.activeSubMenuRoute.value == Routes.dashboard) {
          return FloatingActionButton(
            onPressed: () {
              controller.scrollToTop();
            },
            backgroundColor: AppColors.primary,
            child: const Icon(Icons.arrow_upward, color: Colors.white),
          );
        } else {
          return const SizedBox.shrink(); // إخفاء الزر
        }
      }),
      body: SafeArea(
        child: Navigator(
          key: controller.navigatorKey,
          initialRoute: Paths.dashboard,
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case Paths.dashboard:
                return GetPageRoute(
                  page: () => const DashboardView(),
                  binding: DashboardBinding(),
                );
              case Paths.units:
                return GetPageRoute(
                  page: () => const UnitsView(),
                  binding: UnitsBinding(),
                );

              case Paths.menus:
                return GetPageRoute(
                  page: () => const MenusView(),
                  binding: MenusBinding(),
                );
              case Paths.additions:
                return GetPageRoute(
                  page: () => AdditionsView(),
                  binding: AdditionsBinding(),
                );
              case Paths.sections:
                return GetPageRoute(
                  page: () => SectionsView(),
                  binding: SectionsBinding(),
                );
              case Paths.items:
                return GetPageRoute(
                  page: () => ItemsView(),
                  binding: ItemsBinding(),
                );
              case Paths.groups:
                return GetPageRoute(
                  page: () => GroupsView(),
                  binding: GroupsBinding(),
                );
              case Paths.materialSections:
                return GetPageRoute(
                  page: () => MaterialSectionsView(),
                  binding: MaterialSectionsBinding(),
                );
              case Paths.materials:
                return GetPageRoute(
                  page: () => MaterialsView(),
                  binding: MaterialsBinding(),
                );
              case Paths.users:
                return GetPageRoute(
                  page: () => UsersView(),
                  binding: UsersBinding(),
                );
              case Paths.permissions:
                return GetPageRoute(
                  page: () => PermissionsView(),
                  binding: PermissionsBinding(),
                );
              case Paths.drivers:
                return GetPageRoute(
                  page: () => DriversView(),
                  binding: DriversBinding(),
                );
              case Paths.captains:
                return GetPageRoute(
                  page: () => CaptainsView(),
                  binding: CaptainsBinding(),
                );
              case Paths.halls:
                return GetPageRoute(
                  page: () => HallsView(),
                  binding: HallsBinding(),
                );
              case Paths.tables:
                return GetPageRoute(
                  page: () => TablesView(),
                  binding: TablesBinding(),
                );
              case Paths.sizes:
                return GetPageRoute(
                  page: () => SizesView(),
                  binding: SizesBinding(),
                );
              case Paths.deliveryZones:
                return GetPageRoute(
                  page: () => DeliveryZonesView(),
                  binding: DeliveryZonesBinding(),
                );
              case Paths.mainSafes:
                return GetPageRoute(
                  page: () => MainSafesView(),
                  binding: MainSafesBinding(),
                );
              case Paths.dailyReports:
                return GetPageRoute(
                  page: () => DailyReportsView(),
                  binding: DailyReportsBinding(),
                );
              case Paths.activityLog:
                return GetPageRoute(
                  page: () => ActivityLogView(),
                  binding: ActivityLogBinding(),
                );

              default:
                return GetPageRoute(
                  page:
                      () => Center(
                        child: Text('Page not found: ${settings.name}'),
                      ),
                );
            }
          },
        ),
      ),
    );
  }
}
