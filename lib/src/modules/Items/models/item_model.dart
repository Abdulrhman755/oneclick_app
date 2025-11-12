class ItemModel {
  final String id;
  final String name;              // اسم الصنف
  final String section;           // القسم
  final String unit;              // الوحدة
  final String sellPrice;         // سعر البيع
  final String cost;              // تكلفة الصنف
  final bool taxIncluded;         // شامل الضريبة؟
  final bool showInHome;          // يظهر في الرئيسية؟
  final String branch;            // الفرع

  ItemModel({
    required this.id,
    required this.name,
    required this.section,
    required this.unit,
    required this.sellPrice,
    required this.cost,
    required this.taxIncluded,
    required this.showInHome,
    required this.branch,
  });
}