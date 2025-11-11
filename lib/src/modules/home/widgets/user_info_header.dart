import 'package:flutter/material.dart';

class UserInfoHeader extends StatelessWidget {
  const UserInfoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'محمد أحمد محمد محسن',
              // --- (الإصلاح) إرجاع اللون الأسود ---
              style: const TextStyle(
                color: Colors.black, 
                fontWeight: FontWeight.bold
              ),
            ),
            Text(
              'Zahran',
              // --- (الإصلاح) إرجاع اللون الرمادي ---
              style: TextStyle(color: Colors.grey[600]), 
            ),
            Text(
              '2025-11-10', 
              // --- (الإصلاح) إرجاع اللون الرمادي ---
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
        const SizedBox(width: 10),
        CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage('assets/images/person.png'),
        ),
      ],
    );
  }
}