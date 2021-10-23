import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:innovers_exam/utils/colors.dart';
import 'package:innovers_exam/utils/styles.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CustumInput extends StatelessWidget {
  final GlobalKey? globalKey;
  final FocusNode? focusNode;
  final String hintText;
  final int? limit;
  final TextInputType? textInputType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  MaskTextInputFormatter textInputFormatter;
  final FormFieldSetter<String> onSaved;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String> validator;
  final TextEditingController controller;
  final bool? obscureText;
  final int? maxLines;
  CustumInput({
    this.globalKey,
    this.focusNode,
    this.textInputType,
    required this.hintText,
    this.suffixIcon,
    this.maxLines = 1,
    this.limit,
    required this.textInputFormatter,
    required this.onSaved,
    required this.validator,
    required this.controller,
    this.onChanged,
    this.prefixIcon,
    this.obscureText = false,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      key: globalKey,
      margin: EdgeInsets.only(bottom: 20),
      child: TextFormField(
        maxLines: maxLines,
        keyboardType: textInputType,
        inputFormatters: [
          LengthLimitingTextInputFormatter(limit),
          textInputFormatter
        ],
        focusNode: focusNode,
        cursorColor: AppColors.blueLight,
        validator: validator,
        onSaved: onSaved,
        onChanged: onChanged,
        controller: controller,
        obscureText: obscureText!,
        style: Theme.of(context).textTheme.bodyText1,
        decoration: InputDecoration(
            errorBorder: OutlineInputBorder(
                borderRadius: Corners.smBorder,
                borderSide: BorderSide(color: Colors.red, width: 1)),
            errorStyle: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(color: Colors.redAccent),
            focusColor: AppColors.grey,
            fillColor: AppColors.grey,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: Corners.smBorder,
                borderSide: BorderSide(color: AppColors.greyDark, width: 1)),
            isDense: true,
            hintStyle: Theme.of(context).textTheme.bodyText1,
            hintText: hintText,
            focusedBorder: OutlineInputBorder(
                borderRadius: Corners.smBorder,
                borderSide: BorderSide(color: AppColors.greyDark, width: 1)),
            enabledBorder: OutlineInputBorder(
                borderRadius: Corners.smBorder,
                borderSide: BorderSide(color: AppColors.greyDark, width: 1)),
            prefixIcon: prefixIcon == null
                ? null
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      prefixIcon!,
                    ],
                  ),
            suffixIcon: suffixIcon == null
                ? null
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      suffixIcon!,
                    ],
                  )),
      ),
    );
  }
}
