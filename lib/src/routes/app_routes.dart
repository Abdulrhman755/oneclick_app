part of 'app_pages.dart';

abstract class Routes {
  static const login = Paths.login; // <-- تم التعديل
  
  static const home = Paths.home; // <-- تم التعديل
  
  static const dashboard = Paths.home + Paths.dashboard; // <-- تم التعديل
  static const units = Paths.home + Paths.units; // <-- تم التعديل
  
  // (سنضيف باقي المسارات هنا)
}

// --- (الإصلاح) تم تغيير الاسم من _Paths إلى Paths ---
abstract class Paths {
  static const login = '/login';
  static const home = '/home'; 
  
  static const dashboard = '/dashboard';
  static const units = '/units';
}