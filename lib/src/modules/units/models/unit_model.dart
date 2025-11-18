class UnitModel {
  final String name;
  final String parentUnitId;
  final String parentUnitName;
  final double quantityFromParent;
  final bool isMainUnit;

  UnitModel({
    required this.name,
    required this.parentUnitId,
    required this.parentUnitName,
    required this.quantityFromParent,
    required this.isMainUnit,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      name: json['Name'] ?? '',
      // تحويل الـ ID لنص حتى لو كان null
      parentUnitId: json['ParentUnitId']?.toString() ?? '', 
      parentUnitName: json['ParentUnitName'] ?? '---',
      // تحويل آمن للأرقام
      quantityFromParent: (json['QuantityFromParent'] ?? 1).toDouble(),
      isMainUnit: json['IsMainUnit'] ?? false,
    );
  }
}