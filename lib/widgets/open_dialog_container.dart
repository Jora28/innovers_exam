import 'package:flutter/material.dart';
import 'package:innovers_exam/utils/colors.dart';
import 'package:innovers_exam/utils/styles.dart';

class OpenDialogContainer extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function()? onTap;
  const OpenDialogContainer({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        height: 50,
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.greyDark),
            color: AppColors.grey,
            borderRadius:Corners.smBorder),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text),
            Icon(
              icon,
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}
