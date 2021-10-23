import 'package:flutter/material.dart';
import 'package:innovers_exam/utils/colors.dart';

class CustomRadioListTile<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final Widget title;
  final ValueChanged<T?> onChanged;

  const CustomRadioListTile({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final title = this.title;
    return InkWell(
      onTap: () => onChanged(value),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        height: 25,
        child: Row(
          children: [
            _customRadioButton,
            SizedBox(width: 12),
            title,
          ],
        ),
      ),
    );
  }

  Widget get _customRadioButton {
    final isSelected = value == groupValue;
    return Container(
      padding: EdgeInsets.all(5),
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.greyDark,
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? AppColors.blue : null,
        ),
      ),
    );
  }
}
