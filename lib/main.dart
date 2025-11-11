import 'package:flutter/material.dart';
import 'package:get/get.dart';
// (تأكد أن هذا المسار صحيح عندك)
import 'package:one_click/src/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "One Click",
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        fontFamily: 'Cairo',

        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,

        // 3. (اختياري) لضمان أن العناوين تأخذ الفونت أيضاً
        textTheme: const TextTheme(
          headlineSmall: TextStyle(fontFamily: 'Cairo'),
          headlineMedium: TextStyle(fontFamily: 'Cairo'),
          headlineLarge: TextStyle(fontFamily: 'Cairo'),
          bodySmall: TextStyle(fontFamily: 'Cairo'),
          bodyMedium: TextStyle(fontFamily: 'Cairo'),
          bodyLarge: TextStyle(fontFamily: 'Cairo'),
          titleSmall: TextStyle(fontFamily: 'Cairo'),
          titleMedium: TextStyle(fontFamily: 'Cairo'),
          titleLarge: TextStyle(fontFamily: 'Cairo'),
        ),
      ),

      locale: const Locale('ar', 'EG'),
      fallbackLocale: const Locale('en', 'US'),
    ),
  );
}
