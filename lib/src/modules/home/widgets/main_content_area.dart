import 'package:flutter/material.dart';
import 'package:get/get.dart';
// --- 1. استيراد ملف الألوان الجديد ---
import 'package:one_click/src/shared/constants/app_colors.dart';
import 'package:one_click/src/modules/home/controllers/home_controller.dart';
import 'important_box.dart'; 

class MainContentArea extends GetView<HomeController> {
  const MainContentArea({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller.scrollController, 
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () { 
                    controller.openDrawer();
                  }, 
                ),
              ),
              const SizedBox(width: 16),
              
              Expanded(
                child: TextField(
                  onSubmitted: (query) => controller.search(query),
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: 'بحث',
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    prefixIcon: const Icon(Icons.search), 
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      // --- 2. تحديث لون الفوكس ---
                      borderSide: const BorderSide(color: AppColors.primary, width: 2),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage('assets/images/person.png'),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    controller.showFullUserName.value 
                        ? 'محمد أحمد محمد محسن - Zahran'
                        : 'محمد أحمد...',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  InkWell(
                    onTap: () {
                      controller.showFullUserName.toggle();
                    },
                    child: Icon(
                      controller.showFullUserName.value ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, 
                      // --- 3. تحديث لون السهم ---
                      color: AppColors.primary, 
                    ),
                  ),
                ],
              )),
            ],
          ),
          const SizedBox(height: 24),

          Align(
            alignment: Alignment.centerRight,
            child: const ImportantBox(), 
          ),
        ],
      ),
    );
  }
}