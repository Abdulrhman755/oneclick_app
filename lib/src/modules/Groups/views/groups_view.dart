import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_click/src/shared/constants/app_colors.dart';
import 'package:one_click/src/shared/widgets/content_header.dart';
import 'package:one_click/src/modules/home/controllers/home_controller.dart';
import '../controllers/groups_controller.dart';

// --- (جديد) استيراد الملفات الجديدة ---
import 'package:one_click/src/shared/widgets/table_helpers.dart';
import 'package:one_click/src/shared/widgets/filter_container.dart';
// (تم حذف filter_field_row)

class GroupsView extends GetView<GroupsController> {
  const GroupsView({super.key});

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

  // دالة العنوان (كما هي)
  Widget _buildPageTitleBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'المجموعات',
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
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

  // --- 🌟 (تم التصحيح) دالة الفلتر (فوق بعض + محاذاة يمين) 🌟 ---
  Widget _buildFilterArea() {
    return FilterContainer(
      isVisible: controller.isFilterVisible,
      onSearchPressed: () {
        /* TODO: Apply filter */
      },

      // (FilterContainer سيقوم بعمل محاذاة لليمين لهذه العناصر)
      filterFields: [
        Align(
          alignment: Alignment.centerRight,
          child: const Text(
            'اسم المجموعه',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            hintText: '...ابحث بالاسم',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 8, // (تصغير الحقل)
            ),
            isDense: true,
          ),
        ),
      ],
    );
  }

  // (باقي الدوال كما هي)
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
        columnWidths: const {
          0: FixedColumnWidth(50.0),
          1: FixedColumnWidth(100.0),
          2: FixedColumnWidth(100.0),
          3: FixedColumnWidth(140.0),
          4: FixedColumnWidth(100.0),
        },
        border: TableBorder.all(color: borderColor, width: 1.0),
        children: [
          TableRow(
            decoration: const BoxDecoration(color: AppColors.primary),
            children: [
              buildHeaderCell('#', headerStyle),
              buildHeaderCell('اسم المجموعه', headerStyle),
              buildHeaderCell('اسم الطابعه', headerStyle),
              buildHeaderCell('رقم شاشة المطبخ', headerStyle),
              buildHeaderCell('عدد الأقسام', headerStyle),
            ],
          ),

          ...controller.pagedItems.map((group) {
            return TableRow(
              decoration: BoxDecoration(
                color:
                    controller.pagedItems.indexOf(group).isEven
                        ? Colors.white
                        : Colors.grey.shade50,
              ),
              children: [
                buildBodyCell(group.id, bodyStyle),
                buildBodyCell(group.name, bodyStyle),
                buildBodyCell(group.printerName, bodyStyle),
                buildBodyCell(group.kitchenScreenNumber, bodyStyle),
                buildBodyCell(group.sectionCount, bodyStyle),
              ],
            );
          }),
        ],
      ),
    );
  }

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
