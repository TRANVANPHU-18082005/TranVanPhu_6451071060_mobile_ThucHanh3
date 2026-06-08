import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum HeaderAction { add, edit }

class ExpandableMenuItem extends StatelessWidget {
  final String iconPath;
  final String title;
  final bool isExpanded;
  final HeaderAction headerAction;
  final VoidCallback onHeaderTap;
  final VoidCallback onIconTap;
  final Widget? expandedContent;

  const ExpandableMenuItem({
    super.key,
    required this.iconPath,
    required this.title,
    required this.isExpanded,
    required this.headerAction,
    required this.onHeaderTap,
    required this.onIconTap,
    this.expandedContent,
  });

  @override
  Widget build(BuildContext context) {
    bool isEdit = headerAction == HeaderAction.edit;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row tiêu đề
          GestureDetector(
            onTap: onHeaderTap,
            behavior: HitTestBehavior.opaque,
            child: Row(
              children: [
                SvgPicture.asset(iconPath, width: 24, height: 24),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E1A34),
                    ),
                  ),
                ),
                // Icon Add hoặc Edit
                GestureDetector(
                  onTap: onIconTap,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: isEdit ? Colors.transparent : const Color(0xFFFFF0EC),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        isEdit ? 'assets/icons/Edit.svg' : 'assets/icons/Add.svg',
                        width: isEdit ? 16 : 12,
                        height: isEdit ? 16 : 12,
                        // Thêm màu cam cho icon edit cho giống thiết kế
                        colorFilter: isEdit ? const ColorFilter.mode(Colors.orange, BlendMode.srcIn) : null,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Phần nội dung mở rộng (sổ xuống)
          if (isExpanded && expandedContent != null) ...[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Divider(color: Colors.black12, height: 1),
            ),
            expandedContent!,
          ],
        ],
      ),
    );
  }
}
