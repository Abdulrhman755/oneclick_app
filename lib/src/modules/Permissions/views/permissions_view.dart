import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_click/src/shared/constants/app_colors.dart';
import 'package:one_click/src/shared/widgets/content_header.dart';
import 'package:one_click/src/modules/home/controllers/home_controller.dart'; 
import '../controllers/permissions_controller.dart'; // <-- (تم التغيير)
import 'package:one_click/src/shared/widgets/table_helpers.dart';
import 'package:one_click/src/shared/widgets/filter_container.dart';

class PermissionsView extends GetView<PermissionsController> { // <-- (تم التغيير)
  const PermissionsView({super.key});

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
          'صلاحيات المستخدمين', // <-- (تم التعديل)
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
        // --- الفلتر الأول: إسم المستخدم ---
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
        const SizedBox(height: 16), // (فاصل)

        // --- الفلتر الثاني: إسم المجموعة ---
        Align(
          alignment: Alignment.centerRight,
          child: const Text(
            'إسم المجموعة',
            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Calibri'),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          textAlign: TextAlign.right,
          style: const TextStyle(fontFamily: 'Calibri'),
          decoration: InputDecoration(
            hintText: '...اختر إسم المجموعة', // (يفترض أن تكون Dropdown لاحقاً)
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
        // (5 أعمدة)
        columnWidths: const {
          0: FixedColumnWidth(100.0), // إسم المستخدم
          1: FixedColumnWidth(100.0), // إسم المجموعة
          2: FixedColumnWidth(80.0),  // كود الإذن
          3: FixedColumnWidth(120.0), // اسم الإذن
          4: FixedColumnWidth(80.0),  // مسموح به
        },
        border: TableBorder.all(color: borderColor, width: 1.0),
        children: [
          // (العناوين الجديدة بالحرف)
          TableRow(
            decoration: const BoxDecoration(color: AppColors.primary),
            children: [
              buildHeaderCell('إسم المستخدم', headerStyle),
              buildHeaderCell('إسم المجموعة', headerStyle),
              buildHeaderCell('كود الإذن', headerStyle),
              buildHeaderCell('اسم الإذن', headerStyle),
              buildHeaderCell('مسموح به', headerStyle),
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
                buildBodyCell(item.username, bodyStyle),
                buildBodyCell(item.groupName, bodyStyle),
                buildBodyCell(item.permissionCode, bodyStyle),
                buildBodyCell(item.permissionName, bodyStyle),
                buildCheckboxCell(item.isAllowed), 
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