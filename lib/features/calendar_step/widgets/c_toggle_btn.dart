import 'package:flutter/material.dart';
import 'package:japanese_voca/config/colors.dart';

class CToggleBtn extends StatelessWidget {
  const CToggleBtn({
    super.key,
    required this.toggle,
    required this.value,
    required this.label,
  });

  final String label;
  final Function(bool) toggle;
  final bool value;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.mainColor,
        ),
      ),
      trailing: ToggleButtons(
        borderRadius: BorderRadius.circular(20),
        onPressed: (index) {
          index == 1 ? toggle(false) : toggle(true);
        },
        isSelected: [!value, value],
        children: [
          Text(
            'ON',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.mainColor,
            ),
          ),
          Text(
            'OFF',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.mainColor,
            ),
          )
        ],
      ),
    );
  }
}
