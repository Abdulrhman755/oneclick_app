import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterContainer extends StatelessWidget {
  final RxBool isVisible;
  final VoidCallback onSearchPressed;
  final List<Widget> filterFields;

  const FilterContainer({
    super.key,
    required this.isVisible,
    required this.onSearchPressed,
    required this.filterFields,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Visibility(
        visible: isVisible.value,
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // 1. عرض الحقول الخاصة بالصفحة
              ...filterFields,

              // 2. عرض زر البحث الموحد
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton.icon(
                  onPressed: onSearchPressed,
                  icon: const Icon(Icons.search, color: Colors.white),
                  label: const Text('بحث'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[600],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 12,
                    ),
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}