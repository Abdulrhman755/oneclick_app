import 'package:flutter/material.dart';
// استيراد الـ Model
import '../models/nav_item_model.dart';
// --- 1. استيراد المسارات الصحيحة ---
import 'package:one_click/src/routes/app_pages.dart';


class MenuData {
  /// القائمة الكاملة لجميع عناصر القائمة الجانبية
  static final List<NavMenuItemModel> items = [
    // 1. الرئيسية
    NavMenuItemModel(
      title: 'الرئيسية',
      icon: Icons.grid_view_outlined,
      children: [
        NavSubItemModel(title: 'الوحدات', route: Routes.units),
        // --- 2. (تعديل) ربط المنيوهات بالمسار الجديد ---
        NavSubItemModel(title: 'المنيوهات', route: Routes.menus), 
        NavSubItemModel(title: 'الاضافات', route: Routes.additions),
        NavSubItemModel(title: 'الأقسام', route: Routes.sections),
        NavSubItemModel(title: 'الاصناف', route: Routes.items),
        NavSubItemModel(title: 'المجموعات', route: '/groups'),
        NavSubItemModel(title: 'أقسام الخامات', route: '/material-sections'),
        NavSubItemModel(title: 'الخامات', route: '/materials'),
        NavSubItemModel(title: 'المستخدمين', route: '/users'),
        NavSubItemModel(title: 'الصلاحيات', route: '/permissions'),
        NavSubItemModel(title: 'الطيارين', route: '/drivers'),
        NavSubItemModel(title: 'كابتن الصالة', route: '/captains'),
        NavSubItemModel(title: 'الصالات', route: '/halls'),
        NavSubItemModel(title: 'الطاولات', route: '/tables'),
        NavSubItemModel(title: 'الأحجام/المقاسات', route: '/sizes'),
        NavSubItemModel(title: 'مناطق التوصيل', route: '/delivery-zones'),
      ],
    ),
    // 2. الحسابات و اليومية
    NavMenuItemModel(
      title: 'الحسابات و اليومية',
      icon: Icons.calculate,
      children: [
        NavSubItemModel(title: 'الخزائن الرئيسيه', route: '/main-safes'),
        NavSubItemModel(title: 'اليوميات', route: '/daily-reports'),
        NavSubItemModel(title: 'سجل النشاطات', route: '/activity-log'),
        NavSubItemModel(title: 'الايرادات والمصروفات', route: '/income-expenses'),
        NavSubItemModel(title: 'حسابات الكابتن', route: '/captain-accounts'),
        NavSubItemModel(title: 'حسابات الطيارين', route: '/driver-accounts'),
        NavSubItemModel(title: 'المستحقات', route: '/dues'),
        NavSubItemModel(title: 'المديونيات', route: '/debts'),
        NavSubItemModel(title: 'ارباح وخسائر', route: '/profit-loss'),
        NavSubItemModel(title: 'السحب والايداع', route: '/transactions'),
        NavSubItemModel(title: 'تقرير الخزينه الشهري', route: '/monthly-safe-report'),
      ],
    ),
    // 3. المبيعات
    NavMenuItemModel(
      title: 'المبيعات',
      icon: Icons.local_atm,
      children: [
        NavSubItemModel(title: 'بحث عن فاتوره', route: '/search-invoice'),
        NavSubItemModel(title: 'الطلبات المحذوفه', route: '/deleted-orders'),
        NavSubItemModel(title: 'حساب الكابتن', route: '/captain-account-sales'),
        NavSubItemModel(title: 'حساب الدليفري', route: '/delivery-account'),
        NavSubItemModel(title: 'تجميع بالخامات', route: '/summary-materials'),
        NavSubItemModel(title: 'تجميع بالاصناف', route: '/summary-items'),
      ],
    ),
    // 4. المشتريات
    NavMenuItemModel(
      title: 'المشتريات',
      icon: Icons.shopping_cart,
      children: [
        NavSubItemModel(title: 'بحث مشتريات', route: '/search-purchases'),
        NavSubItemModel(title: 'تجميع بالاصناف', route: '/summary-items-purchases'),
        NavSubItemModel(title: 'تجميع بالخامات', route: '/summary-materials-purchases'),
      ],
    ),
    // 5. المخازن
    NavMenuItemModel(
      title: 'المخازن',
      icon: Icons.inventory_2_outlined,
      children: [
        NavSubItemModel(title: 'رصيد صنف', route: '/item-balance'),
        NavSubItemModel(title: 'رصيد خامه', route: '/material-balance'),
        NavSubItemModel(title: 'رصيد مخزن', route: '/store-balance'),
        NavSubItemModel(title: 'اوامر التصنيع', route: '/manufacturing-orders'),
        NavSubItemModel(title: 'جرد المخزن', route: '/stocktake'),
        NavSubItemModel(title: 'تسويه الجرد', route: '/stock-settlement'),
        NavSubItemModel(title: 'إذونات صرف', route: '/dispatch-vouchers'),
        NavSubItemModel(title: 'إذونات استلام', route: '/receiving-vouchers'),
        NavSubItemModel(title: 'تحويل مخزني', route: '/store-transfer'),
        NavSubItemModel(title: 'قيمه المخزن', route: '/store-value'),
        NavSubItemModel(title: 'حركه خامه', route: '/material-movement'),
        NavSubItemModel(title: 'حركه صنف', route: '/item-movement'),
      ],
    ),
    // 6. شؤون الموظفين
    NavMenuItemModel(
      title: 'شؤون الموظفين',
      icon: Icons.person_outline,
      children: [
        NavSubItemModel(title: 'الموظفين', route: '/employees'),
        NavSubItemModel(title: 'رواتب الموظفين', route: '/salaries'),
        NavSubItemModel(title: 'السلف', route: '/advances'),
        NavSubItemModel(title: 'السداد', route: '/payments'),
        NavSubItemModel(title: 'استهلاك الموظفين', route: '/employee-consumption'),
        NavSubItemModel(title: 'الحوافز والجزائات', route: '/incentives-penalties'),
        NavSubItemModel(title: 'الحضور والانصراف', route: '/attendance'),
      ],
    ),
    // 7. العملاء
    NavMenuItemModel(
      title: 'العملاء',
      icon: Icons.people_outline,
      children: [
        NavSubItemModel(title: 'بيانات العملاء', route: '/customers-data'),
        NavSubItemModel(title: 'سداد العملاء', route: '/customer-payments'),
        NavSubItemModel(title: 'خصم العملاء', route: '/customer-discounts'),
        NavSubItemModel(title: 'كشف حساب العملاء', route: '/customer-statement'),
        NavSubItemModel(title: 'العملاء الغير نشطين', route: '/inactive-customers'),
        NavSubItemModel(title: 'كشف حساب مجمع', route: '/customer-summary-statement'),
      ],
    ),
    // 8. إدارة الموردين
    NavMenuItemModel(
      title: 'إدارة الموردين',
      icon: Icons.local_shipping_outlined,
      children: [
        NavSubItemModel(title: 'بيانات الموردين', route: '/suppliers-data'),
        NavSubItemModel(title: 'سداد الموردين', route: '/supplier-payments'),
        NavSubItemModel(title: 'كشف حساب مورد', route: '/supplier-statement'),
        NavSubItemModel(title: 'كشف حساب مورد مجمع', route: '/supplier-summary-statement'),
      ],
    ),
    // 9. المصروفات النقدية
    NavMenuItemModel(
      title: 'المصروفات النقدية',
      icon: Icons.receipt_long_outlined,
      children: [
        NavSubItemModel(title: 'قائمة المصروفات', route: '/expenses-list'),
      ],
    ),
  ];
}
