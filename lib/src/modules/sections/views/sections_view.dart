import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_click/src/shared/constants/app_colors.dart';
import 'package:one_click/src/shared/widgets/content_header.dart';
import 'package:one_click/src/modules/home/controllers/home_controller.dart';
import '../controllers/sections_controller.dart';
import 'package:one_click/src/shared/widgets/table_helpers.dart';
import 'package:one_click/src/shared/widgets/filter_container.dart';
import 'package:one_click/src/shared/widgets/fixed_pagination_bar.dart';

class SectionsView extends GetView<SectionsController> {
  const SectionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            controller: homeController.scrollController,
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 16.0,
                  ),
                  child: ContentHeader(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      _buildPageTitleBar(),
                      const SizedBox(height: 20),
                      _buildFilterArea(),

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
                              child: Obx(() {
                                if (controller.isLoading.value) {
                                  return const Padding(
                                    padding: EdgeInsets.all(32.0),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                                return _buildCustomTable();
                              }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        Obx(
          () =>
              controller.isLoading.value
                  ? const SizedBox.shrink()
                  : FixedPaginationBar(
                    totalPages: controller.totalPages.value,
                    currentPage: controller.currentPage.value,
                    onPageChanged: (page) => controller.changePage(page),
                    onScrollToTop: () => homeController.scrollToTop(),
                  ),
        ),
      ],
    );
  }

  Widget _buildPageTitleBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'الأقسام',
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
            fontFamily: 'Calibri',
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
      onSearchPressed: () {},
      filterFields: [
        const Align(
          alignment: Alignment.centerRight,
          child: Text(
            'اسم القسم',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Calibri',
            ),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          textAlign: TextAlign.right,
          style: const TextStyle(fontFamily: 'Calibri'),
          decoration: InputDecoration(
            hintText: '...ابحث بالاسم',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
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

  Widget _buildCustomTable() {
    const TextStyle headerStyle = TextStyle(
      fontSize: 13.0,
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontFamily: 'Calibri',
    );
    const TextStyle bodyStyle = TextStyle(
      fontSize: 12.0,
      color: Colors.black87,
      fontFamily: 'Calibri',
      fontWeight: FontWeight.bold,
    );
    final Color borderColor = Colors.grey.shade300;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Table(
        columnWidths: const {
          0: FixedColumnWidth(50.0), // #
          1: FixedColumnWidth(150.0), // اسم القسم
          2: FixedColumnWidth(120.0), // الوصف
          3: FixedColumnWidth(120.0), // المنيو
          4: FixedColumnWidth(100.0), // اضافات؟
          5: FixedColumnWidth(100.0), // الفرع
        },
        border: TableBorder.all(color: borderColor, width: 1.0),
        children: [
          TableRow(
            decoration: const BoxDecoration(color: AppColors.primary),
            children: [
              buildHeaderCell('#', headerStyle),
              buildHeaderCell('اسم القسم', headerStyle),
              buildHeaderCell('الوصف', headerStyle),
              buildHeaderCell('المنيو', headerStyle),
              buildHeaderCell('اضافات؟', headerStyle),
              buildHeaderCell('الفرع', headerStyle),
            ],
          ),
          ...controller.pagedItems.map((section) {
            return TableRow(
              decoration: BoxDecoration(
                color:
                    controller.pagedItems.indexOf(section).isEven
                        ? Colors.white
                        : Colors.grey.shade50,
              ),
              children: [
                buildBodyCell(
                  ((controller.currentPage.value - 1) * 20 +
                          controller.pagedItems.indexOf(section) +
                          1)
                      .toString(),
                  bodyStyle,
                ),
                buildBodyCell(section.name, bodyStyle),
                buildBodyCell(section.description, bodyStyle),
                buildBodyCell(section.menuName, bodyStyle),
                buildCheckboxCell(section.isAdditions),
                buildBodyCell(section.branchName, bodyStyle),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }
}
