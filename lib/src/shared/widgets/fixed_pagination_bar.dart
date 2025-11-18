import 'package:flutter/material.dart';
import 'package:one_click/src/shared/constants/app_colors.dart';
import 'package:one_click/src/shared/widgets/table_helpers.dart';

class FixedPaginationBar extends StatelessWidget {
  final int totalPages;
  final int currentPage;
  final Function(int) onPageChanged;
  final VoidCallback onScrollToTop;

  const FixedPaginationBar({
    super.key,
    required this.totalPages,
    required this.currentPage,
    required this.onPageChanged,
    required this.onScrollToTop,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, -2),
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          // 1. زر الصعود (ثابت أقصى اليمين)
          SizedBox(
            height: 40,
            width: 40,
            child: FloatingActionButton(
              onPressed: onScrollToTop,
              backgroundColor: AppColors.primary,
              heroTag: null,
              elevation: 2,
              child: const Icon(
                Icons.arrow_upward,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // 2. زر "الأول" (ثابت بجوار السهم)
          buildPageButton(
            onTap: () => onPageChanged(1),
            child: const Text(
              'الأول',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(width: 8),

          // 3. منطقة أرقام الصفحات (هذا الجزء فقط هو القابل للسحب)
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true, // (اختياري: لضبط اتجاه السحب مع العربي)
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(totalPages, (index) {
                  final pageNum = index + 1;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: buildPageButton(
                      isSelected: currentPage == pageNum,
                      onTap: () => onPageChanged(pageNum),
                      child: Text('$pageNum'),
                    ),
                  );
                }),
              ),
            ),
          ),

          const SizedBox(width: 8),

          // 4. زر "الأخير" (ثابت أقصى اليسار)
          buildPageButton(
            onTap: () => onPageChanged(totalPages),
            child: const Text(
              'الأخير',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
