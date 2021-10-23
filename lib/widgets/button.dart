import 'package:flutter/material.dart';
import 'package:innovers_exam/utils/colors.dart';

class CustumButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;

  const CustumButton({
    Key? key,
    required this.onPressed,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      
        onPressed: onPressed,
        // style: Theme.of(context).elevatedButtonTheme.style,
        child: Container(
          child: Center(
              child: Text(
            buttonText,
            style: Theme.of(context)
                .textTheme
                .button
                ?.copyWith(color: AppColors.white),
          )),
        ));
  }
}
