class ActivityLogModel {
  final String screenName;    // اسم الشاشة
  final String command;       // الأمر
  final String date;          // التاريخ
  final String time;          // الوقت
  final String description;   // الوصف
  final String username;      // إسم المستخدم

  ActivityLogModel({
    required this.screenName,
    required this.command,
    required this.date,
    required this.time,
    required this.description,
    required this.username,
  });
}