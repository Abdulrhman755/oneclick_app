class SectionModel {
  final String id;
  final String name;          // category_name
  final String description;   // category_description
  final String menuName;      // MenuName
  final bool isAdditions;     // Is_Additions
  final String branchName;    // BranchName

  SectionModel({
    required this.id,
    required this.name,
    required this.description,
    required this.menuName,
    required this.isAdditions,
    required this.branchName,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      id: json['Id']?.toString() ?? '',
      name: json['category_name'] ?? '',
      description: json['category_description'] ?? '---',
      menuName: json['MenuName'] ?? '',
      isAdditions: json['Is_Additions'] ?? false,
      branchName: json['BranchName'] ?? '',
    );
  }
}