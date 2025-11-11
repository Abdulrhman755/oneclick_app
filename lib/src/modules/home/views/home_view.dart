import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_click/src/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:one_click/src/modules/home/controllers/home_controller.dart';
import 'package:one_click/src/modules/units/bindings/units_binding.dart';
import 'package:one_click/src/routes/app_pages.dart'; 
import 'package:one_click/src/shared/constants/app_colors.dart';
import 'package:one_click/src/modules/home/widgets/side_navigation_bar.dart';
import 'package:one_click/src/modules/dashboard/views/dashboard_view.dart';
import 'package:one_click/src/modules/units/views/units_view.dart';
// import 'package:one_click/src/routes/app_routes.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      // --- 1. (جديد) إزالة التعتيم عند فتح القائمة ---
      drawerScrimColor: Colors.transparent, 
      
      // --- 2. (تعديل) تغيير الخلفية الافتراضية ---
      backgroundColor: Colors.blue.shade50, // لون بداية التدرج
      
      drawer: SideNavigationBar(),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.scrollToTop(); 
        },
        backgroundColor: AppColors.primary, 
        child: const Icon(Icons.arrow_upward, color: Colors.white),
      ),
      
      body: SafeArea(
        // --- 3. (جديد) إضافة كونتينر للتدرج اللوني ---
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade50, Colors.white], // سماوي إلى أبيض
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
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
                
                default:
                  return GetPageRoute(
                    page: () => Center(child: Text('Page not found: ${settings.name}')),
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}