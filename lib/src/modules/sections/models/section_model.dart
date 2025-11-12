class SectionModel {
  final String id;
  final String name;                // اسم القسم
  final String description;         // الوصف
  final bool isAdditionsSection;  // قسم اضافات؟
  final String menu;                // المنيو
  final String branch;              // الفرع

  SectionModel({
    required this.id,
    required this.name,
    required this.description,
    required this.isAdditionsSection,
    required this.menu,
    required this.branch,
  });
}