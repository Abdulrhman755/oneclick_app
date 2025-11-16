part of 'app_pages.dart';

abstract class Routes {
  static const login = Paths.login; 
  static const home = Paths.home; 
  
  static const dashboard = Paths.home + Paths.dashboard; 
  static const units = Paths.home + Paths.units;
  static const menus = Paths.home + Paths.menus;
  static const additions = Paths.home + Paths.additions; 
  static const sections = Paths.home + Paths.sections;
  static const items = Paths.home + Paths.items;
  static const groups = Paths.home + Paths.groups; 
  static const materialSections = Paths.home + Paths.materialSections;
  static const materials = Paths.home + Paths.materials;
  static const users = Paths.home + Paths.users;
  static const permissions = Paths.home + Paths.permissions;
  static const drivers = Paths.home + Paths.drivers;
  static const captains = Paths.home + Paths.captains;
  static const halls = Paths.home + Paths.halls;
  static const tables = Paths.home + Paths.tables;
  static const sizes = Paths.home + Paths.sizes;
  static const deliveryZones = Paths.home + Paths.deliveryZones;
  static const mainSafes = Paths.home + Paths.mainSafes;
  static const dailyReports = Paths.home + Paths.dailyReports;
  static const activityLog = Paths.home + Paths.activityLog;
  
  // (سنضيف باقي المسارات هنا)
}


abstract class Paths {
  static const login = '/login';
  static const home = '/home'; 
  
  static const dashboard = '/dashboard';
  static const units = '/units';
  static const menus = '/menus';
  static const additions = '/additions';
  static const sections = '/sections';
  static const items = '/items';
  static const groups = '/groups';
  static const materialSections = '/material-sections';
  static const materials = '/materials';
  static const users = '/users';
  static const permissions = '/permissions';
  static const drivers = '/drivers';
  static const captains = '/captains';
  static const halls = '/halls';
  static const tables = '/tables';
  static const sizes = '/sizes';
  static const deliveryZones = '/delivery-zones';
  static const mainSafes = '/main-safes';
  static const dailyReports = '/daily-reports';
  static const activityLog = '/activity-log';
}