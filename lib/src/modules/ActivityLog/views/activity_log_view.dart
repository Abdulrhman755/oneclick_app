import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_click/src/shared/constants/app_colors.dart';
import 'package:one_click/src/shared/widgets/content_header.dart';
import 'package:one_click/src/modules/home/controllers/home_controller.dart'; 
import '../controllers/activity_log_controller.dart';
import 'package:one_click/src/shared/widgets/table_helpers.dart';
import 'package:one_click/src/shared/widgets/filter_container.dart';

class ActivityLogView extends GetView<ActivityLogController> {
  const ActivityLogView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();

    return SingleChildScrollView(
      controller: homeController.scrollController,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: ContentHeader(),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                _buildPageTitleBar(),
                const SizedBox(height: 20),
                _buildFilterArea(), // (الدالة المُصححة)
                Container(
                  width: double.infinity,
                  clipBehavior: Clip.antiAlias, 
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0), 
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Obx(() => _buildCustomTable()), 
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Obx(() => _buildPaginationControls()),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageTitleBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'سجل النشاطات', // <-- (تم التعديل)
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Calibri',
            color: AppColors.primary,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            controller.toggleFilterVisibility();
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(12),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
          ),
          child: const Icon(Icons.filter_list, size: 20),
        ),
      ],
    );
  }

 
  Widget _buildFilterArea() {
    return FilterContainer(
      isVisible: controller.isFilterVisible,
      onSearchPressed: () { /* TODO: Apply filter */ },
      filterFields: [
        // --- الفلتر الأول: التاريخ (من - إلى) ---
        Align(
          alignment: Alignment.centerRight,
          child: const Text(
            'التاريخ',
            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Calibri'),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Text('من', style: TextStyle(fontFamily: 'Calibri', fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            Expanded(
              child: TextFormField(
                textAlign: TextAlign.center,
                readOnly: true, // (لفتح قائمة التاريخ)
                style: const TextStyle(fontFamily: 'Calibri'),
                decoration: InputDecoration(
                  hintText: '16/11/2025',
                  suffixIcon: Icon(Icons.calendar_today_outlined, size: 18),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  isDense: true,
                ),
                onTap: () { /* TODO: Show Date Picker */ },
              ),
            ),
            const SizedBox(width: 8),
            const Text('الى', style: TextStyle(fontFamily: 'Calibri', fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            Expanded(
              child: TextFormField(
                textAlign: TextAlign.center,
                readOnly: true, // (لفتح قائمة التاريخ)
                style: const TextStyle(fontFamily: 'Calibri'),
                decoration: InputDecoration(
                  hintText: '16/11/2025',
                  suffixIcon: Icon(Icons.calendar_today_outlined, size: 18),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  isDense: true,
                ),
                onTap: () { /* TODO: Show Date Picker */ },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16), // (فاصل)

        // --- الفلتر الثاني: إسم المستخدم ---
        Align(
          alignment: Alignment.centerRight,
          child: const Text(
            'إسم المستخدم',
            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Calibri'),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          textAlign: TextAlign.right,
          style: const TextStyle(fontFamily: 'Calibri'),
          decoration: InputDecoration(
            hintText: '...اختر إسم المستخدم', // (يفترض أن تكون Dropdown لاحقاً)
            hintStyle: const TextStyle(fontFamily: 'Calibri'),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 8,
            ),
            isDense: true,
          ),
        ),
      ],
    );
  }

  // --- (تم التعديل) دالة بناء الجدول ---
  Widget _buildCustomTable() {
    const TextStyle headerStyle = TextStyle(
      fontSize: 14.0, 
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontFamily: 'Calibri',
    );
    const TextStyle bodyStyle = TextStyle(
      fontSize: 14.0, 
      color: Colors.black87,
      fontFamily: 'Calibri',
      fontWeight: FontWeight.bold, 
    );
    final Color borderColor = Colors.grey.shade300;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Table(
        // (6 أعمدة)
        columnWidths: const {
          0: FixedColumnWidth(100.0), // اسم الشاشة
          1: FixedColumnWidth(80.0),  // الأمر
          2: FixedColumnWidth(100.0), // التاريخ
          3: FixedColumnWidth(90.0),  // الوقت
          4: FixedColumnWidth(150.0), // الوصف
          5: FixedColumnWidth(100.0), // إسم المستخدم
        },
        border: TableBorder.all(color: borderColor, width: 1.0),
        children: [
          // (العناوين الجديدة بالحرف)
          TableRow(
            decoration: const BoxDecoration(color: AppColors.primary),
            children: [
              buildHeaderCell('اسم الشاشة', headerStyle),
              buildHeaderCell('الأمر', headerStyle),
              buildHeaderCell('التاريخ', headerStyle),
              buildHeaderCell('الوقت', headerStyle),
              buildHeaderCell('الوصف', headerStyle),
              buildHeaderCell('إسم المستخدم', headerStyle),
            ],
          ),
          
          ...controller.pagedItems.map((item) {
            return TableRow(
              decoration: BoxDecoration(
                color: controller.pagedItems.indexOf(item).isEven
                    ? Colors.white
                    : Colors.grey.shade50, 
              ),
              children: [
                buildBodyCell(item.screenName, bodyStyle),
                buildBodyCell(item.command, bodyStyle),
                buildBodyCell(item.date, bodyStyle),
                buildBodyCell(item.time, bodyStyle),
                buildBodyCell(item.description, bodyStyle), 
                buildBodyCell(item.username, bodyStyle),
              ],
            );
          }),
        ],
      ),
    );
  }

  // (دالة الترقيم كما هي)
  Widget _buildPaginationControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildPageButton(
          onTap: () => controller.changePage(1),
          child: const Text('الأول'),
        ),
        const SizedBox(width: 8),
        ...List.generate(controller.totalPages, (index) {
          final pageNum = index + 1;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: buildPageButton(
              isSelected: controller.currentPage.value == pageNum,
              onTap: () => controller.changePage(pageNum),
              child: Text('$pageNum'),
            ),
          );
        }),
        const SizedBox(width: 8),
        buildPageButton(
          onTap: () => controller.changePage(controller.totalPages),
          child: const Text('الأخير'),
        ),
      ],
    );
  }
}