import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_click/src/shared/constants/app_colors.dart';
import 'package:one_click/src/shared/widgets/content_header.dart';
import 'package:one_click/src/modules/home/controllers/home_controller.dart';
import '../controllers/units_controller.dart';
import 'package:one_click/src/shared/widgets/table_helpers.dart';
import 'package:one_click/src/shared/widgets/filter_container.dart';
import 'package:one_click/src/shared/widgets/fixed_pagination_bar.dart'; 

class UnitsView extends GetView<UnitsController> {
  const UnitsView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();

    // استخدام Column لتقسيم الشاشة: محتوى + شريط سفلي
    return Column(
      children: [
        // 1. المحتوى القابل للسحب (يأخذ كل المساحة المتاحة)
        Expanded(
          child: SingleChildScrollView(
            controller: homeController.scrollController,
            padding: const EdgeInsets.only(bottom: 20), // مسافة قبل الشريط
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  child: ContentHeader(),
                ),
                // const SizedBox(height: 20), 
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      _buildPageTitleBar(),
                      const SizedBox(height: 20),
                      _buildFilterArea(),
                      
                      // حاوية الجدول
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
                                    child: Center(child: CircularProgressIndicator()),
                                  );
                                }
                                return _buildCustomTable();
                              }),
                            ),
                            // (تم إزالة الترقيم القديم من هنا لأنه سينتقل للأسفل)
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

        // 2. الشريط السفلي الثابت (يظهر فقط عند اكتمال التحميل)
        Obx(() => controller.isLoading.value
            ? const SizedBox.shrink()
            : FixedPaginationBar(
                totalPages: controller.totalPages.value,
                currentPage: controller.currentPage.value,
                onPageChanged: (page) => controller.changePage(page),
                onScrollToTop: () => homeController.scrollToTop(),
              )),
      ],
    );
  }

  Widget _buildPageTitleBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'الوحدات',
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
      onSearchPressed: () {
        // TODO: استدعاء دالة البحث
      },
      filterFields: [
        const Align(
          alignment: Alignment.centerRight,
          child: Text(
            'اسم الوحده',
            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Calibri'),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            hintText: '...ابحث بالاسم',
            hintStyle: const TextStyle(fontFamily: 'Calibri'),
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
          0: FixedColumnWidth(50.0),
          1: FixedColumnWidth(120.0),
          2: FixedColumnWidth(150.0),
          3: FixedColumnWidth(160.0),
          4: FixedColumnWidth(100.0),
        },
        border: TableBorder.all(color: borderColor, width: 1.0),
        children: [
          TableRow(
            decoration: const BoxDecoration(color: AppColors.primary),
            children: [
              buildHeaderCell('#', headerStyle),
              buildHeaderCell('اسم الوحده', headerStyle),
              buildHeaderCell('اسم الوحده الاساسية', headerStyle),
              buildHeaderCell('الكميه من الوحده الاساسية', headerStyle),
              buildHeaderCell('وحده اساسيه ؟', headerStyle),
            ],
          ),
          ...controller.pagedItems.map((unit) {
            String quantity = unit.quantityFromParent.toString();
            if (quantity.endsWith('.0')) {
              quantity = quantity.substring(0, quantity.length - 2);
            }

            return TableRow(
              decoration: BoxDecoration(
                color: controller.pagedItems.indexOf(unit).isEven
                    ? Colors.white
                    : Colors.grey.shade50,
              ),
              children: [
                buildBodyCell(
                  (controller.pagedItems.indexOf(unit) + 1).toString(),
                  bodyStyle,
                ),
                buildBodyCell(unit.name, bodyStyle),
                buildBodyCell(unit.parentUnitName, bodyStyle),
                buildBodyCell(quantity, bodyStyle),
                buildCheckboxCell(unit.isMainUnit),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }
}