class DailyReportModel {
  final String id;              // اليوم (رقم اليومية)
  final String startDate;       // تاريخ البدايه
  final String endDate;         // تاريخ النهايه
  final String startTime;       // وقت البداية
  final String endTime;         // وقت النهاية
  final String cashierName;     // إسم الكاشير
  final String openingAmount;   // المبلغ الإفتتاحي
  final String closingAmount;   // المبلغ الختامي
  final String actualAmount;    // المبلغ الفعلي
  final String discrepancy;     // العجز او الزيادة

  DailyReportModel({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.cashierName,
    required this.openingAmount,
    required this.closingAmount,
    required this.actualAmount,
    required this.discrepancy,
  });
}