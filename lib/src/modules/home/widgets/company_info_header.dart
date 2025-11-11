import 'package:flutter/material.dart';

class CompanyInfoHeader extends StatelessWidget {
  const CompanyInfoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text(
          'شركة زهران للبرمجيات\nوالأنظمة المتقدمة',
          textAlign: TextAlign.right,
          // --- (الإصلاح) إرجاع اللون الأسود ---
          style: TextStyle(
            color: Colors.black, 
            fontWeight: FontWeight.bold, 
            fontSize: 16
          ),
        ),
        const SizedBox(width: 10),
        Image.asset('assets/images/logo.png', width: 40, height: 40), 
      ],
    );
  }
}