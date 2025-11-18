class ApiResponse<T> {
  final int pageNumber;
  final int pageSize;
  final int totalCounts;
  final int totalPages;
  final String tableName;
  final List<T> data;

  ApiResponse({
    required this.pageNumber,
    required this.pageSize,
    required this.totalCounts,
    required this.totalPages,
    required this.tableName,
    required this.data,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return ApiResponse(
      pageNumber: json['PageNumber'] ?? 1,
      pageSize: json['PageSize'] ?? 20,
      totalCounts: json['TotalCounts'] ?? 0,
      totalPages: json['TotalPages'] ?? 1,
      tableName: json['TableName'] ?? '',
      data: (json['Data'] as List<dynamic>?)
              ?.map((e) => fromJsonT(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}