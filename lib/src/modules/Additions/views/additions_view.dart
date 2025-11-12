import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_click/src/shared/constants/app_colors.dart';
import 'package:one_click/src/shared/widgets/content_header.dart';
import 'package:one_click/src/modules/home/controllers/home_controller.dart'; 
import '../controllers/additions_controller.dart';
// (تم حذف استيراد menu_model)

class AdditionsView extends GetView<AdditionsController> {
  const AdditionsView({super.key});

  @override
  Widget build(BuildContext context) {
    // للتحكم في السكرول الرئيسي
    final HomeController homeController = Get.find<HomeController>();

    return SingleChildScrollView(
      controller: homeController.scrollController,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: ContentHeader(), //
          ),
          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                _buildPageTitleBar(), // العنوان والفلتر
                const SizedBox(height: 20),

                _buildFilterArea(), // منطقة الفلترة (مخفية افتراضياً)

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
                        // Obx سيراقب التغييرات في controller.additions
                        child: Obx(() => _buildCustomTable()),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: _buildPaginationControls(), // أزرار ترقيم الصفحات
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

  // شريط العنوان وزر الفلتر
  Widget _buildPageTitleBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // --- (تعديل) ---
        const Text(
          'الاضافات', // تم تغيير العنوان هنا
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primary, //
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
            backgroundColor: AppColors.primary, //
            foregroundColor: Colors.white,
          ),
          child: const Icon(Icons.filter_list, size: 20),
        ),
      ],
    );
  }

  // منطقة الفلترة (الكود مأخوذ كما هو من شاشة المنيوهات)
  Widget _buildFilterArea() {
    return Obx(() {
      return Visibility(
        visible: controller.isFilterVisible.value,
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05), 
                blurRadius: 5
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // ... (يمكنك إضافة حقول الفلترة هنا لاحقاً) ...
              // مثال لحقل فلترة
              const Text('اسم الاضافة', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: '...ابحث بالاسم',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10)
                ),
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton.icon(
                  onPressed: () { /* TODO: Apply filter */ },
                  icon: const Icon(Icons.search, color: Colors.white),
                  label: const Text('بحث'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[600],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    textStyle: const TextStyle(fontWeight: FontWeight.bold)
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }


  // --- (تعديل) دالة بناء الجدول باستخدام Table ---
  Widget _buildCustomTable() {
    const TextStyle headerStyle = TextStyle(
      fontSize: 14.0,
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontFamily: 'Cairo',
    );

    const TextStyle bodyStyle = TextStyle(
      fontSize: 14.0,
      color: Colors.black87,
      fontFamily: 'Cairo',
      fontWeight: FontWeight.bold,
    );

    final Color borderColor = Colors.grey.shade300;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Table(
        // --- (تعديل) 3 أعمدة ---
        columnWidths: const {
          0: FixedColumnWidth(60.0),  // #
          1: FixedColumnWidth(220.0), // اسم الاضافة
          2: FixedColumnWidth(100.0),
          3: FixedColumnWidth(140.0), // السعر
        },
        border: TableBorder.all(
          color: borderColor,
          width: 1.0,
          borderRadius: BorderRadius.zero,
        ),

        children: [
          // --- (تعديل) رأس الجدول (3 أعمدة) ---
          TableRow(
            decoration: const BoxDecoration(
              color: AppColors.primary, //
            ),
            children: [
              _buildHeaderCell('#', headerStyle),
              _buildHeaderCell('اسم الاضافة', headerStyle),
              _buildHeaderCell('السعر', headerStyle),
              _buildHeaderCell('أساسية', headerStyle), 
            ],
          ),

          // --- (تعديل) صفوف البيانات (من الكنترولر) ---
          ...controller.additions.map((addition) {
            return TableRow(
              decoration: BoxDecoration(
                color: controller.additions.indexOf(addition).isEven
                    ? Colors.white
                    : Colors.grey.shade50,
              ),
              children: [
                _buildBodyCell(addition.id, bodyStyle),
                _buildBodyCell(addition.name, bodyStyle),
                _buildBodyCell(addition.price, bodyStyle),
                _buildBodyCell(addition.isPrimary ? 'نعم' : 'لا', bodyStyle), // عرض السعر
              ],
            );
          }).toList(),
        ],
      ),
    );
  }


  // (دوال مساعدة لبناء خلايا الـ Table - لا تحتاج تعديل)
  TableCell _buildHeaderCell(String text, TextStyle style) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
        child: Text(
          text,
          style: style,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  TableCell _buildBodyCell(String text, TextStyle style) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
        child: Text(
          text,
          style: style,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // (دالة ترقيم الصفحات - لا تحتاج تعديل)
  Widget _buildPaginationControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildPageButton(
          onTap: () {},
          child: const Text('الأخير'),
        ),
        const SizedBox(width: 8),
        _buildPageButton(
          isSelected: true,
          onTap: () {},
          child: const Text('1'),
        ),
        const SizedBox(width: 8),
        _buildPageButton(
          onTap: () {},
          child: const Text('الأول'),
        ),
      ],
    );
  }

  Widget _buildPageButton({
    required Widget child,
    required VoidCallback onTap,
    bool isSelected = false,
  }) {
    return Material(
      color: isSelected ? AppColors.primary : Colors.grey[200], //
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: DefaultTextStyle(
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}