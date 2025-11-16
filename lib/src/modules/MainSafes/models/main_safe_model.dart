class MainSafeModel {
  final String id;
  final String name;            // اسم الخزينه
  final String branch;          // الفرع
  final String openingBalance;  // الرصيد الافتتاحي

  MainSafeModel({
    required this.id,
    required this.name,
    required this.branch,
    required this.openingBalance,
  });
}