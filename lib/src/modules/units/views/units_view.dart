import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_click/src/shared/constants/app_colors.dart'; //
import 'package:one_click/src/shared/widgets/content_header.dart'; //
import 'package:one_click/src/modules/home/controllers/home_controller.dart'; //
import '../controllers/units_controller.dart'; //

class UnitsView extends GetView<UnitsController> {
  const UnitsView({super.key});

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

                // منطقة الفلترة (تظهر وتختفي)
                _buildFilterArea(),

                // --- الديزاين بالحواف الدائرية ---
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
                        // الجدول بالـ 5 أعمدة
                        child: Obx(() => _buildDataTable()), 
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: _buildPaginationControls(), // أزرار الصفحات
                      ),
                    ],
                  ),
                ),
                // --- نهاية الديزاين ---
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // دالة العنوان والفلتر (كما هي)
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
            color: AppColors.primary,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            controller.toggleFilterVisibility(); //
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

  // دالة الفلترة (كما هي)
  Widget _buildFilterArea() {
    return Obx(() {
      return Visibility(
        visible: controller.isFilterVisible.value, //
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // ... (محتوى الفلتر كما هو)
              const Text(
                'المحافظة',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: '...اختار',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton.icon(
                  onPressed: () {
                    /* TODO: Apply filter */
                  },
                  icon: const Icon(Icons.search, color: Colors.white),
                  label: const Text('بحث'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[600],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 12,
                    ),
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  // دالة بناء الجدول (مع التعديل)
  Widget _buildDataTable() {
    const TextStyle headerStyle = TextStyle(
      fontSize: 13.0, 
      color: Colors.white,
      fontWeight: FontWeight.bold, // (العناوين bold)
      fontFamily: 'Cairo',
    );

    
    const TextStyle bodyStyle = TextStyle(
      fontSize: 12.0, 
      color: Colors.black87,
      fontFamily: 'Cairo',
      fontWeight: FontWeight.bold, 
    );
    

    final Color borderColor = Colors.grey.shade300;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Table(
        columnWidths: const {
          0: FixedColumnWidth(50.0),  // #
          1: FixedColumnWidth(120.0), // اسم الوحده
          2: FixedColumnWidth(150.0), // اسم الوحده الاساسية
          3: FixedColumnWidth(160.0), // الكميه من الوحده الاساسية
          4: FixedColumnWidth(140.0), // وحده اساسيه ؟
        },
        border: TableBorder.all(
          color: borderColor,
          width: 1.0,
          borderRadius: BorderRadius.zero, 
        ),
        children: [
          // رأس الجدول
          TableRow(
            decoration: const BoxDecoration(
              color: AppColors.primary,
            ),
            children: [
              _buildHeaderCell('#', headerStyle),
              _buildHeaderCell('اسم الوحده', headerStyle),
              _buildHeaderCell('اسم الوحده الاساسية', headerStyle),
              _buildHeaderCell('الكميه من الوحده الاساسية', headerStyle),
              _buildHeaderCell('وحده اساسيه ؟', headerStyle),
            ],
          ),
          
          // صفوف البيانات
          ...controller.units.map((unit) { //
            return TableRow(
              decoration: BoxDecoration(
                color: controller.units.indexOf(unit).isEven //
                    ? Colors.white
                    : Colors.grey.shade50, 
              ),
              children: [
                _buildBodyCell(unit.id.toString(), bodyStyle), //
                _buildBodyCell(unit.name, bodyStyle), //
                _buildBodyCell(unit.baseUnitName, bodyStyle), //
                _buildBodyCell(unit.quantity.toString(), bodyStyle), //
                _buildCheckboxCell(unit.isBaseUnit), //
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  // الدوال المساعدة (كما هي)
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

  TableCell _buildCheckboxCell(bool value) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Center(
        child: Checkbox(
          fillColor: WidgetStateProperty.all(AppColors.primary),
          value: value,
          onChanged: (val) {}, 
        ),
      ),
    );
  }

  // دوال أزرار الصفحات (كما هي)
  Widget _buildPaginationControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildPageButton(onTap: () {}, child: const Text('الأخير')),
        const SizedBox(width: 8),
        _buildPageButton(
          isSelected: true,
          onTap: () {},
          child: const Text('1'),
        ),
        const SizedBox(width: 8),
        _buildPageButton(onTap: () {}, child: const Text('الأول')),
      ],
    );
  }

  Widget _buildPageButton({
    required Widget child,
    required VoidCallback onTap,
    bool isSelected = false,
  }) {
    return Material(
      color: isSelected ? AppColors.primary : Colors.grey[200],
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