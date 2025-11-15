class ItemModel {
  final String id;
  final String name;        // اسم المنتج
  final String sellPrice;   // سعر البيع
  final String sellUnit;    // وحده البيع
  final String sectionName; // اسم القسم
  final String menu;        // المنيو

  ItemModel({
    required this.id,
    required this.name,
    required this.sellPrice,
    required this.sellUnit,
    required this.sectionName,
    required this.menu,
  });
}