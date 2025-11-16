import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_click/src/shared/constants/app_colors.dart';
import 'package:one_click/src/shared/widgets/content_header.dart';
import 'package:one_click/src/modules/home/controllers/home_controller.dart'; 
import '../controllers/daily_reports_controller.dart'; // <-- (تم التغيير)

// --- استيراد الملفات الجديدة ---
import 'package:one_click/src/shared/widgets/table_helpers.dart';
import 'package:one_click/src/shared/widgets/filter_container.dart';

class DailyReportsView extends GetView<DailyReportsController> { // <-- (تم التغيير)
  const DailyReportsView({super.key});

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
          'اليوميات', // <-- (تم التعديل)
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

  // --- (تم التصحيح) دالة الفلتر ---
  Widget _buildFilterArea() {
    return FilterContainer(
      isVisible: controller.isFilterVisible,
      onSearchPressed: () { /* TODO: Apply filter */ },
      filterFields: [
        // --- الفلتر الأول: رقم اليومية (من - إلى) ---
        Align(
          alignment: Alignment.centerRight,
          child: const Text(
            'رقم اليومية',
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
                keyboardType: TextInputType.number,
                style: const TextStyle(fontFamily: 'Calibri'),
                decoration: InputDecoration(
                  hintText: '0',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  isDense: true,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Text('الى', style: TextStyle(fontFamily: 'Calibri', fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            Expanded(
              child: TextFormField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontFamily: 'Calibri'),
                decoration: InputDecoration(
                  hintText: '0',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  isDense: true,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16), // (فاصل)

        // --- الفلتر الثاني: إسم الكاشير ---
        Align(
          alignment: Alignment.centerRight,
          child: const Text(
            'إسم الكاشير',
            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Calibri'),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          textAlign: TextAlign.right,
          style: const TextStyle(fontFamily: 'Calibri'),
          decoration: InputDecoration(
            hintText: '...اختر إسم الكاشير', // (يفترض أن تكون Dropdown لاحقاً)
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
        // (10 أعمدة)
        columnWidths: const {
          0: FixedColumnWidth(50.0),   // اليوم
          1: FixedColumnWidth(100.0), // تاريخ البدايه
          2: FixedColumnWidth(100.0), // تاريخ النهايه
          3: FixedColumnWidth(90.0),  // وقت البداية
          4: FixedColumnWidth(90.0),  // وقت النهاية
          5: FixedColumnWidth(100.0), // إسم الكاشير
          6: FixedColumnWidth(110.0), // المبلغ الإفتتاحي
          7: FixedColumnWidth(110.0), // المبلغ الختامي
          8: FixedColumnWidth(110.0), // المبلغ الفعلي
          9: FixedColumnWidth(110.0), // العجز او الزيادة
        },
        border: TableBorder.all(color: borderColor, width: 1.0),
        children: [
          // (العناوين الجديدة بالحرف)
          TableRow(
            decoration: const BoxDecoration(color: AppColors.primary),
            children: [
              buildHeaderCell('اليوم', headerStyle),
              buildHeaderCell('تاريخ البدايه', headerStyle),
              buildHeaderCell('تاريخ النهايه', headerStyle),
              buildHeaderCell('وقت البداية', headerStyle),
              buildHeaderCell('وقت النهاية', headerStyle),
              buildHeaderCell('إسم الكاشير', headerStyle),
              buildHeaderCell('المبلغ الإفتتاحي', headerStyle),
              buildHeaderCell('المبلغ الختامي', headerStyle),
              buildHeaderCell('المبلغ الفعلي', headerStyle),
              buildHeaderCell('العجز او الزيادة', headerStyle),
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
                buildBodyCell(item.id, bodyStyle),
                buildBodyCell(item.startDate, bodyStyle),
                buildBodyCell(item.endDate, bodyStyle),
                buildBodyCell(item.startTime, bodyStyle),
                buildBodyCell(item.endTime, bodyStyle), 
                buildBodyCell(item.cashierName, bodyStyle),
                buildBodyCell(item.openingAmount, bodyStyle),
                buildBodyCell(item.closingAmount, bodyStyle),
                buildBodyCell(item.actualAmount, bodyStyle),
                buildBodyCell(item.discrepancy, bodyStyle),
              ],
            );
          }).toList(),
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