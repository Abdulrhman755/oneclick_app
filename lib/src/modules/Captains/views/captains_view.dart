import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_click/src/shared/constants/app_colors.dart';
import 'package:one_click/src/shared/widgets/content_header.dart';
import 'package:one_click/src/modules/home/controllers/home_controller.dart'; 
import '../controllers/captains_controller.dart'; // <-- (تم التغيير)

// --- استيراد الملفات الجديدة ---
import 'package:one_click/src/shared/widgets/table_helpers.dart';
import 'package:one_click/src/shared/widgets/filter_container.dart';

class CaptainsView extends GetView<CaptainsController> { // <-- (تم التغيير)
  const CaptainsView({super.key});

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
          'كابتن الصاله', // <-- (تم التعديل)
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
        // --- الفلتر الأول: رقم كابتن الصاله (من - إلى) ---
        Align(
          alignment: Alignment.centerRight,
          child: const Text(
            'رقم كابتن الصاله',
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

        // --- الفلتر الثاني: رقم الهاتف ---
        Align(
          alignment: Alignment.centerRight,
          child: const Text(
            'رقم الهاتف',
            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Calibri'),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          textAlign: TextAlign.right,
          style: const TextStyle(fontFamily: 'Calibri'),
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            hintText: '...ابحث برقم الهاتف',
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
        // (8 أعمدة)
        columnWidths: const {
          0: FixedColumnWidth(40.0),   // #
          1: FixedColumnWidth(100.0), // اسم الكابتن
          2: FixedColumnWidth(100.0), // تيليفون 1
          3: FixedColumnWidth(100.0), // تيليفون 2
          4: FixedColumnWidth(100.0), // عنوان
          5: FixedColumnWidth(100.0), // تاريخ الميلاد
          6: FixedColumnWidth(80.0),  // ظهور
          7: FixedColumnWidth(80.0),  // افتراضي
        },
        border: TableBorder.all(color: borderColor, width: 1.0),
        children: [
          // (العناوين الجديدة بالحرف)
          TableRow(
            decoration: const BoxDecoration(color: AppColors.primary),
            children: [
              buildHeaderCell('#', headerStyle),
              buildHeaderCell('اسم الكابتن', headerStyle),
              buildHeaderCell('تيليفون 1', headerStyle),
              buildHeaderCell('تيليفون 2', headerStyle),
              buildHeaderCell('عنوان', headerStyle),
              buildHeaderCell('تاريخ الميلاد', headerStyle),
              buildHeaderCell('ظهور', headerStyle),
              buildHeaderCell('افتراضي', headerStyle),
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
                buildBodyCell(item.name, bodyStyle),
                buildBodyCell(item.phone1, bodyStyle),
                buildBodyCell(item.phone2, bodyStyle),
                buildBodyCell(item.address, bodyStyle),
                buildBodyCell(item.birthDate, bodyStyle),
                buildCheckboxCell(item.isVisible),
                buildCheckboxCell(item.isDefault),
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