import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart'; // (1) استيراد مهم
import 'package:one_click/src/routes/app_pages.dart';
import 'package:one_click/src/shared/constants/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  final String initialRoute =
      (token != null && token.isNotEmpty) ? Routes.home : Routes.login;

  runApp(
    GetMaterialApp(
      title: "One Click",

      initialRoute: initialRoute,

      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        fontFamily: 'Calibri',
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: const TextTheme(
          headlineSmall: TextStyle(fontFamily: 'Calibri'),
          headlineMedium: TextStyle(fontFamily: 'Calibri'),
          headlineLarge: TextStyle(fontFamily: 'Calibri'),
          bodySmall: TextStyle(fontFamily: 'Calibri'),
          bodyMedium: TextStyle(fontFamily: 'Calibri'),
          bodyLarge: TextStyle(fontFamily: 'Calibri'),
          titleSmall: TextStyle(fontFamily: 'Calibri'),
          titleMedium: TextStyle(fontFamily: 'Calibri'),
          titleLarge: TextStyle(fontFamily: 'Calibri'),
        ),
      ),

      locale: const Locale('ar', 'EG'),
      fallbackLocale: const Locale('en', 'US'),
    ),
  );
}
