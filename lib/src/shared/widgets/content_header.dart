import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_click/src/modules/home/controllers/home_controller.dart';
import 'package:one_click/src/shared/constants/app_colors.dart';

class ContentHeader extends StatelessWidget {
  const ContentHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    return Row(
      // (تعديل) المحاذاة لليمين
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // --- 1. (تعديل) زر القائمة (الهمبرجر) ---
        Container(
          decoration: BoxDecoration(
            color: AppColors.primary, // خلفية زرقاء
            borderRadius: BorderRadius.circular(12), // حواف دائرية
          ),
          child: IconButton(
            icon: const Icon(Icons.menu, color: Colors.white), // أيقونة بيضاء
            onPressed: () { 
              controller.openDrawer();
            }, 
          ),
        ),
        const SizedBox(width: 16),
        
        // --- 2. (تعديل) شريط البحث ---
        Expanded(
          child: TextField(
            onSubmitted: (query) => controller.search(query),
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              hintText: 'بحث',
              hintStyle: TextStyle(color: Colors.grey.shade500),
              // (تم تغيير الأيقونة)
              prefixIcon: const Icon(Icons.search, color: AppColors.primary), 
              
              // (تصميم الحواف البيضاء)
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none, // بدون حواف
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(color: AppColors.primary, width: 2),
              ),
              filled: true,
              fillColor: Colors.white, // خلفية بيضاء
              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            ),
          ),
        ),
        const SizedBox(width: 16),

        // --- 3. (تعديل) صورة البروفايل (بدون اسم) ---
        Obx(() => InkWell(
              onTap: () {
                controller.showFullUserName.toggle();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage('assets/images/person.png'),
                  ),
                  const SizedBox(width: 8),
                  // (تم حذف النص من هنا)
                  Icon(
                    controller.showFullUserName.value ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, 
                    color: AppColors.primary, 
                  ),
                ],
              ),
            )),
      ],
    );
  }
}