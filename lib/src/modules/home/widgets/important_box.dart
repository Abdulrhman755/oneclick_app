import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImportantBox extends StatelessWidget {
  const ImportantBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.4,
      padding: const EdgeInsets.all(1.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.green.shade300, width: 1.5), 
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black12, 
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          'هام!',
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 20, 
            fontWeight: FontWeight.bold, 
            color: Colors.green.shade800,
          ),
        ),
      ),
    );
  }
}